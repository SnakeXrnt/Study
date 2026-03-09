# Tests for assignment 3

There are three test cases for this assignment. Each test case consists of an input file containing two binary search trees and the expected output.

To test your implementation against these test cases, you can run your program with the input files and compare the output with the expected outputs provided here.

In PowerShell, this is done as follows (for `input1.txt` and assuming that you're in the build directory for the assignment, i.e., `build/assignment3`):

```powershell
Get-Content .\data\input1.txt | .\assignment3.exe
```

In Command-Prompt, this is done as follows:

```cmd
assignment3.exe < data\input1.txt
```

## Test case 1

File `input1.txt` contains two identical trees:

```
((1 2 ()) 3 4) ((1 2 ()) 3 4)
```

The expected output is "true", since both trees are identical.

## Test case 2

File `input2.txt` contains two trees that have the same values, but are not identical because their structure is different.

```
((1 2 ()) 3 4) ((() 1 2) 3 4)
```

The expected output is "false".

## Test case 3

File `input3.txt` contains two identical trees with more nodes:

```
((1 2 3) 4 (5 6 (() 7 8))) ((1 2 3) 4 (5 6 (() 7 8)))
```

The expected output for `input3.txt` is "true".

