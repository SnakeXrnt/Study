library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; -- Required for address arithmetic [4]

entity Data_Memory is
    port(
        clk      : in  STD_LOGIC;                      -- Clock signal [2]
        MemWrite : in  STD_LOGIC;                      -- Write Enable from Control Unit [2]
        A        : in  STD_LOGIC_VECTOR(31 downto 0); -- Address from ALU [2]
        WD       : in  STD_LOGIC_VECTOR(31 downto 0); -- Write Data from Register File (RD2) [2]
        RD       : out STD_LOGIC_VECTOR(31 downto 0)  -- Read Data to Result Mux [2]
    );
end entity;

architecture behavioral of Data_Memory is
    -- Defining a memory array of 64 words (256 bytes total) [5, 6]
    type ram_type is array (0 to 63) of STD_LOGIC_VECTOR(31 downto 0);
    signal mem : ram_type := (others => (others => '0')); -- Initialize to zero
begin
    -- Synchronous Write: Data is stored only on the rising clock edge [7, 8]
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                -- Byte addressing: Divide address by 4 to get the word index [9, 10]
                mem(to_integer(unsigned(A(7 downto 2)))) <= WD;
            end if;
        end if;
    end process;

    -- Asynchronous Read: Output changes immediately when address changes [11, 12]
    -- Dividing the 32-bit address by 4 by using bits 7 down to 2 [9, 10]
    RD <= mem(to_integer(unsigned(A(7 downto 2))));
    
end architecture;