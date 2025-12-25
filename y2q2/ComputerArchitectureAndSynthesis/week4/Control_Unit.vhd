library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    port (
        Instr       : in  STD_LOGIC_VECTOR(31 downto 0);
        RegWrite    : out STD_LOGIC;
        ALUOp       : out STD_LOGIC_VECTOR(1 downto 0);
        ALUSrc      : out STD_LOGIC
    );
end entity Control_Unit;

architecture R_I_Decoder of Control_Unit is
    
    -- USE ALIASES: These act as direct references to the slices of Instr.
    -- They update automatically when Instr changes.
    alias Opcode : STD_LOGIC_VECTOR(6 downto 0) is Instr(6 downto 0);
    alias Funct3 : STD_LOGIC_VECTOR(2 downto 0) is Instr(14 downto 12);
    alias Funct7 : STD_LOGIC_VECTOR(6 downto 0) is Instr(31 downto 25);
    
    -- Internal Signals
    signal RegWrite_internal : STD_LOGIC;
    signal ALUOp_internal    : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUSrc_internal   : STD_LOGIC;
    
begin
    
    process(Instr) -- Sensitive to Instr (which aliases point to)
    begin
        
        -- 1. Default/Safe States
        RegWrite_internal <= '0';
        ALUOp_internal    <= (others => '0');
        ALUSrc_internal   <= '0'; 

        -- 2. Decode based on Opcode
        case Opcode is
            
            -- R-TYPE INSTRUCTIONS (add, sub, and, or)
            when "0110011" =>
                RegWrite_internal <= '1';
                ALUSrc_internal   <= '0';
                
                -- Inner Case for Funct3
                case Funct3 is
                    when "000" => -- ADD or SUB
                        if Funct7 = "0000000" then
                            ALUOp_internal <= "00"; -- ADD
                        elsif Funct7 = "0100000" then
                            ALUOp_internal <= "01"; -- SUB
                        end if;
                        
                    when "111" => -- AND
                        if Funct7 = "0000000" then
                            ALUOp_internal <= "10"; 
                        end if;

                    when "110" => -- OR
                        if Funct7 = "0000000" then
                            ALUOp_internal <= "11"; 
                        end if;
                        
                    when others =>
                        null;
                end case; -- FIXED: Added missing end case for Funct3

            -- I-TYPE INSTRUCTION (addi)
            when "0010011" =>
                if Funct3 = "000" then -- addi
                    RegWrite_internal <= '1';
                    ALUOp_internal    <= "00";
                    ALUSrc_internal   <= '1';
                end if;
            
            -- Unhandled Instructions
            when others =>
                null;
                
        end case; -- FIXED: This must be inside the process

    end process;

    -- 3. Output Assignment
    RegWrite <= RegWrite_internal;
    ALUOp    <= ALUOp_internal;
    ALUSrc   <= ALUSrc_internal;

end architecture R_I_Decoder;