library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Imm_Ext is
    port(
        instr : in  STD_LOGIC_VECTOR(31 downto 0);
        imm   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture behavioral of Imm_Ext is
begin
    process(instr)
        variable op : std_logic_vector(6 downto 0);
    begin
        op := instr(6 downto 0);
        case op is
            when "0010011" => -- I-Type (addi)
                imm <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));
            when "1100011" => -- B-Type (beq)
                -- Reconstructing the scrambled RISC-V branch immediate
                imm <= std_logic_vector(resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32));
            when others =>
                imm <= (others => '0');
        end case;
    end process;
end architecture;