library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory_with_LW_SW is
    port (
        addr        : in  STD_LOGIC_VECTOR(31 downto 0);
        instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioral of Instruction_Memory_with_LW_SW is
    -- ROM array containing test program with LW/SW instructions
    type rom_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    constant ROM : rom_type := (
        -- Test Program: Store and Load Operations
        0  => X"00500093",  -- addi x1, x0, 5      (x1 = 5)
        1  => X"00C00113",  -- addi x2, x0, 12     (x2 = 12)
        2  => X"00102023",  -- sw x1, 0(x0)        (Memory[0] = 5)
        3  => X"00202223",  -- sw x2, 4(x0)        (Memory[4] = 12)
        4  => X"00002183",  -- lw x3, 0(x0)        (x3 = Memory[0] = 5)
        5  => X"00402203",  -- lw x4, 4(x0)        (x4 = Memory[4] = 12)
        6  => X"004182B3",  -- add x5, x3, x4      (x5 = 5 + 12 = 17)
        7  => X"00A00293",  -- addi x5, x0, 10     (x5 = 10)
        8  => X"01400313",  -- addi x6, x0, 20     (x6 = 20)
        9  => X"00628393",  -- addi x7, x5, 6      (x7 = 10 + 6 = 16)
        10 => X"00502423",  -- sw x5, 8(x0)        (Memory[8] = 10)
        11 => X"00602623",  -- sw x6, 12(x0)       (Memory[12] = 20)
        12 => X"00802403",  -- lw x8, 8(x0)        (x8 = Memory[8] = 10)
        13 => X"00C02483",  -- lw x9, 12(x0)       (x9 = Memory[12] = 20)
        14 => X"00940533",  -- add x10, x8, x9     (x10 = 10 + 20 = 30)
        15 => X"40940533",  -- sub x10, x8, x9     (x10 = 10 - 20 = -10)
        
        others => X"00000000"  -- nop
    );
begin
    -- Word-aligned memory access: use bits [7 downto 2]
    instruction <= ROM(to_integer(unsigned(addr(7 downto 2))));
end architecture;
