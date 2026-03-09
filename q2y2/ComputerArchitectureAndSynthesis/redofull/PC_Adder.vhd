library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity PC_Adder is
    port (
        current_PC : in  STD_LOGIC_VECTOR(31 downto 0);
        next_PC    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioral of PC_Adder is
begin
    -- Increments the address by 4 for the next instruction [7]
    next_PC <= current_PC + 4; 
end architecture;
