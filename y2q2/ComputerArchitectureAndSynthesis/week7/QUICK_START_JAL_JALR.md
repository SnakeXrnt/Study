# Quick Start Guide: JAL/JALR Testing

## Quick Overview
You now have a RISC-V CPU with function call support via JAL and JALR instructions!

## What Was Implemented

### Instructions Added:
1. **JAL (Jump and Link)** - Call functions with direct addressing
2. **JALR (Jump and Link Register)** - Return from functions / indirect jumps

### Test Program:
- Calls two functions using JAL
- Returns using JALR
- Demonstrates: 5 + 3 = 8, then (8 + 10) * 2 = 36

## Files to Use for Testing

### Main CPU Files:
- `week5_top_jal_jalr.vhd` - Top-level CPU with JAL/JALR
- `Control_Unit.vhd` - Updated with Jump signal
- `Imm_Ext.vhd` - Updated with J-type immediate
- `Instruction_Memory_JAL_JALR.vhd` - Test program

### Testbench:
- `jal_jalr_tb.vhd` - Automated testbench

### Dependencies (existing):
- `Program_Counter.vhd`
- `PC_Adder.vhd`
- `Register_File.vhd`
- `ALU.vhd`
- `Data_Memory.vhd`

## How to Run Simulation

### Option 1: Using ModelSim / QuestaSim
```bash
# Compile all files
vcom Control_Unit.vhd
vcom Imm_Ext.vhd
vcom ALU.vhd
vcom Program_Counter.vhd
vcom PC_Adder.vhd
vcom Register_File.vhd
vcom Data_Memory.vhd
vcom Instruction_Memory_JAL_JALR.vhd
vcom week5_top_jal_jalr.vhd
vcom jal_jalr_tb.vhd

# Run simulation
vsim jal_jalr_tb
run 200ns
```

### Option 2: Using GHDL
```bash
# Analyze all files
ghdl -a Control_Unit.vhd
ghdl -a Imm_Ext.vhd
ghdl -a ALU.vhd
ghdl -a Program_Counter.vhd
ghdl -a PC_Adder.vhd
ghdl -a Register_File.vhd
ghdl -a Data_Memory.vhd
ghdl -a Instruction_Memory_JAL_JALR.vhd
ghdl -a week5_top_jal_jalr.vhd
ghdl -a jal_jalr_tb.vhd

# Elaborate and run
ghdl -e jal_jalr_tb
ghdl -r jal_jalr_tb --stop-time=200ns
```

### Option 3: Quartus (what you're probably using)
1. Open your `week5.qpf` project
2. Add these files to project:
   - `Instruction_Memory_JAL_JALR.vhd`
   - `week5_top_jal_jalr.vhd`
   - `jal_jalr_tb.vhd`
3. Update `week5_top.vhd` to use the new instruction memory (or use `week5_top_jal_jalr.vhd`)
4. Tools → Run Simulation Tool → RTL Simulation
5. Set testbench as top-level: `jal_jalr_tb`
6. Run for 200ns

## What to Look For in Simulation

### Key Checkpoints:

| Cycle | PC    | Instruction | What Happens               | Check Register |
|-------|-------|-------------|----------------------------|----------------|
| 2     | 0x00  | addi x10,5  | x10 = 5                    | x10 = 5        |
| 3     | 0x04  | addi x11,3  | x11 = 3                    | x11 = 3        |
| 4     | 0x08  | jal x1,+20  | Jump to 0x1C, x1 = 0x0C    | x1 = 0x0C      |
| 5     | 0x1C  | add x12     | x12 = 5 + 3 = 8            | x12 = 8        |
| 6     | 0x20  | jalr x0,x1  | Return to 0x0C             | PC = 0x0C      |
| 7     | 0x0C  | addi x13,10 | x13 = 8 + 10 = 18          | x13 = 18       |
| 8     | 0x10  | addi x10,x13| x10 = 18                   | x10 = 18       |
| 9     | 0x14  | jal x1,+12  | Jump to 0x24, x1 = 0x18    | x1 = 0x18      |
| 10    | 0x24  | add x12     | x12 = 18 + 18 = 36         | x12 = 36       |
| 11    | 0x28  | jalr x0,x1  | Return to 0x18             | PC = 0x18      |
| 12+   | 0x18  | beq (loop)  | Stay at 0x18 forever       | -              |

### Success Criteria:
✓ PC jumps from 0x08 to 0x1C (JAL works)
✓ x1 register stores 0x0C (return address saved)
✓ PC returns to 0x0C after JALR (return works)
✓ x12 = 36 at the end (computation correct)
✓ PC loops at 0x18 (halt works)

## Debugging Tips

### If PC doesn't jump correctly:
- Check Jump signal in Control_Unit
- Verify immediate extraction in Imm_Ext
- Check PC selection logic in top-level

### If return address is wrong:
- Check ResultSrc = "10" for JAL/JALR
- Verify PC_plus4 calculation
- Check Result multiplexer

### If JALR target is wrong:
- Check ALU computes rs1 + imm
- Verify LSB is cleared (& 0xFFFFFFFE)
- Check opcode detection for JALR vs JAL

## Understanding the Code

### JAL Encoding:
```
Instruction: 0x014000EF (jal x1, +20)
Binary: 0000 0001 0100 0000 0000 0000 1110 1111
        imm[20] imm[10:1]  imm[11] imm[19:12] rd  opcode
        0       0000010100 0        00000000  00001 1101111
Immediate: bit 20=0, bits[10:1]=20, bit 11=0, bits[19:12]=0
Result: +20 bytes = 0x14
```

### JALR Encoding:
```
Instruction: 0x00008067 (jalr x0, x1, 0)
Binary: 0000 0000 0000 00001 000 00000 1100111
        imm[11:0]    rs1    f3  rd    opcode
        0            x1     0   x0    JALR
Immediate: 0
Target: x1 + 0 (return to saved address)
```

## Next Steps

1. **Run the simulation** - Verify functionality
2. **Analyze waveforms** - Understand timing
3. **Modify test program** - Try different functions
4. **Add complexity** - Nested calls, multiple parameters

## Common Questions

**Q: Why does JALR clear the LSB?**
A: RISC-V requires 2-byte aligned addresses. Clearing LSB ensures this.

**Q: Can I use x1 for other purposes?**
A: Yes, but x1 (ra) is conventionally the return address register.

**Q: What if I want to jump without saving return address?**
A: Use `jal x0, offset` - writes to x0 (which ignores writes)

**Q: How do I pass multiple arguments?**
A: Use registers x10-x17 (a0-a7) as per RISC-V calling convention

## Need Help?

Check these files for details:
- `JAL_JALR_IMPLEMENTATION.md` - Full technical documentation
- `jal_jalr_test_program.asm` - Annotated assembly code
- `jal_jalr_tb.vhd` - Testbench with timeline comments

Good luck with your testing! 🚀
