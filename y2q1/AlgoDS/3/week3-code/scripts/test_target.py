import os
import sys
import subprocess   # for running programs

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
        tests = (replace_escape_sequences(line).strip().split("===>") for line in f.readlines())
        # filter out empty test cases
        tests = [line for line in tests if len(line) == 2]
    except Exception as e:
        print(f"Error reading test cases: {e}")
        exit(1)

for test, expected_result in tests:
    # run program, capture output
    try:
        # split test input into lines
        result = subprocess.run([program], input=test.strip(), text=True, capture_output=True)

        # check return code
        if result.returncode != 0:
            print(f"Program exited with non-zero return code {result.returncode} for test input: {test}")
            print(result.stderr)
            exit(1)

        # read from stdout of subprocess
        answer = result.stdout.strip()

        if answer != expected_result.strip():
            print(result.stderr)
            print(f"The answer for the following test input is incorrect: {test}\n"
                f" got {answer}\n"
                f" expected {expected_result.strip()}")
            exit(1)
    except Exception as e:
        print(f"Error occurred while running program from {os.getcwd()}: {e}")

# all good!
exit(0)
