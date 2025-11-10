# tradingbot_bybit.py
# Advanced Pattern-Based Day Trading Bot — Bybit USDT Perpetual (One-Way)
# Top-down MTF (1D/4H) → trigger di 15m (inside/engulf/swing-break) + Stoch 5-3-3
# Risk mgmt: base_risk%, min RR, Partial TP 50% @1R → SL ke BE + Trailing (1R)
# Eksekusi: LIMIT-IOC agresif + MARKET fallback (lebih stabil di Bybit v5)
#
# Catatan:
# - Bybit via CCXT: markets tipe "swap" (linear USDT perp). set_sandbox_mode(True) bila testnet.
# - One-Way position mode (bukan hedge) diset otomatis.
# - Banyak bagian kompatibel dengan kode Binance kamu, tapi STOP_MARKET diganti strategi entry yg stabil.
#
# (c) kamu — silakan modifikasi

from __future__ import annotations

import os, time, argparse, re, math, random
from dataclasses import dataclass, field
from typing import Dict, Any, List, Optional, Tuple, Callable

import numpy as np
import pandas as pd
import ccxt
from dotenv import load_dotenv

# ================== POLICIES & SETTINGS ==================
@dataclass
class TriggerPolicy:
    stoch_long_max: float = 90.0
    stoch_short_min: float = 10.0
    swing_n: int = 3
    allow_inside: bool = True
    allow_engulf: bool = True
    allow_breakout: bool = True
    allow_reversal: bool = True

@dataclass
class RiskPolicy:
    base_risk_pct: float = 8.0
    min_rr: float = 2.0
    leverage: int = 3
    partial_tp_pct: float = 0.5
    trail_dist_r: float = 1.0
    active_window_h4: int = 10

@dataclass
class Settings:
    paper: bool = False
    verbose: bool = False
    symbols: List[str] = field(default_factory=list)
    htf: str = "1d"
    mtf: str = "4h"
    ltf: str = "15m"
    corr_mode: str = "off"
    risk_policy: RiskPolicy = field(default_factory=RiskPolicy)
    trigger_policy: TriggerPolicy = field(default_factory=TriggerPolicy)

# ================== RETRY UTILS ==================
BINANCE_ERROR_CODE_RE = re.compile(r"code\":?\s*(?:\"|)?(-?\d+)")  # masih berguna untuk parsing pesan generik

def parse_ccxt_code(err: Exception) -> Optional[int]:
    # Bybit biasanya tidak memakai kode -2019 dsb, tapi tetap kita ekstrak angka jika ada.
    s = str(err)
    m = BINANCE_ERROR_CODE_RE.search(s)
    if m:
        try:
            return int(m.group(1))
        except Exception:
            return None
    if "Timeout" in s or "timed out" in s.lower():
        return -1007
    return None

class Retry:
    def __init__(self, tries=4, base_delay=0.6, max_delay=6.0, jitter=0.35):
        self.tries = tries
        self.base_delay = base_delay
        self.max_delay = max_delay
        self.jitter = jitter

    def __call__(self, fn: Callable, *, on_error: Optional[Callable[[Exception], bool]] = None):
        attempt = 0
        last_exc = None
        while attempt < self.tries:
            try:
                return fn()
            except Exception as e:
                last_exc = e
                retryable = True
                if on_error is not None:
                    try:
                        retryable = on_error(e)
                    except Exception:
                        pass
                if not retryable:
                    break
                delay = min(self.base_delay * (1.7 ** attempt) * (1 + random.random()*self.jitter), self.max_delay)
                print(f"[RETRY] {fn.__name__} attempt={attempt+1}/{self.tries} sleep={delay:.2f}s")
                time.sleep(delay)
                attempt += 1
        if last_exc:
            raise last_exc
        return None

# ================== EXCHANGE WRAPPER (BYBIT) ==================
class BybitExchangeWrapper:
    """ccxt.bybit wrapper untuk USDT-Perp (linear swap), filter, posisi & order helpers."""
    def __init__(self, settings: Settings):
        load_dotenv()
        self.s = settings

        use_testnet = os.getenv("BYBIT_USE_TESTNET", "false").lower() in ("1","true","yes","on")
        api_key = os.getenv("BYBIT_API_KEY")
        api_secret = os.getenv("BYBIT_API_SECRET")

        if not self.s.paper and (not api_key or not api_secret):
            raise RuntimeError("Live mode requires BYBIT_API_KEY & BYBIT_API_SECRET in .env")

        self.ex = ccxt.bybit({
            "apiKey": api_key,
            "secret": api_secret,
            "enableRateLimit": True,
            "timeout": 20000,
            "options": {
                "defaultType": "swap",   # USDT perpetual linear swap
            },
        })

        # Testnet toggle
        try:
            self.ex.set_sandbox_mode(use_testnet)
        except Exception as e:
            print(f"[WARN] set_sandbox_mode warn: {e}")

        # Load markets
        Retry()(self.ex.load_markets)
        self._symbols = set(self.ex.symbols or [])
        self._alias_cache: Dict[str, str] = {}
        self._ohlcv_cache: Dict[Tuple[str,str], pd.DataFrame] = {}
        print(f"[INFO] Connected to Bybit {'TESTNET' if use_testnet else 'MAINNET'} SWAP. Markets={len(self._symbols)}")

        # Pastikan One-Way (bukan hedge)
        try:
            # False = one-way, True = hedge (ccxt unify)
            self.ex.set_position_mode(False)
            if self.s.verbose:
                print("[INFO] Position mode set to ONE-WAY.")
        except Exception as e:
            print(f"[WARN] set_position_mode warn: {e}")

    # --- symbol normalize ---
    def _normalize_symbol(self, sym: str) -> str:
        if sym in self._alias_cache:
            return self._alias_cache[sym]
        if sym in self._symbols:
            self._alias_cache[sym] = sym; return sym
        # Bybit biasanya pakai "BTC/USDT:USDT"? ccxt sudah normalisasi; coba fallback plain.
        # Kita biarkan as-is kalau tidak ketemu; ccxt akan melempar error jika salah.
        self._alias_cache[sym] = sym
        return sym

    # --- market info helpers ---
    def market(self, sym: str) -> dict:
        return self.ex.market(self._normalize_symbol(sym))

    def price_tick(self, sym: str) -> float:
        m = self.market(sym)
        # ccxt menyajikan precision price / tickSize di m['precision']['price'] atau m['info'].
        prec = m.get("precision", {}).get("price")
        if prec is not None:
            return 10 ** (-(prec or 0))
        # fallback kecil
        return 0.01

    def lot_step(self, sym: str) -> float:
        m = self.market(sym)
        prec = m.get("precision", {}).get("amount")
        if prec is not None:
            return 10 ** (-(prec or 0))
        return 0.001

    def clamp_qty_step(self, sym: str, qty: float) -> float:
        step = self.lot_step(sym) or 0.0
        if step <= 0:
            return float(self.ex.amount_to_precision(self._normalize_symbol(sym), qty))
        q = math.floor(max(0.0, qty) / step) * step
        return float(self.ex.amount_to_precision(self._normalize_symbol(sym), q))

    # --- basic ops ---
    def fetch_ohlcv(self, sym: str, timeframe: str, limit: int = 500) -> pd.DataFrame:
        s = self._normalize_symbol(sym)
        ohlcv = Retry()(lambda: self.ex.fetch_ohlcv(s, timeframe=timeframe, limit=limit))
        df = pd.DataFrame(ohlcv, columns=["timestamp","open","high","low","close","volume"])
        df["timestamp"] = pd.to_datetime(df["timestamp"], unit="ms", utc=True)
        out = df.set_index("timestamp")[["open","high","low","close"]].astype(float)
        return out

    def ensure_leverage(self, sym: str, lev: int | None = None):
        s = self._normalize_symbol(sym)
        try:
            Retry()(lambda: self.ex.set_leverage(int(lev or self.s.risk_policy.leverage), s))
        except Exception as e:
            print(f"[WARN] set_leverage warn {sym}: {e}")

    def ticker_price(self, sym: str) -> float:
        s = self._normalize_symbol(sym)
        t = Retry()(lambda: self.ex.fetch_ticker(s))
        return float(t.get("last") or t.get("info", {}).get("lastPrice") or 0.0)

    def balance_free_usdt(self) -> float:
        bal = Retry()(self.ex.fetch_balance)
        free = bal.get("free", {}).get("USDT")
        if free is None:
            free = bal.get("total", {}).get("USDT", 0.0)
        return float(free or 0.0)

    # --- positions ---
    def fetch_position(self, sym: str) -> Optional[dict]:
        s = self._normalize_symbol(sym)
        try:
            ps = Retry()(lambda: self.ex.fetch_positions([s]))
        except Exception:
            ps = Retry()(self.ex.fetch_positions)
        # Bybit kadang kembalikan 2 sisi. Kita cari net yang aktif.
        for p in (ps or []):
            if p.get("symbol") == s:
                return p
        return None

    def current_position_qty_side(self, sym: str) -> Tuple[float, Optional[str]]:
        p = self.fetch_position(sym)
        if not p:
            return 0.0, None
        contracts = float(p.get("contracts") or 0.0)
        side = p.get("side")
        qty = abs(float(contracts or 0.0))
        if qty <= 0:
            return 0.0, None
        return qty, side.upper() if isinstance(side, str) else None

    # --- order helpers ---
    def _aggressive_price(self, sym: str, side: str, last: float) -> float:
        tick = float(self.price_tick(sym)) or 0.01
        # bid-ask tidak tersedia → gunakan offset beberapa tick
        if side.lower()=="sell":
            price = max(0.0, last - 10*tick)
        else:
            price = last + 10*tick
        # round ke tick
        return float(round(price / tick) * tick)

    def limit_ioc_aggressive(self, sym: str, side: str, qty: float, reduce_only: bool = False):
        s = self._normalize_symbol(sym)
        last = float(self.ticker_price(s))
        tick = float(self.price_tick(s)) or 0.01
        price = self._aggressive_price(s, side, last)
        q = self.clamp_qty_step(s, qty)
        if q <= 0:
            raise ValueError(f"Qty after step clamp is 0 for {s}")
        params = {"timeInForce": "IOC", "reduceOnly": reduce_only}
        return Retry()(lambda: self.ex.create_order(s, "limit", side.lower(), q, price, params))

    def market_reduce_only(self, sym: str, side: str, qty: float):
        s = self._normalize_symbol(sym)
        q = self.clamp_qty_step(s, qty)
        params = {"reduceOnly": True}
        if side.lower() == "buy":
            return Retry()(lambda: self.ex.create_market_buy_order(s, q, params))
        else:
            return Retry()(lambda: self.ex.create_market_sell_order(s, q, params))

    def market_order(self, sym: str, side: str, qty: float, reduce_only: bool=False):
        s = self._normalize_symbol(sym)
        q = self.clamp_qty_step(s, qty)
        params = {"reduceOnly": reduce_only}
        if side.lower() == "buy":
            return Retry()(lambda: self.ex.create_market_buy_order(s, q, params))
        else:
            return Retry()(lambda: self.ex.create_market_sell_order(s, q, params))

    # BEST-EFFORT close path
    def best_effort_close(self, sym: str, desired_qty: float, pos_side: str) -> bool:
        if desired_qty <= 0:
            return True
        exch_qty, exch_side = self.current_position_qty_side(sym)
        if exch_qty <= 0 or not exch_side:
            return True
        if (pos_side.upper() == "LONG" and exch_side != "LONG") or (pos_side.upper() == "SHORT" and exch_side != "SHORT"):
            return True
        order_side = "sell" if pos_side.upper() == "LONG" else "buy"
        step = self.lot_step(sym) or 0.0
        qty = min(desired_qty, exch_qty)
        if step > 0:
            qty = max(0.0, math.floor(qty / step) * step)
        qty = self.clamp_qty_step(sym, qty)
        if qty <= 0:
            return True
        try:
            self.market_reduce_only(sym, order_side, qty)
            return True
        except Exception as e:
            # fallback LIMIT-IOC reduce-only
            try:
                self.limit_ioc_aggressive(sym, order_side, qty, reduce_only=True)
                return True
            except Exception as e2:
                print(f"[WARN] {sym} close failed both market & limit-IOC: {e2}")
                return False

# ================== INDICATORS ==================
def atr(df: pd.DataFrame, length=14):
    high, low, close = df["high"], df["low"], df["close"]
    prev_close = close.shift(1)
    tr = pd.concat([(high-low), (high-prev_close).abs(), (low-prev_close).abs()], axis=1).max(axis=1)
    return tr.ewm(alpha=1/length, adjust=False).mean()

def stoch_kd_533(df: pd.DataFrame):
    low_min = df["low"].rolling(5).min()
    high_max = df["high"].rolling(5).max()
    k_raw = 100 * (df["close"] - low_min) / (high_max - low_min + 1e-12)
    k_smooth = k_raw.rolling(3).mean()
    d_line = k_smooth.rolling(3).mean()
    return k_smooth, d_line

# ================== PATTERN & TRIGGERS ==================
def inside_bar(df: pd.DataFrame) -> bool:
    if len(df) < 2: return False
    a, b = df.iloc[-2], df.iloc[-1]
    return (b["high"] < a["high"]) and (b["low"] > a["low"])

def engulfing(df: pd.DataFrame, direction: str) -> bool:
    if len(df) < 2: return False
    a, b = df.iloc[-2], df.iloc[-1]
    if direction == "LONG":
        return (a["close"] < a["open"]) and (b["close"] > b["open"]) and (b["close"] >= a["open"]) and (b["open"] <= a["close"])
    else:
        return (a["close"] > a["open"]) and (b["close"] < b["open"]) and (b["close"] <= a["open"]) and (b["open"] >= a["close"])

def swing_break(df: pd.DataFrame, direction: str, n=3) -> bool:
    if len(df) < n+1: return False
    w = df.iloc[-(n+1):-1]
    hi, lo = w["high"].max(), w["low"].min()
    cls = df["close"].iloc[-1]
    return (cls > hi) if direction=="LONG" else (cls < lo)

def find_swing_points(df: pd.DataFrame, window=3) -> pd.DataFrame:
    out = df.copy()
    if len(out) < (window*2+1):
        out["swing_high"] = np.nan; out["swing_low"] = np.nan; return out
    out["swing_high"] = out["high"].where(out["high"] == out["high"].rolling(window*2+1, center=True).max())
    out["swing_low"]  = out["low"].where(out["low"]  == out["low"].rolling(window*2+1, center=True).min())
    return out

def stoch_divergence(df: pd.DataFrame, k_series: pd.Series, idx1, idx2, bullish=True) -> bool:
    try:
        p1, p2 = df.loc[idx1], df.loc[idx2]
        k1, k2 = k_series.loc[idx1], k_series.loc[idx2]
    except Exception:
        return False
    return ((p2["low"] <= p1["low"]) and (k2 > k1)) if bullish else ((p2["high"] >= p1["high"]) and (k2 < k1))

def setup_tier1(df_mtf: pd.DataFrame) -> Optional[Dict[str,Any]]:
    if df_mtf is None or len(df_mtf) < 60: return None
    df = df_mtf.copy()
    k, _ = stoch_kd_533(df)
    swings = find_swing_points(df, window=3)
    lows, highs = swings["swing_low"].dropna(), swings["swing_high"].dropna()
    tol = 0.035
    if len(lows) >= 2:
        v1_idx, v2_idx = lows.index[-2], lows.index[-1]
        v1, v2 = lows.iloc[-2], lows.iloc[-1]
        if v1>0 and abs(v1-v2)/v1 < tol and stoch_divergence(df, k, v1_idx, v2_idx, bullish=True):
            neckline = df["high"].loc[v1_idx:v2_idx].max()
            height = neckline - min(v1, v2)
            return {"tier":1,"type":"Double Bottom","direction":"LONG","sl": float(min(v1, v2)),
                    "tp": float(neckline+height), "break_level": float(neckline)}
    if len(highs) >= 2:
        h1_idx, h2_idx = highs.index[-2], highs.index[-1]
        h1, h2 = highs.iloc[-2], highs.iloc[-1]
        if h1>0 and abs(h1-h2)/h1 < tol and stoch_divergence(df, k, h1_idx, h2_idx, bullish=False):
            neckline = df["low"].loc[h1_idx:h2_idx].min()
            height = max(h1, h2) - neckline
            return {"tier":1,"type":"Double Top","direction":"SHORT","sl": float(max(h1, h2)),
                    "tp": float(neckline-height), "break_level": float(neckline)}
    return None

def setup_tier2(df_mtf: pd.DataFrame) -> Optional[Dict[str,Any]]:
    if df_mtf is None or len(df_mtf) < 120: return None
    recent = df_mtf.tail(220).copy()
    pole_change = 0.05
    flagpole_height, pole_end_idx, pole_dir = None, None, None
    for i in range(0, len(recent)-19):
        w = recent.iloc[i:i+20]
        chg = (w["close"].iloc[-1] / w["close"].iloc[0]) - 1.0
        if chg > pole_change:
            flagpole_height = w["high"].max()-w["low"].min(); pole_end_idx = w.index[-1]; pole_dir = "UP"; break
        if chg < -pole_change:
            flagpole_height = w["high"].max()-w["low"].min(); pole_end_idx = w.index[-1]; pole_dir = "DN"; break
    if pole_end_idx is not None:
        cons = recent.loc[pole_end_idx:]
        if 10 <= len(cons) <= 120:
            swings = find_swing_points(cons, window=3)
            highs, lows = swings["swing_high"].dropna(), swings["swing_low"].dropna()
            if len(highs)>=2 and len(lows)>=2:
                xh, xl = np.arange(len(highs)), np.arange(len(lows))
                up = np.polyfit(xh, highs.values, 1); lo = np.polyfit(xl, lows.values, 1)
                x_pred = len(cons)-1
                breakout_up = up[0]*x_pred + up[1]
                breakout_lo = lo[0]*x_pred + lo[1]
                close_now = float(cons["close"].iloc[-1])
                if pole_dir=="UP" and up[0]<0 and lo[0]<0 and abs(up[0]-lo[0])<abs(lo[0])*0.9:
                    if close_now > breakout_up:
                        return {"tier":2,"type":"Bull Flag","direction":"LONG",
                                "sl": float(cons["low"].min()),
                                "tp": float(close_now+flagpole_height),
                                "break_level": float(breakout_up)}
                if pole_dir=="DN" and up[0]>0 and lo[0]>0 and abs(up[0]-lo[0])<abs(lo[0])*0.9:
                    if close_now < breakout_lo:
                        return {"tier":2,"type":"Bear Flag","direction":"SHORT",
                                "sl": float(cons["high"].max()),
                                "tp": float(close_now-flagpole_height),
                                "break_level": float(breakout_lo)}
    # Wedge
    w = df_mtf.tail(180)
    swings = find_swing_points(w, window=3)
    highs, lows = swings["swing_high"].dropna(), swings["swing_low"].dropna()
    if len(highs)>=3 and len(lows)>=3:
        xh, xl = np.arange(len(highs)), np.arange(len(lows))
        up = np.polyfit(xh, highs.values, 1); lo = np.polyfit(xl, lows.values, 1)
        close_now = float(w["close"].iloc[-1])
        if up[0] < 0 and lo[0] < 0:  # falling wedge → LONG
            upper_line = up[0]*len(highs)+up[1]
            if close_now > upper_line:
                return {"tier":2,"type":"Falling Wedge","direction":"LONG",
                        "sl": float(min(lows.values[-3:])),
                        "tp": float(close_now + (w['high'].max()-w['low'].min())*0.6),
                        "break_level": float(upper_line)}
        if up[0] > 0 and lo[0] > 0:  # rising wedge → SHORT
            lower_line = lo[0]*len(lows)+lo[1]
            if close_now < lower_line:
                return {"tier":2,"type":"Rising Wedge","direction":"SHORT",
                        "sl": float(max(highs.values[-3:])),
                        "tp": float(close_now - (w['high'].max()-w['low'].min())*0.6),
                        "break_level": float(lower_line)}
    return None

def setup_sr_zone(df_mtf: pd.DataFrame) -> Optional[Dict[str,Any]]:
    if df_mtf is None or len(df_mtf)<60: return None
    df = df_mtf.tail(220)
    A = float(atr(df, 14).iloc[-1])
    if not np.isfinite(A) or A<=0: return None
    swings = find_swing_points(df, window=3)
    highs = swings["swing_high"].dropna().values
    lows  = swings["swing_low"].dropna().values
    if len(highs)==0 and len(lows)==0: return None
    price = float(df["close"].iloc[-1])
    tol = 0.7 * A
    cand = []
    if len(highs):
        nh = min(highs, key=lambda x: abs(price-x))
        if abs(price-nh) <= tol:
            cand.append((abs(price-nh), {"tier":2,"type":"SR-Zone","zone":"RESISTANCE",
                                         "break_level":float(nh), "direction":None, "sl":None, "tp":None}))
    if len(lows):
        nl = min(lows, key=lambda x: abs(price-x))
        if abs(price-nl) <= tol:
            cand.append((abs(price-nl), {"tier":2,"type":"SR-Zone","zone":"SUPPORT",
                                         "break_level":float(nl), "direction":None, "sl":None, "tp":None}))
    if not cand: return None
    cand.sort(key=lambda x:x[0])
    return cand[0][1]

def choose_setup(df_mtf: pd.DataFrame) -> Optional[Dict[str,Any]]:
    for fn in (setup_tier1, setup_tier2):
        s = fn(df_mtf)
        if s: return s
    return setup_sr_zone(df_mtf)

# ====== LTF TRIGGERS (M15) ======
def _near_level(df: pd.DataFrame, level: float, mult_atr=0.5) -> bool:
    A = float(atr(df, 14).iloc[-1])
    if not np.isfinite(A) or A<=0: return False
    lo, hi = float(df["low"].iloc[-1]), float(df["high"].iloc[-1])
    tol = mult_atr * A
    return (level - tol) <= hi and (level + tol) >= lo

def ltf_trigger_decision(df_ltf: pd.DataFrame, setup: Dict[str,Any], trig: TriggerPolicy) -> Optional[Dict[str,Any]]:
    k, d = stoch_kd_533(df_ltf); k_last, d_last = float(k.iloc[-1]), float(d.iloc[-1])
    def mom_ok(dirn: str) -> bool:
        return (k_last > d_last and k_last < trig.stoch_long_max) if dirn=="LONG" else (k_last < d_last and k_last > trig.stoch_short_min)

    level = float(setup.get("break_level") or 0.0)
    zone  = setup.get("zone")
    close_now = float(df_ltf["close"].iloc[-1])

    if setup.get("direction") in ("LONG","SHORT") and zone is None:
        dirn = setup["direction"]
        ok_price = (close_now > level) if (dirn=="LONG" and level>0) else ((close_now < level) if (dirn=="SHORT" and level>0) else False)
        ok_candle = (trig.allow_reversal and inside_bar(df_ltf)) or \
                    (trig.allow_reversal and engulfing(df_ltf, dirn)) or \
                    (trig.allow_breakout and swing_break(df_ltf, dirn, n=trig.swing_n))
        if (ok_price or ok_candle) and mom_ok(dirn):
            return {"direction": dirn, "reason": f"LTF confirm ({'price>lvl' if ok_price else 'candle'})"}
        return None

    if zone in ("RESISTANCE","SUPPORT"):
        near = _near_level(df_ltf, level, mult_atr=0.5)
        if trig.allow_breakout:
            if zone=="RESISTANCE" and close_now > level and df_ltf["close"].iloc[-2] <= level and mom_ok("LONG"):
                return {"direction":"LONG","reason":"Breakout RES → LONG"}
            if zone=="SUPPORT" and close_now < level and df_ltf["close"].iloc[-2] >= level and mom_ok("SHORT"):
                return {"direction":"SHORT","reason":"Breakdown SUP → SHORT"}
        if trig.allow_reversal and near:
            if zone=="RESISTANCE":
                if engulfing(df_ltf, "SHORT") and mom_ok("SHORT"):
                    return {"direction":"SHORT","reason":"Reversal @RES (engulf)"}
                if inside_bar(df_ltf) and mom_ok("SHORT"):
                    return {"direction":"SHORT","reason":"Reversal @RES (inside)"}
            else:
                if engulfing(df_ltf, "LONG") and mom_ok("LONG"):
                    return {"direction":"LONG","reason":"Reversal @SUP (engulf)"}
                if inside_bar(df_ltf) and mom_ok("LONG"):
                    return {"direction":"LONG","reason":"Reversal @SUP (inside)"}
    return None

# ================== UTILS ==================
def timeframe_to_seconds(tf: str) -> int:
    m = re.match(r"^(\d+)([smhdw])$", tf.strip().lower())
    if not m: return 60
    n, u = int(m.group(1)), m.group(2)
    mult = {"s":1, "m":60, "h":3600, "d":86400, "w":604800}[u]
    return n * mult

# ================== BOT ==================
class Bot:
    def __init__(self, settings: Settings):
        self.s = settings
        self.exw = BybitExchangeWrapper(settings)
        self.open_positions: Dict[str, Dict[str, Any]] = {}
        self.pending_entries: Dict[str, Dict[str, Any]] = {}
        self._cooldown_until: Dict[str, float] = {}
        self._reentry_cooldown_until: Dict[Tuple[str,str], float] = {}
        self._ltf_sec = timeframe_to_seconds(self.s.ltf)
        self._reentry_bars = 3

    # ---- frames ----
    def _fetch_frames(self, sym: str) -> Tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
        df_htf = self.exw.fetch_ohlcv(sym, self.s.htf, limit=500)
        df_mtf = self.exw.fetch_ohlcv(sym, self.s.mtf, limit=300)
        df_ltf = self.exw.fetch_ohlcv(sym, self.s.ltf, limit=120)
        return df_htf, df_mtf, df_ltf

    # ---- sizing helpers ----
    def _atr_adjust_factor(self, df: pd.DataFrame, atr_len=14, atr_ref_window=90, size_min=0.5, size_max=2.0) -> float:
        series = atr(df, atr_len)
        cur = float(series.iloc[-1]) if not np.isnan(series.iloc[-1]) else None
        ref = float(series.tail(atr_ref_window).mean()) if not series.dropna().empty else None
        if not cur or not ref or cur <= 0: return 1.0
        return max(size_min, min(size_max, ref / cur))

    def _tier_scale(self, tier: int) -> float:
        return 1.0 if tier == 1 else (0.75 if tier == 2 else 0.5)

    # ---- affordability ----
    def _cap_qty_by_filters_and_margin(self, sym: str, qty_target: float, price_ref: float) -> float:
        if qty_target <= 0 or price_ref <= 0: return 0.0
        free = float(self.exw.balance_free_usdt())
        lev  = float(self.s.risk_policy.leverage or 1)
        safety = 0.85
        max_notional_by_margin = max(0.0, free * lev * safety)
        qty = min(qty_target, max_notional_by_margin / price_ref if price_ref>0 else 0.0)
        qty = self.exw.clamp_qty_step(sym, qty)
        # Bybit punya min/max dalam market.limits
        m = self.exw.market(sym)
        min_amount = (m.get("limits", {}).get("amount", {}) or {}).get("min", 0.0) or 0.0
        max_amount = (m.get("limits", {}).get("amount", {}) or {}).get("max", float("inf")) or float("inf")
        if qty < min_amount:
            if min_amount * price_ref <= max_notional_by_margin:
                qty = self.exw.clamp_qty_step(sym, min_amount)
            else:
                return 0.0
        if qty > max_amount:
            qty = self.exw.clamp_qty_step(sym, max_amount)
        # min cost (notional)
        min_cost = (m.get("limits", {}).get("cost", {}) or {}).get("min", 0.0) or 0.0
        if min_cost and qty * price_ref < min_cost:
            need_qty = min_cost / price_ref if price_ref>0 else float("inf")
            if need_qty * price_ref <= max_notional_by_margin:
                qty = self.exw.clamp_qty_step(sym, need_qty)
            else:
                return 0.0
        return float(qty)

    # ---- records ----
    def _open_position_record(self, sym: str, side: str, entry: float, sl: float, tp: float, qty: float, tier: int):
        rpu = abs(entry - sl)
        self.open_positions[sym] = {
            "side": side, "entry": float(entry), "sl": float(sl), "tp": float(tp),
            "qty_total": float(qty), "qty_open": float(qty),
            "ptp_done": False, "trail_active": False,
            "trail_dist": self.s.risk_policy.trail_dist_r * rpu
        }

    # ---- close helpers ----
    def _safe_reduce_only_close(self, sym: str, desired_qty: float, pos_side: str) -> bool:
        return self.exw.best_effort_close(sym, desired_qty, pos_side)

    # ---- place order (Bybit-friendly) ----
    def _place_with_retries(self, place_fn, sym: str, side_lbl: str, qty: float, last_price: float, sl: float, tp: float, tier: int) -> bool:
        attempts = 0
        while attempts < 4:
            try:
                od = place_fn(qty)
                avg = od.get("average") or od.get("price") or last_price
                self._open_position_record(sym, side_lbl, float(avg), sl, tp, qty, tier)
                print(f"[OPEN] {sym} {side_lbl} qty={qty:.6f} avg~{float(avg):.6f} sl={sl:.6f} tp={tp:.6f}")
                return True
            except Exception as e:
                attempts += 1
                print(f"[RETRY] place {sym} attempt {attempts}: {e}")
                time.sleep(min(1.5*(attempts**1.2), 6.0))
        print(f"[SKIP] {sym} open failed after retries.")
        return False

    def _queue_entry(self, sym: str, side: str, entry: float, sl: float, tp: float,
                     usd_equity: float, tier: int, df_ltf: pd.DataFrame):
        now = time.time()
        if sym in self._cooldown_until and now < self._cooldown_until[sym]:
            return
        key = (sym, side.upper())
        if key in self._reentry_cooldown_until and now < self._reentry_cooldown_until[key]:
            return

        rpu = abs(entry - sl)
        if rpu <= 0:
            return

        factor_vol = self._atr_adjust_factor(df_ltf)
        risk_pct = self.s.risk_policy.base_risk_pct * self._tier_scale(tier)
        usd_risk = usd_equity * (risk_pct / 100.0)
        qty_target = max(0.0, float((usd_risk / rpu) * factor_vol))

        last = float(self.exw.ticker_price(sym)) or entry
        qty = self._cap_qty_by_filters_and_margin(sym, qty_target, last)
        if qty <= 0:
            self._cooldown_until[sym] = time.time() + 60
            return

        if self.s.paper:
            self._open_position_record(sym, side, entry, sl, tp, qty, tier)
            print(f"[OPEN/PAPER] {sym} {side} qty={qty:.6f} entry={entry:.6f} sl={sl:.6f} tp={tp:.6f} "
                  f"(risk%={risk_pct:.2f}, vol={factor_vol:.2f}, tier={tier})")
            return

        try:
            self.exw.ensure_leverage(sym, self.s.risk_policy.leverage)
        except Exception as e:
            print(f"[WARN] ensure_leverage {sym}: {e}")

        side_ccxt = "buy" if side == "LONG" else "sell"

        # Bybit route: LIMIT-IOC agresif → fallback MARKET
        ok = self._place_with_retries(
            lambda q: self.exw.limit_ioc_aggressive(sym, side_ccxt, q, reduce_only=False),
            sym, side, qty, last, sl, tp, tier
        )
        if not ok:
            ok2 = self._place_with_retries(
                lambda q: self.exw.market_order(sym, side_ccxt, q, reduce_only=False),
                sym, side, qty, last, sl, tp, tier
            )
            if not ok2:
                self._cooldown_until[sym] = time.time() + 120

    # ---- manage open position ----
    def _manage_position(self, sym: str, row: pd.Series):
        pos = self.open_positions.get(sym)
        if not pos: return
        hi, lo, close = float(row["high"]), float(row["low"]), float(row["close"])
        side = pos["side"]

        # sync qty_open dengan exchange
        if not self.s.paper:
            exch_qty, exch_side = self.exw.current_position_qty_side(sym)
            if not exch_side or exch_qty <= 0:
                self.open_positions.pop(sym, None)
                print(f"[SYNC] {sym} position gone on exchange → removed locally.")
                return
            pos["qty_open"] = min(pos["qty_open"], exch_qty)

        sl_hit = (lo <= pos["sl"]) if side=="LONG" else (hi >= pos["sl"])
        tp_hit = (hi >= pos["tp"]) if side=="LONG" else (lo <= pos["tp"])

        # Partial TP @ 1R
        if (not sl_hit) and (not tp_hit) and (not pos["ptp_done"]):
            r = abs(pos["entry"] - pos["sl"])
            tp1 = pos["entry"] + (r if side=="LONG" else -r)
            tp1_hit = (hi >= tp1) if side=="LONG" else (lo <= tp1)
            if tp1_hit:
                qty_part = min(pos["qty_total"] * self.s.risk_policy.partial_tp_pct, pos["qty_open"])
                if qty_part > 0 and not self.s.paper:
                    ok = self._safe_reduce_only_close(sym, qty_part, pos_side=side)
                    if not ok:
                        print(f"[WARN] {sym} PTP close failed. Retry next tick.")
                        return
                pos["qty_open"] -= qty_part
                pos["ptp_done"] = True
                pos["sl"] = max(pos["sl"], pos["entry"]) if side=="LONG" else min(pos["sl"], pos["entry"])
                pos["trail_active"] = True
                print(f"[PTP] {sym} {side} partial {qty_part:.6f} @ ~{tp1:.6f} → BE & trail ON")

        # Trailing
        if pos.get("trail_active", False):
            dist = pos["trail_dist"]
            new_sl = (close - dist) if side=="LONG" else (close + dist)
            if (side=="LONG" and new_sl > pos["sl"]) or (side=="SHORT" and new_sl < pos["sl"]):
                pos["sl"] = new_sl

        # Exit
        sl_hit = (lo <= pos["sl"]) if side=="LONG" else (hi >= pos["sl"])
        tp_hit = (hi >= pos["tp"]) if side=="LONG" else (lo <= pos["tp"])
        if sl_hit or tp_hit:
            qty_close = pos["qty_open"]
            if qty_close > 0 and not self.s.paper:
                ok = self._safe_reduce_only_close(sym, qty_close, pos_side=side)
                if not ok:
                    print(f"[WARN] {sym} EXIT close failed. Retry next tick."); return
            self.open_positions.pop(sym, None)
            print(f"[EXIT] {sym} {side} via {'TP' if tp_hit else 'SL'} at ~{(pos['tp'] if tp_hit else pos['sl']):.6f}")
            self._reentry_cooldown_until[(sym, side)] = time.time() + self._reentry_bars * self._ltf_sec

    # ---- main loop ----
    def run(self):
        print(f"[INFO] Start Top-Down | Symbols={', '.join(self.s.symbols)} | "
              f"BaseRisk={self.s.risk_policy.base_risk_pct}% | RRmin={self.s.risk_policy.min_rr} | "
              f"PAPER={self.s.paper} | CorrMode={self.s.corr_mode}")

        for sym in self.s.symbols:
            try:
                self.exw.ensure_leverage(sym, self.s.risk_policy.leverage)
                time.sleep(0.2)
            except Exception as e:
                print(f"[WARN] leverage init {sym}: {e}")

        while True:
            try:
                for sym in self.s.symbols:
                    try:
                        df_htf, df_mtf, df_ltf = self._fetch_frames(sym)
                    except Exception as e:
                        print(f"[WARN] fetch frames {sym}: {e}"); continue

                    if sym in self.open_positions:
                        self._manage_position(sym, df_ltf.iloc[-1]); continue
                    if sym in self.pending_entries:
                        continue

                    setup = choose_setup(df_mtf)
                    if not setup: continue

                    trig_dec = ltf_trigger_decision(df_ltf, setup, self.s.trigger_policy)
                    if not trig_dec: continue

                    direction = trig_dec["direction"]
                    entry = float(df_ltf["close"].iloc[-1])

                    # SL & TP
                    if setup.get("sl") is not None:
                        sl = float(setup["sl"])
                    else:
                        A = float(atr(df_mtf.tail(220), 14).iloc[-1])
                        lvl = float(setup.get("break_level", entry))
                        offset = 0.5 * (A if np.isfinite(A) else abs(df_mtf["close"].iloc[-1]*0.003))
                        sl = (lvl - offset) if direction=="LONG" else (lvl + offset)

                    rpu = abs(entry - sl)
                    if rpu <= 0: continue

                    if setup.get("tp") is not None:
                        tp = float(setup["tp"])
                    else:
                        rr = max(self.s.risk_policy.min_rr, 1.5)
                        tp = entry + rr * rpu if direction=="LONG" else entry - rr * rpu

                    rr_now = abs(tp - entry) / rpu
                    if rr_now < self.s.risk_policy.min_rr:
                        continue

                    usd_equity = self.exw.balance_free_usdt()
                    self._queue_entry(sym, direction, entry, sl, tp, usd_equity, setup.get("tier", 2), df_ltf)
                    time.sleep(0.25)

                time.sleep(5)
            except KeyboardInterrupt:
                print("\n[STOP] Bot stopped by user."); break
            except Exception as e:
                print(f"[ERROR] Loop error: {e}"); time.sleep(3)

# ================== CLI & MAIN ==================
def parse_args():
    p = argparse.ArgumentParser(description="Advanced Pattern Day Trading Bot — Bybit USDT Perp")
    p.add_argument("--paper", action="store_true", help="Paper mode (tidak kirim order)")
    p.add_argument("--verbose", action="store_true", help="Log detail")
    p.add_argument("--symbols", type=str, required=True, help='Contoh: "BTC/USDT,ETH/USDT,BNB/USDT"')
    p.add_argument("--htf", type=str, default="1d")
    p.add_argument("--mtf", type=str, default="4h")
    p.add_argument("--ltf", type=str, default="15m")
    p.add_argument("--base_risk", type=float, default=8.0)
    p.add_argument("--min_rr", type=float, default=2.0)
    p.add_argument("--leverage", type=int, default=3)
    p.add_argument("--active_h4", type=int, default=10)
    p.add_argument("--swing_n", type=int, default=3)
    p.add_argument("--stoch_long_max", type=float, default=90.0)
    p.add_argument("--stoch_short_min", type=float, default=10.0)
    p.add_argument("--corr_mode", type=str, default="off", choices=["off","soft","hard"])
    return p.parse_args()

if __name__ == "__main__":
    args = parse_args()
    syms = [s.strip() for s in args.symbols.split(",") if s.strip()]

    settings = Settings(
        paper=args.paper,
        verbose=args.verbose,
        symbols=syms,
        htf=args.htf,
        mtf=args.mtf,
        ltf=args.ltf,
        corr_mode=args.corr_mode,
        risk_policy=RiskPolicy(
            base_risk_pct=args.base_risk,
            min_rr=args.min_rr,
            leverage=args.leverage,
            active_window_h4=args.active_h4,
            partial_tp_pct=0.5,
            trail_dist_r=1.0,
        ),
        trigger_policy=TriggerPolicy(
            stoch_long_max=args.stoch_long_max,
            stoch_short_min=args.stoch_short_min,
            swing_n=args.swing_n,
            allow_inside=True,
            allow_engulf=True,
            allow_breakout=True,
            allow_reversal=True,
        ),
    )

    bot = Bot(settings)
    bot.run()

