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
    -- ROM array containing test program 
    type rom_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    constant ROM : rom_type := (
        -- Test Program: XOR (R-Type), XORI (I-Type), BNE (B-Type)
        0  => X"00F00093",  -- addi x1, x0, 15     (x1 = 15)
        1  => X"00A00113",  -- addi x2, x0, 10     (x2 = 10)
        2  => X"0020C1B3",  -- xor  x3, x1, x2     (x3 = 15 XOR 10 = 5)
        3  => X"0140C213",  -- xori x4, x1, 20     (x4 = 15 XOR 20 = 27)
        4  => X"00209463",  -- bne x1, x2, 8       (x1≠x2? Yes, jump to PC+8=20)
        5  => X"00000013",  -- nop (skipped!)      
        6  => X"00208533",  -- add x10, x1, x2     (should execute: x10=25)
        
        others => X"00000000"  -- nop
    );
begin
    -- Word-aligned memory access: use bits [7 downto 2]
    instruction <= ROM(to_integer(unsigned(addr(7 downto 2))));
end architecture;
