# JAL and JALR Implementation for RISC-V CPU

## Overview
This implementation adds function call and return capabilities to the RISC-V CPU by implementing the JAL (Jump and Link) and JALR (Jump and Link Register) instructions.

## Instructions Implemented

### 1. JAL (Jump and Link) - Opcode: 0x6F
**Format:** J-Type
**Encoding:** `imm[20|10:1|11|19:12] rd opcode`
**Operation:**
- Saves the return address (PC + 4) in register `rd`
- Jumps to PC + sign_extended(immediate)
- Immediate is 21 bits (multiples of 2)

**Use Case:** Function calls with known addresses (direct jumps)

### 2. JALR (Jump and Link Register) - Opcode: 0x67
**Format:** I-Type
**Encoding:** `imm[11:0] rs1 000 rd opcode`
**Operation:**
- Saves the return address (PC + 4) in register `rd`
- Jumps to (rs1 + sign_extended(immediate)) & ~1
- LSB is cleared to ensure alignment

**Use Case:** Function returns, indirect jumps, computed addresses

## Hardware Modifications

### 1. Immediate Extender (Imm_Ext.vhd)
**Added:**
- J-Type immediate extraction for JAL
  - Reconstructs scrambled immediate: imm[20|10:1|11|19:12]
  - Sign-extends to 32 bits
  - LSB is always 0 (2-byte aligned)
  
- I-Type support for JALR (same as other I-type instructions)

### 2. Control Unit (Control_Unit.vhd)
**Added:**
- New control signal: `Jump` (indicates JAL/JALR instruction)
- Expanded `ResultSrc` from 1-bit to 2-bit:
  - "00": ALU result (R-type, I-type arithmetic)
  - "01": Memory data (Load)
  - "10": PC + 4 (JAL/JALR for return address)

**New Cases:**
- Opcode "1101111" (JAL):
  - RegWrite = '1' (save return address)
  - Jump = '1' (unconditional jump)
  - ResultSrc = "10" (write PC+4 to rd)
  
- Opcode "1100111" (JALR):
  - RegWrite = '1' (save return address)
  - Jump = '1' (unconditional jump)
  - ALUSrc = '1' (use immediate)
  - ALUControl = "010" (ADD for target calculation)
  - ResultSrc = "10" (write PC+4 to rd)

### 3. Top-Level CPU (week5_top.vhd, week5_top_jal_jalr.vhd)
**Added:**
- `Jump` signal routing
- `JumpTarget` signal for JALR target calculation
- 3-way Result multiplexer (ALU, Memory, PC+4)
- Enhanced PC selection logic:
  ```vhdl
  PC_next <= JumpTarget when (Jump='1' and opcode="1100111") else  -- JALR
             BranchTarget when (Jump='1' or PCSrc='1') else          -- JAL/BEQ
             PC_plus4;                                                -- Normal
  ```

## Test Program

### Assembly Code (jal_jalr_test_program.asm)
```assembly
main:
    addi x10, x0, 5           # x10 = 5
    addi x11, x0, 3           # x11 = 3
    jal x1, add_function      # Call function, x1 = return address
    addi x13, x12, 10         # x13 = result + 10
    addi x10, x13, 0          # Prepare argument
    jal x1, multiply_by_2     # Call second function
    beq x0, x0, halt          # Infinite loop

add_function:
    add x12, x10, x11         # x12 = x10 + x11
    jalr x0, x1, 0            # Return to caller

multiply_by_2:
    add x12, x10, x10         # x12 = x10 * 2
    jalr x0, x1, 0            # Return to caller
```

### Expected Execution Flow
1. **Cycle 2:** x10 = 5
2. **Cycle 3:** x11 = 3
3. **Cycle 4:** JAL to add_function (PC jumps from 0x08 to 0x1C, x1 = 0x0C)
4. **Cycle 5:** x12 = 8 (5 + 3)
5. **Cycle 6:** JALR return (PC returns to 0x0C)
6. **Cycle 7:** x13 = 18 (8 + 10)
7. **Cycle 8:** x10 = 18
8. **Cycle 9:** JAL to multiply_by_2 (PC jumps to 0x24, x1 = 0x18)
9. **Cycle 10:** x12 = 36 (18 * 2)
10. **Cycle 11:** JALR return (PC returns to 0x18)
11. **Cycle 12+:** Infinite loop at 0x18

### Verification Points
- Return address is correctly saved in x1 (ra register)
- PC jumps to correct function addresses
- Functions execute correctly
- JALR returns to correct addresses
- Final result x12 = 36

## Key Design Decisions

### 1. JALR Target Calculation
- Target = (rs1 + immediate) & 0xFFFFFFFE
- LSB clearing ensures 2-byte alignment (RISC-V requirement)
- ALU computes rs1 + imm, then top-level clears LSB

### 2. ResultSrc Expansion
- Changed from 1-bit to 2-bit to support three sources
- Maintains backward compatibility with existing instructions
- Clean separation of concerns

### 3. PC Selection Priority
- JALR has highest priority (most specific)
- JAL and taken branches use BranchTarget (PC + imm)
- Default is PC + 4 for sequential execution

## Testing Instructions

### Simulation
1. Compile all VHDL files including:
   - Control_Unit.vhd
   - Imm_Ext.vhd
   - week5_top_jal_jalr.vhd
   - Instruction_Memory_JAL_JALR.vhd
   - jal_jalr_tb.vhd

2. Run testbench: jal_jalr_tb

3. Observe:
   - PC transitions (0x00 → 0x04 → 0x08 → 0x1C → 0x20 → 0x0C → ...)
   - Register values (x10, x11, x12, x13, x1)
   - Return address storage in x1

### Expected Output
```
PC: 0x00000000 | Instruction: 0x00500513 | ALU Result: 5
PC: 0x00000004 | Instruction: 0x00300593 | ALU Result: 3
PC: 0x00000008 | Instruction: 0x014000EF | ALU Result: ...
PC: 0x0000001C | Instruction: 0x00B50633 | ALU Result: 8
PC: 0x00000020 | Instruction: 0x00008067 | ALU Result: ...
PC: 0x0000000C | Instruction: 0x00A60693 | ALU Result: 18
...
```

## Files Modified/Created

### Modified:
1. **Control_Unit.vhd** - Added Jump signal and JAL/JALR cases
2. **Imm_Ext.vhd** - Added J-type immediate extraction
3. **week5_top.vhd** - Added jump logic and PC+4 writeback

### Created:
1. **Instruction_Memory_JAL_JALR.vhd** - Test program ROM
2. **week5_top_jal_jalr.vhd** - Top-level with JAL/JALR support
3. **jal_jalr_tb.vhd** - Comprehensive testbench
4. **jal_jalr_test_program.asm** - Assembly test program
5. **jal_jalr_program.txt** - Machine code explanation

## Difficulty: ★★☆

This assignment demonstrates:
- Understanding of J-type and I-type instruction formats
- Control flow modification (jumps)
- Register writeback from non-ALU sources
- Function call/return convention
- Multi-way multiplexer design

## Future Enhancements
- Add `jal x0, offset` optimization (unconditional jump without link)
- Implement full ABI calling convention (save/restore registers)
- Add stack pointer management
- Support for nested function calls
