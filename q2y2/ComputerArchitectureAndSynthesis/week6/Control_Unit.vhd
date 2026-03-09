library IEEE;
use IEEE.STD_LOGIC_1164.all; -- Required for STD_LOGIC types [4]

entity Control_Unit is
    port(
        op          : in  STD_LOGIC_VECTOR(6 downto 0); -- Level 1: Opcode [2]
        funct3      : in  STD_LOGIC_VECTOR(2 downto 0); -- Level 2: Funct3 [2]
        funct7      : in  STD_LOGIC_VECTOR(6 downto 0); -- Level 2: Funct7 [2]
        RegWrite    : out STD_LOGIC;                    -- Enable register storage [5]
        ALUSrc      : out STD_LOGIC;                    -- Select Reg vs Immediate [6]
        Branch      : out STD_LOGIC;                    -- Enable branch decision logic
        MemWrite    : out STD_LOGIC;                    -- Enable data memory write
        ResultSrc   : out STD_LOGIC;                    -- Select ALU result vs Memory data
        ALUControl  : out STD_LOGIC_VECTOR(2 downto 0)  -- ALU Operation code [7, 8]
    );
end entity;

architecture behavioral of Control_Unit is
begin
    -- The process is executed whenever any input variable changes [9]
    process(op, funct3, funct7) 
    begin
        case op is
            when "0110011" => -- R-Type instructions (add, sub, and, or) [5, 10]
                RegWrite   <= '1'; -- Result is written to rd [5]
                ALUSrc     <= '0'; -- Use second register rs2 [6]
                Branch     <= '0';
                MemWrite   <= '0'; -- No memory write
                ResultSrc  <= '0'; -- Use ALU result
                
                -- Level 2: ALU Decoder logic based on funct3 and funct7 [2]
                if funct7 = "0000000" then
                    if funct3 = "000" then
                        ALUControl <= "010"; -- ADD [7, 8]
                    elsif funct3 = "111" then
                        ALUControl <= "000"; -- AND [7, 8]
                    else -- funct3 is 110
                        ALUControl <= "001"; -- OR [7, 8]
                    end if;
                else -- funct7 is 0100000
                    ALUControl <= "110"; -- SUB [7, 8]
                end if;

            when "0010011" => -- I-Type instruction (addi) [11, 12]
                RegWrite   <= '1';   -- Save result to register [12]
                ALUSrc     <= '1';   -- Use immediate constant [12, 13]
                Branch     <= '0';
                MemWrite   <= '0';   -- No memory write
                ResultSrc  <= '0';   -- Use ALU result
                ALUControl <= "010"; -- Always ADD for addi [12]

            when "0000011" => -- Load instruction (lw)
                RegWrite   <= '1';   -- Write memory data to register
                ALUSrc     <= '1';   -- Use immediate for address calculation
                Branch     <= '0';
                MemWrite   <= '0';   -- Reading from memory
                ResultSrc  <= '1';   -- Use memory data (not ALU result)
                ALUControl <= "010"; -- ADD for address calculation

            when "0100011" => -- Store instruction (sw)
                RegWrite   <= '0';   -- No register write
                ALUSrc     <= '1';   -- Use immediate for address calculation
                Branch     <= '0';
                MemWrite   <= '1';   -- Writing to memory
                ResultSrc  <= '0';   -- Don't care (no writeback)
                ALUControl <= "010"; -- ADD for address calculation

            when "1100011" => -- Branch instruction (beq)
                RegWrite   <= '0';   -- No register write during branch
                ALUSrc     <= '0';   -- Compare two registers
                Branch     <= '1';   -- Signal to consider jumping
                MemWrite   <= '0';   -- No memory write
                ResultSrc  <= '0';   -- Don't care (no writeback)
                ALUControl <= "110"; -- Subtract to check if Zero [7, 8]

            when others => -- Default case to avoid latches [14]
                RegWrite   <= '0';
                ALUSrc     <= '0';
                Branch     <= '0';
                MemWrite   <= '0';
                ResultSrc  <= '0';
                ALUControl <= "000";
        end case;
    end process;
end architecture;