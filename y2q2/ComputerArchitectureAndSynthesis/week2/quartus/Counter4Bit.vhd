library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- We are ONLY using this one now

entity Counter_4bit is
    Port ( 
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        count  : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Counter_4bit;

architecture Behavioral of Counter_4bit is
    
    -- CHANGE 1: The internal signal MUST be defined as 'UNSIGNED'
    -- If we used std_logic_vector here, the '+' operator would fail.
    signal temp_count : unsigned(3 downto 0) := "0000";

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- We assign "0000" to the unsigned signal
                temp_count <= "0000";
            
            elsif enable = '1' then
                -- CHANGE 2: Math works now! 
                -- Because 'temp_count' is explicitly UNSIGNED, the library knows how to add.
                temp_count <= temp_count + 1;
            end if;
        end if;
    end process;

    -- CHANGE 3: The Output Conversion
    -- The outside world expects a STD_LOGIC_VECTOR (the pins).
    -- But our internal signal is UNSIGNED.
    -- We must "Type Cast" (convert) it to pass it out.
    count <= std_logic_vector(temp_count);

end Behavioral;