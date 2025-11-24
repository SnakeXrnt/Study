library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter4Bit is
    port(
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;  -- active high
        enable : in  STD_LOGIC;  -- count when '1'
        count  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end;

architecture rtl of Counter4Bit is
    signal count_reg : unsigned(3 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- reset has highest priority
                count_reg <= (others => '0');
            elsif enable = '1' then
                -- increment only when enabled
                count_reg <= count_reg + 1;
            end if;
        end if;
    end process;

    count <= std_logic_vector(count_reg);

end architecture rtl;
