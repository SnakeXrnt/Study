# Tests for assignment 2

There are three test cases for this assignment. Each test case consists of an input file containing a singly linked list and the expected output.

To test your implementation against these test cases, you can run your program with the input files and compare the output with the expected outputs provided here.

In PowerShell, this is done as follows (for `input1.txt` and assuming that you're in the build directory for the assignment, i.e., `build/assignment2`):

```powershell
Get-Content .\data\input1.txt | .\assignment2.exe
```

In Command-Prompt, this is done as follows:

```cmd
assignment2.exe < data\input1.txt
```

## Test case 1

File `input1.txt` contains the following linked list:

```
[1 -> 2 -> 3 -> 4 -> 5 -> 6]
```

The expected output is:

```
[2 -> 4 -> 6]
[1 -> 2 -> 3]
```

## Test case 2

File `input2.txt` contains the following linked list that only has even numbers:

```
[2 -> 4 -> 6 -> 8]
```

The expected output is:

```
[2 -> 4 -> 6 -> 8]
[]
```

## Test case 3

File `input3.txt` contains the following linked list:

```
[2 -> 4 -> 3 -> 5 -> 6 -> 7 -> 8]
```

The expected output for `input3.txt` is:

```
[2 -> 4 -> 6 -> 8]
[3 -> 5 -> 7]
```
