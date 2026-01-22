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
            -- I-Type instructions: addi (0010011) and lw (0000011)
            -- Both use bits [31:20] for a 12-bit signed immediate [2, 3]
            when "0010011" | "0000011" => 
                imm <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));

            -- S-Type instruction: sw (0100011)
            -- The immediate is split between bits [31:25] and [11:7] [2, 4]
            when "0100011" => 
                imm <= std_logic_vector(resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32));

            -- B-Type instruction: beq (1100011)
            -- Reconstructing the scrambled RISC-V branch immediate [2]
            when "1100011" => 
                imm <= std_logic_vector(resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32));

            -- J-Type instruction: jal (1101111)
            -- Immediate format: imm[20|10:1|11|19:12]
            when "1101111" =>
                imm <= std_logic_vector(resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32));

            -- I-Type instruction: jalr (1100111) 
            -- Uses same format as other I-type instructions [31:20]
            when "1100111" =>
                imm <= std_logic_vector(resize(signed(instr(31 downto 20)), 32));

            when others =>
                imm <= (others => '0');
        end case;
    end process;
end architecture;