library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
    port (
        addr        : in  STD_LOGIC_VECTOR(31 downto 0);
        instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioral of Instruction_Memory is
    -- Example ROM array containing 32-bit instructions [12, 13]
    type rom_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    constant ROM : rom_type := (
        0 => X"00500093",  -- addi x1, x0, 5     (x1 = 0 + 5 = 5)
        1 => X"00A00113",  -- addi x2, x0, 10    (x2 = 0 + 10 = 10)
        2 => X"002081B3",  -- add  x3, x1, x2    (x3 = 5 + 10 = 15)
        3 => X"402081B3",  -- sub  x3, x1, x2    (x3 = 5 - 10 = -5)
        4 => X"0020F233",  -- and  x4, x1, x2    (x4 = 5 & 10)
        5 => X"0020E2B3",  -- or   x5, x1, x2    (x5 = 5 | 10)
        6 => X"00208463",  -- beq  x1, x2, 8     (branch if x1==x2)
        7 => X"00000000",  -- nop
        others => X"00000000"
    );
begin
    -- The PC address points to the word in memory [7]
    -- Divide by 4 or use bits [7 downto 2] because memory is word-aligned
    instruction <= ROM(to_integer(unsigned(addr(7 downto 2))));
end architecture;

