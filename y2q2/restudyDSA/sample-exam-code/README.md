# Project structure

The project contains the following files and directories:
- `CMakeLists.txt`: The CMake configuration file for building the project.
- `assignment1/`, `assignment2/`, `assignment3/`, `assignment4/`: Directories containing the code for each of the four assignments.
- `assignmentX/data/`: Directories containing input files for testing each assignment.
- `assignmentX/testing.md`: Markdown files describing the input files and expected output for each assignment.

## Building the project
To build the project, navigate to the root directory of the project and run the following commands:

```bash
mkdir build
cd build
cmake ..
make
```

Or use the CMake pane in VS Code to configure and build the project.

## Running the assignments
To run an assignment with a specific input file, navigate to the corresponding build directory and execute the program, redirecting the input from the desired file. For example, to run assignment 1 with the input file `data/input1.txt`, use the following command in PowerShell:

```powershell
Get-Content .\data\input1.txt | .\assignment1.exe
```

When using the Command Prompt, this is done as follows:

```cmd
assignment1.exe < data\input1.txt
```
