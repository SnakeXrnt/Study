# Tests for assignment 3

There are three test cases for this assignment. Each test case consists of an input file containing an array and a target value. The expected output is the subarray that has the closest sum to the target value.

To test your implementation against these test cases, you can run your program with the input files and compare the output with the expected outputs provided here.

In PowerShell, this is done as follows (for `input1.txt` and assuming that you're in the build directory for the assignment, i.e., `build/assignment1`):

```powershell
Get-Content .\data\input1.txt | .\assignment1.exe
```

In Command-Prompt, this is done as follows:

```cmd
assignment1.exe < data\input1.txt
```

## Test case 1

File `input1.txt` contains the following array and target value:

```
[1, 2, 3, 4, 5, 6] 8
```

The expected output is either:

```
[2, 3, 4] (sum = 9)
```

or:

```
[3, 4] (sum = 7)
```

or:

```
[4, 5] (sum = 9)
```

## Test case 2

File `input2.txt` contains the following array and target value:

```
[10, 15, 20, 25] 31
```

The expected output is:

```
[15, 20] (sum = 35)
```

## Test case 3

File `input3.txt` contains the following array and target value:

```
[3, 4, 5, 6, 7, 8, 9, 10] 42
```

The expected output is:

```
[3, 4, 5, 6, 7, 8, 9] (sum = 42)
```

