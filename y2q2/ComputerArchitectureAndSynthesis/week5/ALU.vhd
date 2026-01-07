library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all; -- Required for arithmetic operations

entity ALU is
    port (
        A, B       : in  STD_LOGIC_VECTOR(31 downto 0); -- 32-bit operands
        ALUControl : in  STD_LOGIC_VECTOR(2 downto 0);  -- Control signal (F)
        ALUResult  : out STD_LOGIC_VECTOR(31 downto 0);
        Zero       : out STD_LOGIC                      -- Zero flag for branching
    );
end entity;


architecture behavioral of ALU is
begin
    process(A, B, ALUControl)
        variable result : UNSIGNED(31 downto 0);
    begin
        case ALUControl is
            when "000" => -- AND
                result := UNSIGNED(A and B);
            when "001" => -- OR
                result := UNSIGNED(A or B);
            when "010" => -- ADD
                result := UNSIGNED(A) + UNSIGNED(B);
            when "110" => -- SUB
                result := UNSIGNED(A) - UNSIGNED(B);
            when "111" => -- SLT
                if UNSIGNED(A) < UNSIGNED(B) then
                    result := to_unsigned(1, 32);
                else
                    result := (others => '0');
                end if;
            when others => 
                result := (others => '0');
        end case;

        -- Assign the final result back to the output port
        ALUResult <= STD_LOGIC_VECTOR(result);

        -- Zero Flag: High if the result is exactly zero [12]
        if result = 0 then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end architecture;
