library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter is
    port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        PC_next  : in  STD_LOGIC_VECTOR(31 downto 0); -- Input from the adder
        PC_out   : out STD_LOGIC_VECTOR(31 downto 0)  -- Address to Memory
    );
end entity;

architecture behavioral of Program_Counter is
begin
    -- Use the process keyword for sequential logic [6]
    process(clk, reset) 
    begin
        if reset = '1' then
            PC_out <= (others => '0'); -- Reset to 0x00000000 [7]
        elsif rising_edge(clk) then
            PC_out <= PC_next; -- Synchronous update [3]
        end if;
    end process;
end architecture;