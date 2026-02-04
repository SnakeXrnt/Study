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
        -- Test Program: Function Calls with JAL and JALR
        -- main:
        0  => X"00500513",  -- addi x10, x0, 5       (x10 = 5, arg1)
        1  => X"00300593",  -- addi x11, x0, 3       (x11 = 3, arg2)
        2  => X"014000EF",  -- jal x1, add_function  (call function at offset 20)
        3  => X"00A60693",  -- addi x13, x12, 10     (x13 = x12 + 10)
        4  => X"00068513",  -- addi x10, x13, 0      (x10 = x13, arg for next call)
        5  => X"010000EF",  -- jal x1, multiply_by_2 (call function at offset 16)
        -- halt:
        6  => X"00000063",  -- beq x0, x0, halt      (infinite loop)
        
        -- add_function: (address 7 in array = PC 0x1C)
        7  => X"00B50633",  -- add x12, x10, x11     (x12 = x10 + x11)
        8  => X"00008067",  -- jalr x0, x1, 0        (return to caller)
        
        -- multiply_by_2: (address 9 in array = PC 0x24)
        9  => X"00A50633",  -- add x12, x10, x10     (x12 = x10 * 2)
        10 => X"00008067",  -- jalr x0, x1, 0        (return to caller)
        
        others => X"00000000"  -- nop (no operation)
    );
begin
    -- Word-aligned memory access: use bits [7 downto 2]
    instruction <= ROM(to_integer(unsigned(addr(7 downto 2))));
end architecture;
