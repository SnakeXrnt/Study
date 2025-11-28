library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    PORT(
    A, B : in STD_LOGIC_VECTOR(31 downto 0);
    ALU_Select : in STD_LOGIC_VECTOR(2 downto 0);
    ALU_Out : out STD_LOGIC_VECTOR(31 downto 0);
    Carryout: out STD_LOGIC
    );
end;

architecture synthetic of ALU is

signal ALU_Res : std_logic_vector(31 downto 0);

begin
    process(A, B, ALU_Select)
    begin
        case(ALU_Select) is --add
            when "000" => ALU_Res <= A + B; 
         --minus
            when "001" => ALU_Res <= A - B;
         --AND
            when "010" => ALU_Res <= A and B;
         --OR
            when "011" => ALU_Res <= A or B;
        --case(ALU_Select) is --Shift Left
            --when "100" => ALU_Res <= A
            when others =>ALU_Res <= A + B;
        end case;
        end process;
        ALU_Out <= ALU_Res;
    end synthetic;
        
