import serial
import argparse


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


args = argparse.parse_args()

PORT = args.port
BAUD = args.baud


def main():
    try:
        with serial.Serial(PORT, BAUD, timeout=1) as ser:
            print(f"Connected to {PORT} at {BAUD} baud.")

            while True:
                if ser.in_waiting > 0:
                    line = ser.readline().decode("utf-8", errors="ignore").strip()

                    line = ser.readline().decode("utf-8").strip()
                    parts = line.split(",")
                    if len(parts) == 3:
                        roll, pitch, yaw = (float(x) for x in parts)

                        print(
                            f"Parsed -> R: {roll:6.1f} | P: {pitch:6.1f} | Y: {yaw:6.1f}"
                        )

    except serial.SerialException as e:
        print(f"Error: {e}")
    except KeyboardInterrupt:
        print("\nStopping script...")


if __name__ == "__main__":
    main()
