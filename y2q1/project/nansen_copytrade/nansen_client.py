
import os
import time
import typing as t
import requests
from requests import exceptions as req_exc
from dataclasses import dataclass
from tenacity import retry, stop_after_attempt, wait_exponential, retry_if_exception_type
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.environ.get("NANSEN_API_KEY", "")
BASE = "https://api.nansen.ai"

class NansenError(Exception):
    pass

def _headers() -> dict:
    if not API_KEY:
        raise NansenError("NANSEN_API_KEY not set")
    return {
        "apiKey": API_KEY,
        "Content-Type": "application/json",
    }

# Use (connect_timeout, read_timeout) so we fail fast on bad networks
def _post(path: str, json: dict, timeout: tuple[int, int] = (5, 15)) -> dict:
    url = f"{BASE}{path}"
    r = requests.post(url, json=json, headers=_headers(), timeout=timeout)
    if r.status_code == 429:
        time.sleep(1.5)
    if not r.ok:
        raise NansenError(f"HTTP {r.status_code}: {r.text}")
    return r.json()

@dataclass
class FlowQuery:
    chain: str
    token_address: str
    timeframe: str  # "1h", "24h", "7d", etc.

@dataclass
class PnLLeaderboardQuery:
    chain: str
    token_address: str
    date_from: str
    date_to: str
    min_realised_pnl: float = 1000.0
    page: int = 1
    per_page: int = 50
    order_by: t.List[dict] = None  # e.g. [{"field":"pnl_usd_realised","direction":"DESC"}]

@dataclass
class PnLSummaryQuery:
    address: str
    chain: str
    date_from: str
    date_to: str

@dataclass
class DexTradesQuery:
    chains: t.List[str]
    token_bought_address: str
    min_trade_value_usd: float = 10000.0
    include_smart_money_labels: t.List[str] = None
    page: int = 1
    per_page: int = 100

@dataclass
class HoldersQuery:
    chain: str
    token_address: str
    label_type: str  # "smart_money"
    include_smart_money_labels: t.List[str] = None
    ownership_min_pct: float = None
    value_min_usd: float = None
    page: int = 1
    per_page: int = 100

def _dex_payload(q: DexTradesQuery, use_labels: bool) -> dict:
    filters = {
        "token_bought_address": q.token_bought_address,
        "trade_value_usd": {"min": q.min_trade_value_usd},
    }
    if use_labels and q.include_smart_money_labels:
        filters["include_smart_money_labels"] = q.include_smart_money_labels

    return {
        "chains": q.chains,
        "filters": filters,
        "pagination": {"page": q.page, "per_page": q.per_page},
    }

class NansenClient:
    @retry(
        reraise=True,
        stop=stop_after_attempt(4),
        wait=wait_exponential(multiplier=0.6, min=0.6, max=6),
        retry=retry_if_exception_type((NansenError, req_exc.RequestException)),
    )
    def flow_intelligence(self, q: FlowQuery) -> dict:
        payload = {
            "chain": q.chain,
            "token_address": q.token_address,
            "timeframe": q.timeframe,
        }
        resp = _post("/api/v1/tgm/flow-intelligence", payload)
        # unwrap {"data":[{...}]}
        if isinstance(resp, dict) and isinstance(resp.get("data"), list):
            return resp["data"][0] if resp["data"] else {}
        return resp

    @retry(
        reraise=True,
        stop=stop_after_attempt(4),
        wait=wait_exponential(multiplier=0.6, min=0.6, max=6),
        retry=retry_if_exception_type((NansenError, req_exc.RequestException)),
    )
    def pnl_leaderboard(self, q: PnLLeaderboardQuery) -> dict:
        payload = {
            "chain": q.chain,
            "token_address": q.token_address,
            "date": {"from": q.date_from, "to": q.date_to},
            "filters": {"pnl_usd_realised": {"min": q.min_realised_pnl}},
            "pagination": {"page": q.page, "per_page": q.per_page},
        }
        if q.order_by:
            payload["order_by"] = q.order_by
        return _post("/api/v1/tgm/pnl-leaderboard", payload)

    @retry(
        reraise=True,
        stop=stop_after_attempt(4),
        wait=wait_exponential(multiplier=0.6, min=0.6, max=6),
        retry=retry_if_exception_type((NansenError, req_exc.RequestException)),
    )
    def pnl_summary(self, q: PnLSummaryQuery) -> dict:
        payload = {
            "address": q.address,
            "chain": q.chain,
            "date": {"from": q.date_from, "to": q.date_to},
        }
        return _post("/api/v1/profiler/address/pnl-summary", payload)

    @retry(
        reraise=True,
        stop=stop_after_attempt(4),
        wait=wait_exponential(multiplier=0.6, min=0.6, max=6),
        retry=retry_if_exception_type((NansenError, req_exc.RequestException)),
    )
    def smart_money_dex_trades(self, q: DexTradesQuery) -> dict:
        # try with labels under filters, then fallback without labels if 422
        payload = _dex_payload(q, use_labels=True)
        try:
            return _post("/api/v1/smart-money/dex-trades", payload)
        except NansenError as e:
            if "include_smart_money_labels" in str(e) or "Invalid input" in str(e):
                fallback = _dex_payload(q, use_labels=False)
                return _post("/api/v1/smart-money/dex-trades", fallback)
            raise

    @retry(
        reraise=True,
        stop=stop_after_attempt(4),
        wait=wait_exponential(multiplier=0.6, min=0.6, max=6),
        retry=retry_if_exception_type((NansenError, req_exc.RequestException)),
    )
    def tgm_holders(self, q: HoldersQuery) -> dict:
        payload = {
            "chain": q.chain,
            "token_address": q.token_address,
            "label_type": q.label_type,
            "pagination": {"page": q.page, "per_page": q.per_page},
        }
        filters = {}
        if q.include_smart_money_labels:
            filters["include_smart_money_labels"] = q.include_smart_money_labels
        if q.ownership_min_pct is not None:
            filters["ownership_percentage"] = {"min": q.ownership_min_pct}
        if q.value_min_usd is not None:
            filters["value_usd"] = {"min": q.value_min_usd}
        if filters:
            payload["filters"] = filters
        return _post("/api/v1/tgm/holders", payload)
