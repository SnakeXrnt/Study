library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
    port(
        clk      : in  std_logic;
        we       : in  std_logic;                     
        addr     : in  std_logic_vector(31 downto 0); 
        wd       : in  std_logic_vector(31 downto 0); 
        rd       : out std_logic_vector(31 downto 0)  
    );
end entity;

architecture behavioral of Data_Memory is
    type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
    signal mem : ram_type := (others => (others => '0'));
begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                
                mem(to_integer(unsigned(addr(7 downto 2)))) <= wd;
            end if;
        end if;
    end process;
    rd <= mem(to_integer(unsigned(addr(7 downto 2))));
end architecture;
