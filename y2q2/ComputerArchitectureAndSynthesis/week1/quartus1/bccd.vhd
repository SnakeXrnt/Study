library IEEE; use IEEE.STD_LOGIC_1164.all;

entity bccd is
    port(
        bin : in  std_logic_vector(3 downto 0);  -- 0 to 15
        seg : out std_logic_vector(6 downto 0)   -- g f e d c b a, active low
    );
end entity;

architecture synth of bccd is
begin
    process(bin) is
    begin
        case bin is
            --            gfedcba
            when "0000" => seg <= "1000000";  -- 0
            when "0001" => seg <= "1111001";  -- 1
            when "0010" => seg <= "0100100";  -- 2
            when "0011" => seg <= "0110000";  -- 3
            when "0100" => seg <= "0011001";  -- 4
            when "0101" => seg <= "0010010";  -- 5
            when "0110" => seg <= "0000010";  -- 6
            when "0111" => seg <= "1111000";  -- 7
            when "1000" => seg <= "0000000";  -- 8
            when "1001" => seg <= "0010000";  -- 9
            -- hex A to F
            when "1010" => seg <= "0001000";  -- A
            when "1011" => seg <= "0000011";  -- b
            when "1100" => seg <= "1000110";  -- C
            when "1101" => seg <= "0100001";  -- d
            when "1110" => seg <= "0000110";  -- E
            when "1111" => seg <= "0001110";  -- F
            when others => seg <= "1111111";  -- all off
        end case;
    end process;
end architecture;
