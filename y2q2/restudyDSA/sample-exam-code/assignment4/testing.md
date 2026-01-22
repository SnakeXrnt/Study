# Tests for assignment 4

There are three test cases for this assignment. Each test case consists of an input file containing a sequence of edges.
For each test case, the expected output is given below.

To test your implementation against these test cases, you can run your program with the input files and compare the output with the expected outputs provided here.

In PowerShell, this is done as follows (for `input1.txt` and assuming that you're in the build directory for the assignment, i.e., `build/assignment4`):

```powershell
Get-Content .\data\input1.txt | .\assignment4.exe
```

In Command-Prompt, this is done as follows:

```cmd
assignment4.exe < data\input1.txt
```

## Test case 1

File `input1.txt` contains a directed graph that has a cycle involving three edges:

```
[(A, B), (B, C), (C, A), (D, E)]
```

The expected output is the cycle ABCA:

```
A -> B -> C -> A
```

## Test case 2

File `input2.txt` contains a directed graph that has no cycle:

```
[(A, B), (B, C), (A, D), (D, C), (C, E)]
```

The expected output is the message "No cycle found".

## Test case 3

File `input3.txt` contains a directed graph that has a cycle involving four edges:

```
[(A, B), (B, C), (C, D), (D, E), (E, F), (F, C)]
```

The expected output for `input3.txt` is:

```
C -> D -> E -> F -> C
```
