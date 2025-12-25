library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity riscv_alu is 
    port (
        A       : in STD_LOGIC_VECTOR(31 downto 0);
        B       : in STD_LOGIC_VECTOR(31 downto 0);
        ALUOP   : in STD_LOGIC_VECTOR(1 downto 0);
        Result  : out STD_LOGIC_VECTOR(31 downto 0);
        Zero    : out STD_LOGIC
    )
end entity riscv_alu;

architecture behavioud of riscv_alu is 

    signal ALUR_temp : STD_LOGIC_VECTOR(31 downto 0);

    


