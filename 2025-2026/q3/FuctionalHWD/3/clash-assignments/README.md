# Stack instructions
## Building the project
Make sure you have stack installed(https://docs.haskellstack.org/en/stable/install_and_upgrade/)
```
stack build
```

## Entering the interactive GHC environment
```
stack repl
```
## Entering the interactive Clash environment
```
stack run clash -- --interactive
```
## Generating HDL from CLI
You can generate VHDL, Verilog or SystemVerilog with the appropiate flag
```
stack run clash -- --verilog MODULE_NAME
```
e.g.
```
stack run clash -- --verilog Assignments.Workflow
```
## Generating HDL from Clash interactive environment
You can generate Verilog with the `:verilog` command and the module name. This also applies to VHDL and SystemVerilog.
```
Clashi, version 1.8.1 (using clash-lib, version 1.8.1):
https://clash-lang.org/  :? for help
clashi> :verilog Assignments.Workflow
Ok, no modules loaded.
GHC: Setting up GHC took: 0.049s
GHC: Compiling and loading modules took: 0.107s
Clash: Parsing and compiling primitives took 0.131s
GHC+Clash: Loading modules cumulatively took 0.456s
Clash: Compiling Assignments.Workflow.topEntity
Clash: Normalization took 0.004s
Clash: Netlist generation took 0.000s
Clash: Compiling Assignments.Workflow.topEntity took 0.019s
Clash: Total compilation took 0.476s
Ok, no modules loaded.
```

# Cabal instructions
## Building the project
Make sure you have cabal installed(https://www.haskell.org/cabal/download.html)
```
cabal build
```

## Entering the interactive GHC environment
```
cabal repl
```
## Entering the interactive Clash environment
```
cabal run clash -- --interactive
```
## Generating HDL from CLI
You can generate VHDL, Verilog or SystemVerilog with the appropiate flag
```
cabal run clash -- --verilog MODULE_NAME
```
e.g.
```
cabal run clash -- --verilog Assignments.Workflow
```
## Generating HDL from Clash interactive environment
You can generate Verilog with the `:verilog` command and the module name. This also applies to VHDL and SystemVerilog.
```
Clashi, version 1.8.1 (using clash-lib, version 1.8.1):
https://clash-lang.org/  :? for help
clashi> :verilog Assignments.Workflow
Ok, no modules loaded.
GHC: Setting up GHC took: 0.049s
GHC: Compiling and loading modules took: 0.107s
Clash: Parsing and compiling primitives took 0.131s
GHC+Clash: Loading modules cumulatively took 0.456s
Clash: Compiling Assignments.Workflow.topEntity
Clash: Normalization took 0.004s
Clash: Netlist generation took 0.000s
Clash: Compiling Assignments.Workflow.topEntity took 0.019s
Clash: Total compilation took 0.476s
Ok, no modules loaded.
```
