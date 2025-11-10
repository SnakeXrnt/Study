import sys

if len(sys.argv) != 3:
    print("Usage: python no_ascii.py <input_file> <output_file>")
    exit(1)

input_name = sys.argv[1]
output_name = sys.argv[2]

with open(input_name, "r", encoding="utf-8") as f_in:
    with open(output_name, "w", encoding="utf-8") as f_out:

        for line in f_in.readlines():
            # Remove all non-ASCII characters
            line = ''.join(c for c in line if ord(c) < 128)

            # Remove non-printable characters
            line = ''.join(c for c in line if c.isprintable() or c.isspace())

            # Remove interpunction characters
            line = ''.join(c for c in line if c.isalnum() or c.isspace())

            f_out.write(line)
