library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fetch_Stage is
    port (
        clk   : in STD_LOGIC;
        reset : in STD_LOGIC;
        Instr : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture structural of Fetch_Stage is
    signal pc_current, pc_next : STD_LOGIC_VECTOR(31 downto 0);
begin
    -- Instantiate and connect the components [16]
    PC_REG: entity work.Program_Counter 
        port map(clk => clk, reset => reset, PC_next => pc_next, PC_out => pc_current);

    ADDER: entity work.PC_Adder 
        port map(current_PC => pc_current, next_PC => pc_next);

    INST_MEM: entity work.Instruction_Memory 
        port map(addr => pc_current, instruction => Instr);
end architecture;
