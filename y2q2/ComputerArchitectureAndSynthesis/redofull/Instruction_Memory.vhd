library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
    port(
        A  : in  std_logic_vector(31 downto 0); 
        RD : out std_logic_vector(31 downto 0)  
    );
end entity;

architecture behavioral of Instruction_Memory is
    type rom_type is array (0 to 63) of std_logic_vector(31 downto 0);

    signal mem : rom_type := (
        0 => "00000000010100000000001010010011",   
        1 => "00000000101000000000001100010011",  
        2 => "00000000011000101000001110110011",  
        others => (others => '0')
    );

begin
    RD <= mem(to_integer(unsigned(A(7 downto 2))));
end architecture;
