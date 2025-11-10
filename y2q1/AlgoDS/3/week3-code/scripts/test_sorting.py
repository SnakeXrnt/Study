import os
import sys
import subprocess   # for running programs
from itertools import tee  # for checking sorted output

# ensure that we have at least two arguments:
# argv[1]: the program to test
# argv[2]: the file with test case

if (len(sys.argv) < 3):
    print("Usage: python test.py <program> <test_file>")
    exit(1)

# form the path for the test cases
test_file_path = sys.argv[2]

# get program to run
program = os.path.join(os.getcwd(), sys.argv[1])

# ensure that program exists
if not os.path.isfile(program) and not os.path.isfile(f"{program}.exe"):
    print(f"Program not found: {program}")
    exit(1)

# ensure that the file exists
if not os.path.isfile(test_file_path):
    print(f"Test file not found: {test_file_path}")
    exit(1)

def replace_escape_sequences(s):
    return s.replace("\\n", "\n").replace("\\t", "\t").replace("\\r", "\r")

# Read test cases from file
with open(test_file_path, "r") as f:
    try:
        tests = (replace_escape_sequences(line).strip().split(" ") for line in f.readlines())
        # filter out empty test cases
        tests = [line for line in tests if len(line) == 2]
    except Exception as e:
        print(f"Error reading test cases: {e}")
        exit(1)

for input, output in tests:
    # run program, capture output
    try:
        # split test input into lines
        result = subprocess.run([program], input=f"{input}\n{output}\n", text=True, capture_output=True)

        # check return code
        if result.returncode != 0:
            print(f"Program exited with non-zero return code {result.returncode} for test input: {input} {output}")
            print(result.stderr)
            exit(1)

        # compute sum of ascii codes of alphanumeric characters in input file
        with open(os.path.join(os.getcwd(), input), "r") as in_file:
            input_sum = sum(ord(c) for c in in_file.read() if c.isalnum())

        # compute sum of ascii codes of alphanumeric characters in output file
        with open(os.path.join(os.getcwd(), output), "r") as out_file:
            output_sum = sum(ord(c) for c in out_file.read() if c.isalnum())

        # check that sums match
        if input_sum != output_sum:
            print(f"Test failed for input: {input}")
            print(f"Sum of ASCII codes in input file ({input_sum}) does not match sum in output file ({output_sum})")
            exit(1)

        # read output file and check that its contents are indeed sorted
        with open(os.path.join(os.getcwd(), output), "r") as out_file:
            contents = (word.strip() for line in out_file.readlines() for word in line.strip().split(" "))
            a, b = tee(contents)
            next(b, None)  # advance b by one
            for first, second in zip(a, b):
                if first > second:
                    print(f"Test failed for input: {input}")
                    print(f"Output file {output} is not sorted: '{first}' > '{second}'")
                    exit(1)
            
        # print stdout of subprocess
        with open(os.path.join(os.getcwd(), f"{output}.stdout"), "w") as log_file:
            log_file.write(result.stdout.strip() + "\n")
        print(result.stdout.strip())
    except Exception as e:
        print(f"Error occurred while running program from {os.getcwd()}: {e}")

# all good!
exit(0)
