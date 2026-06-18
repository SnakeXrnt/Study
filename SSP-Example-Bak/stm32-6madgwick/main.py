import serial
from time import perf_counter
import os
import argparse
import polars as pl


argparse = argparse.ArgumentParser(
    description="Read and parse serial data from an Arduino."
)
argparse.add_argument(
    "--port",
    type=str,
    default="/dev/ttyACM0",
    help="Serial port to connect to (default: /dev/ttyACM0)",
)
argparse.add_argument(
    "--baud",
    type=int,
    default=115200,
    help="Baud rate for serial communication (default: 115200)",
)
argparse.add_argument(
    "--output",
    type=str,
    default="data.csv",
    help="Output CSV file name (default: data.csv)",
)


args = argparse.parse_args()

PORT = args.port
BAUD = args.baud
OUTPUT_FILE = args.output


data: list[tuple[float, float, float]] = []


def main():
    total_read = 0
    total_errors = 0
    start_time = perf_counter()
    last_print_time = start_time
    try:
        if os.path.exists(OUTPUT_FILE):
            print(f"Warning: {OUTPUT_FILE} already exists.")
            input(
                "Press Enter to continue and overwrite the file, or Ctrl+C to cancel..."
            )

        with serial.Serial(PORT, BAUD, timeout=1) as ser:
            print(f"Connected to {PORT} at {BAUD} baud.")

            while True:
                if ser.in_waiting > 0:
                    line = ser.readline()
                    try:
                        x, y, z = map(float, line.strip(b"[] \r\n").split(b", "))
                        data.append((x, y, z))
                    except ValueError:
                        total_errors += len(line)
                        continue
                    else:
                        now = perf_counter()
                        elapsed = now - last_print_time
                        if elapsed >= 5.0:
                            elapsed_total = now - start_time
                            print(
                                f"Time: {elapsed_total:.2f}s, Total Read: {total_read}, Errors: {total_errors}"
                            )
                            last_print_time = now
                    finally:
                        total_read += len(line)

    except serial.SerialException as e:
        print(f"Error: {e}")
    except KeyboardInterrupt:
        print("\nStopping script...")
    finally:
        success_ratio = (
            (total_read - total_errors) / total_read if total_read > 0 else 1.0
        )
        print(f"Stopped. Data without errors: {success_ratio:.2%}")

        df = pl.DataFrame(data, schema=["x", "y", "z"], orient="row")
        df.write_csv(OUTPUT_FILE)
        print("Data saved to data.csv")

        total_time = perf_counter() - start_time
        print(
            f"Total time: {total_time:.2f} seconds, Total Read: {total_read}, Errors: {total_errors}"
        )


if __name__ == "__main__":
    main()
