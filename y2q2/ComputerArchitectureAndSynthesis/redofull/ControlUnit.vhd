library IEEE;
use IEEE.STD_LOGIC_1164.all; -- Required for STD_LOGIC types [4]

entity ControlUnit is
    port(
        op          : in  STD_LOGIC_VECTOR(6 downto 0); -- Level 1: Opcode [2]
        funct3      : in  STD_LOGIC_VECTOR(2 downto 0); -- Level 2: Funct3 [2]
        funct7      : in  STD_LOGIC_VECTOR(6 downto 0); -- Level 2: Funct7 [2]
        RegWrite    : out STD_LOGIC;                    -- Enable register storage [5]
        ALUSrc      : out STD_LOGIC;                    -- Select Reg vs Immediate [6]
        Branch      : out STD_LOGIC;                    -- Enable branch decision logic
        Jump        : out STD_LOGIC;                    -- Enable unconditional jump (JAL/JALR)
        MemWrite    : out STD_LOGIC;                    -- Enable data memory write
        ResultSrc   : out STD_LOGIC_VECTOR(1 downto 0); -- Select ALU result (00) vs Memory data (01) vs PC+4 (10)
        ALUControl  : out STD_LOGIC_VECTOR(2 downto 0)  -- ALU Operation code [7, 8]
    );
end entity;

architecture behavioral of ControlUnit is
begin
    process(op, funct3, funct7) 
    begin
        -- Default values: Prevents unintended hardware latches
        RegWrite   <= '0';
        ALUSrc     <= '0';
        Branch     <= '0';
        Jump       <= '0';
        MemWrite   <= '0';
        ResultSrc  <= "00";
        ALUControl <= "000";

        case op is 
            when "0110011" => -- R-type (Register-Register)
                RegWrite <= '1';
                ALUSrc   <= '0'; -- Use Register B
                if funct7 = "0000000" then
                    case funct3 is
                        when "000" => ALUControl <= "010"; -- add
                        when "001" => ALUControl <= "100"; -- sll
                        when "010" => ALUControl <= "111"; -- slt
                        when "110" => ALUControl <= "001"; -- or
                        when "111" => ALUControl <= "000"; -- and
                        when others => null;
                    end case;
                elsif funct7 = "0100000" then
                    if funct3 = "000" then ALUControl <= "011"; -- sub
                    elsif funct3 = "101" then ALUControl <= "110"; -- sra
                    end if;
                end if;

            when "0010011" => -- I-type (Register-Immediate) 
                RegWrite <= '1';
                ALUSrc   <= '1'; -- Use Immediate value 
                case funct3 is
                    when "000" => ALUControl <= "010"; -- addi 
                    when "010" => ALUControl <= "111"; -- slti 
                    when "110" => ALUControl <= "001"; -- ori 
                    when "111" => ALUControl <= "000"; -- andi 
                    when "001" => -- slli 
                        if funct7 = "0000000" then ALUControl <= "100"; end if;
                    when "101" => -- srli / srai 
                        if funct7 = "0000000" then ALUControl <= "101"; -- srli
                        elsif funct7 = "0100000" then ALUControl <= "110"; -- srai
                        end if;
                    when others => null;
                end case;

            when others => null;
        end case;
    end process;
end architecture;
