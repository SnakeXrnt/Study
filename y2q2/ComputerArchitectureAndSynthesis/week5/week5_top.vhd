library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity week5_top is
    port(
        clk         : in  std_logic;
        reset       : in  std_logic;
        -- Debug outputs
        PC_debug    : out std_logic_vector(31 downto 0);
        instr_debug : out std_logic_vector(31 downto 0);
        ALU_debug   : out std_logic_vector(31 downto 0)
    );
end entity;

architecture structural of week5_top is
    -- Signal declarations (Internal Wiring)
    signal PC_out, PC_next, PC_plus4, BranchTarget : std_logic_vector(31 downto 0);
    signal instr : std_logic_vector(31 downto 0);
    signal RegWrite, ALUSrc, Branch, Zero, PCSrc : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    signal RD1, RD2, ImmExt_out, SrcB, ALUResult : std_logic_vector(31 downto 0);

begin
    -- 1. FETCH STAGE
    PC_Reg: entity work.Program_Counter port map(clk, reset, PC_next, PC_out);
    PC_Add: entity work.PC_Adder port map(PC_out, PC_plus4);
    InstMem: entity work.Instruction_Memory port map(PC_out, instr);

    -- 2. DECODE STAGE
    Control: entity work.Control_Unit port map(instr(6 downto 0), instr(14 downto 12), instr(31 downto 25), RegWrite, ALUSrc, Branch, ALUControl);
    RegFile: entity work.Register_File port map(clk, RegWrite, instr(19 downto 15), instr(24 downto 20), instr(11 downto 7), ALUResult, RD1, RD2);
    ExtUnit: entity work.Imm_Ext port map(instr, ImmExt_out);

    -- 3. EXECUTE STAGE
    -- Mux for ALU Source B
    SrcB <= ImmExt_out when ALUSrc = '1' else RD2;
    
    CoreALU: entity work.ALU port map(RD1, SrcB, ALUControl, ALUResult, Zero);

    -- 4. BRANCH LOGIC
    -- Calculate target and decide next PC
    BranchTarget <= std_logic_vector(unsigned(PC_out) + unsigned(ImmExt_out));
    PCSrc        <= Branch AND Zero; -- Jump if it's a branch AND registers are equal [8]
    
    -- PC Selection Multiplexer
    PC_next <= BranchTarget when PCSrc = '1' else PC_plus4;

    -- Debug outputs
    PC_debug    <= PC_out;
    instr_debug <= instr;
    ALU_debug   <= ALUResult;

end architecture;