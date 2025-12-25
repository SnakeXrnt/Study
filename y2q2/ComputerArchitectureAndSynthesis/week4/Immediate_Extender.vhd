library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Immediate_Extender is
    port (
        Instr_In : in  STD_LOGIC_VECTOR(31 downto 0);
        Imm_Out  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity Immediate_Extender;

architecture behavioral of Immediate_Extender is
    -- The immediate is contained in bits 31 down to 20
    signal Immediate_12 : STD_LOGIC_VECTOR(11 downto 0) := Instr_In(31 downto 20);
    signal Sign_Bit     : STD_LOGIC := Instr_In(31); 
    
    -- Define the 20-bit sign extension constant based on the sign bit
    constant SIGN_EXT_20_ONES  : STD_LOGIC_VECTOR(19 downto 0) := (others => '1');
    constant SIGN_EXT_20_ZEROS : STD_LOGIC_VECTOR(19 downto 0) := (others => '0');

begin
    process(Immediate_12, Sign_Bit)
    begin
        if Sign_Bit = '1' then
            -- Sign extension for negative immediate (20 leading '1's)
            Imm_Out <= SIGN_EXT_20_ONES & Immediate_12;
            -- Alternatively, using hex (FFF F F -> 5 F's = 20 bits):
            -- Imm_Out <= X"FFFFF" & Immediate_12;
        else
            -- Sign extension for positive immediate (20 leading '0's)
            Imm_Out <= SIGN_EXT_20_ZEROS & Immediate_12;
            -- Alternatively:
            -- Imm_Out <= X"00000" & Immediate_12;
        end if;
    end process;
end architecture behavioral;