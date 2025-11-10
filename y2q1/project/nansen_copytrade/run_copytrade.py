# run_copytrade.py
import sys, json, argparse, traceback
from nansen_client import (
    NansenClient,
    FlowQuery, PnLLeaderboardQuery, PnLSummaryQuery,
    DexTradesQuery, HoldersQuery, API_KEY
)

TOKEN_ETH = "0x6982508145454ce325ddbe47a25d4ec3d2311933"  # example
CHAIN = "ethereum"

def pick_copy_targets(leaderboard: dict, min_roi_pct: float = 50.0, min_win_rate: float = 0.6):
    rows = leaderboard.get("data", []) or leaderboard.get("results", []) or []
    def gp(row, *keys, default=0.0):
        for k in keys:
            if k in row and row[k] is not None:
                return row[k]
        return default
    rows_sorted = sorted(rows, key=lambda r: gp(r, "pnl_usd_realised", "pnl_usd", default=0.0), reverse=True)
    filtered = [
        r for r in rows_sorted
        if gp(r, "roi_percent_realised", "roi_percent", default=0.0) >= min_roi_pct
        and gp(r, "win_rate", "winrate", default=0.0) >= min_win_rate
    ]
    return filtered[:20]

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--debug", action="store_true", help="Print raw payload heads")
    ap.add_argument("--no-1h", action="store_true", help="Skip 1h flow call")
    args = ap.parse_args()

    print("[boot] run_copytrade starting")
    print(f"[env] API key present: {bool(API_KEY)}")
    print(f"[cfg] chain={CHAIN} token={TOKEN_ETH}")
    n = NansenClient()

    try:
        print("[step] Flow 7d...")
        flow_week = n.flow_intelligence(FlowQuery(chain=CHAIN, token_address=TOKEN_ETH, timeframe="7d"))
        if args.debug:
            print("[debug] flow_week keys:", list(flow_week.keys())[:20])
            print("[debug] flow_week sample:", json.dumps(flow_week, indent=2)[:600])
        print("[out] 7d smart/whale/public flows:",
              flow_week.get("smart_trader_net_flow_usd"),
              flow_week.get("whale_net_flow_usd"),
              flow_week.get("public_figure_net_flow_usd"))

        print("[step] PnL leaderboard 3m...")
        lb = n.pnl_leaderboard(PnLLeaderboardQuery(
            chain=CHAIN,
            token_address=TOKEN_ETH,
            date_from="2024-10-01",
            date_to="2025-01-21",
            min_realised_pnl=1000.0,
            page=1, per_page=50,
            order_by=[{"field": "pnl_usd_realised", "direction": "DESC"}],
        ))
        if args.debug:
            print("[debug] leaderboard keys:", list(lb.keys())[:20])
            rows = lb.get("data", []) or lb.get("results", []) or []
            print(f"[debug] leaderboard rows: {len(rows)}")
            if rows:
                print("[debug] first row:", json.dumps(rows[0], indent=2)[:800])

        targets = pick_copy_targets(lb, min_roi_pct=50.0, min_win_rate=0.6)
        print(f"[out] copy candidates: {len(targets)}")

        print("[step] Vet candidates with PnL summary...")
        vetted = []
        for i, row in enumerate(targets):
            addr = row.get("address") or row.get("wallet") or row.get("owner") or ""
            if not addr:
                continue
            summary = n.pnl_summary(PnLSummaryQuery(
                address=addr,
                chain=CHAIN,
                date_from="2024-07-01",
                date_to="2025-01-21",
            ))
            wr = summary.get("win_rate", 0.0)
            realised = summary.get("realized_pnl_usd") or summary.get("realised_pnl_usd") or 0.0
            if wr and wr > 0.6 and realised and realised > 0:
                vetted.append(addr)
            if args.debug and i < 3:
                print(f"[debug] {addr} win_rate={wr} realised={realised}")
        print(f"[out] vetted wallets: {len(vetted)}")

        print("[step] Smart money DEX trades...")
        dex = n.smart_money_dex_trades(DexTradesQuery(
            chains=[CHAIN, "base", "arbitrum"],
            token_bought_address=TOKEN_ETH,
            min_trade_value_usd=10000.0,
            include_smart_money_labels=["Smart Trader", "Fund"],
            page=1, per_page=100
        ))
        rows = dex.get("data", []) or dex.get("results", []) or []
        print(f"[out] dex trades returned: {len(rows)}")
        if args.debug and rows:
            print("[debug] first trade:", json.dumps(rows[0], indent=2)[:800])

        print("[step] Smart-money holders...")
        holders = n.tgm_holders(HoldersQuery(
            chain=CHAIN,
            token_address=TOKEN_ETH,
            label_type="smart_money",
            include_smart_money_labels=["Smart Trader", "Fund", "30D Smart Trader"],
            ownership_min_pct=0.1, value_min_usd=50000.0,
            page=1, per_page=100
        ))
        hrows = holders.get("data", []) or holders.get("results", []) or []
        print(f"[out] holders returned: {len(hrows)}")
        if args.debug and hrows:
            print("[debug] first holder:", json.dumps(hrows[0], indent=2)[:800])

        if not args.no_1h:
            print("[step] Flow 1h...")
            flow_1h = n.flow_intelligence(FlowQuery(chain=CHAIN, token_address=TOKEN_ETH, timeframe="1h"))
            print("[out] 1h smart/whale/public flows:",
                  flow_1h.get("smart_trader_net_flow_usd"),
                  flow_1h.get("whale_net_flow_usd"),
                  flow_1h.get("public_figure_net_flow_usd"))

        print("[done] run_copytrade completed")

    except KeyboardInterrupt:
        print("\n[exit] Canceled by user")
        sys.exit(130)
    except Exception as e:
        print("[error] Exception occurred:", repr(e))
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
