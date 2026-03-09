library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory_JAL_JALR is
    port (
        addr        : in  STD_LOGIC_VECTOR(31 downto 0);
        instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioral of Instruction_Memory_JAL_JALR is
    -- ROM array containing test program with JAL/JALR instructions
    type rom_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    constant ROM : rom_type := (
        --- PROLOGUE (Setup) ---
			0 => "11111101000000000000000000010011", -- addi sp, sp, -48 (Allocate stack)
			1 => "01011000000000000010000000100011", -- sw s0, 32(sp)      (Save frame pointer)
			2 => "00000011000000000000000000010011", -- addi s0, sp, 48   (Set frame pointer)

			--- INITIALIZATION ---
			3 => "00000110010000000000001010010011", -- li t0, 100         (Set limit = 100)
			4 => "11000000010100000010111110100011", -- sw t0, -32(s0)     (Store limit)
			5 => "10111000000000000010111110100011", -- sw zero, -48(s0)   (Store counter = 0)
			6 => "00000000000100000000001010010011", -- li t0, 1           (Load 1)
			7 => "11010000010100000010111110100011", -- sw t0, -16(s0)     (Store total = 1)

			--- LOOP START (Condition Check) ---
			8 => "11111101110000000010001000000011", -- lw t0, -48(s0)     (Load counter)
			9 => "11111110100000000010001010000011", -- lw t1, -32(s0)     (Load limit)
			10 => "00000000010100100000001010110011", -- blt t0, t1, 4      (If counter < limit, continue)
			11 => "11001000010100000010111110100011", -- j 28               (Else, jump to exit)

			--- LOOP BODY (Math) ---
			12 => "00000000001100000000001010010011", -- li t0, 3           (Load 3)
			13 => "11011000010100000010111110100011", -- sw t0, -20(s0)     (Store 3)
			14 => "11111110110000000010001000000011", -- lw t0, -20(s0)     (Reload 3)
			15 => "11111110000000000010001010000011", -- lw t1, -16(s0)     (Reload total)
			16 => "00000010010100100100101001100011", -- add t0, t0, t1     (total = total + 3)
			17 => "11111110100000000010001010000011", -- sw t0, -16(s0)     (Store updated total)

			--- INCREMENT COUNTER ---
			18 => "10111000010100000010111110100011", -- lw t0, -48(s0)     (Load counter)
			19 => "11111110010000000010001010000011", -- addi t0, t0, 1     (counter++)
			20 => "11010000010100000010111110100011", -- sw t0, -48(s0)     (Store counter)

			--- REPEAT LOOP ---
			21 => "11111101110000000010001000000011", -- lw t0, -48(s0)     (Load counter)
			22 => "11111110100000000010001010000011", -- lw t1, -32(s0)     (Load limit)
			23 => "00000000010100100000001010110011", -- blt t0, t1, -60    (Jump back to start of loop)

			--- EXIT SEQUENCE ---
			24 => "11001000010100000010111110100011", -- j 28               (Jump to cleanup)
			25 => "11111110110000000010001010000011", -- lw a0, -16(s0)     (Load result into return reg)
			26 => "00000000000100101000001010010011", -- li a0, 0           (Set return status 0)
			27 => "11011000010100000010111110100011", -- nop                (No operation/padding)
			28 => "11111100100111111111000001101111", -- jal zero, exit     (Jump to epilogue)

			--- EPILOGUE (Cleanup) ---
			29 => "00000000000000101000000000010011", -- li a0, 0           (Final return value)
			30 => "00000000000000000000001010010011", -- lw s0, 32(sp)      (Restore old frame pointer)
			31 => "00000010110000000010000000000011", -- addi sp, sp, 48    (Deallocate stack)
			32 => "00000011000000000000000000010011", -- ret                (Return to caller)
        others => X"00000000"  -- nop (no operation)
    );
begin
    -- Word-aligned memory access: use bits [7 downto 2]
    instruction <= ROM(to_integer(unsigned(addr(7 downto 2))));
end architecture;
