library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity week5_top_jal_jalr is
    port(
        clk         : in  std_logic;
        reset       : in  std_logic;
        -- Debug outputs
        PC_debug    : out std_logic_vector(31 downto 0);
        instr_debug : out std_logic_vector(31 downto 0);
        ALU_debug   : out std_logic_vector(31 downto 0);
        -- Register File Debug outputs (to see calculation results)
        RD1_debug   : out std_logic_vector(31 downto 0);
        RD2_debug   : out std_logic_vector(31 downto 0);
        Result_debug: out std_logic_vector(31 downto 0)
    );
end entity;

architecture structural of week5_top_jal_jalr is
    -- Signal declarations (Internal Wiring)
    signal PC_out, PC_next, PC_plus4, BranchTarget, JumpTarget : std_logic_vector(31 downto 0);
    signal instr : std_logic_vector(31 downto 0);
    signal RegWrite, ALUSrc, Branch, Zero, PCSrc, MemWrite, Jump : std_logic;
    signal ResultSrc : std_logic_vector(1 downto 0);
    signal ALUControl : std_logic_vector(2 downto 0);
    signal RD1, RD2, ImmExt_out, SrcB, ALUResult, ReadData, Result : std_logic_vector(31 downto 0);

begin
    -- 1. FETCH STAGE
    PC_Reg: entity work.Program_Counter port map(clk, reset, PC_next, PC_out);
    PC_Add: entity work.PC_Adder port map(PC_out, PC_plus4);
    InstMem: entity work.Instruction_Memory_JAL_JALR port map(PC_out, instr);

    -- 2. DECODE STAGE
    Control: entity work.Control_Unit port map(instr(6 downto 0), instr(14 downto 12), instr(31 downto 25), RegWrite, ALUSrc, Branch, Jump, MemWrite, ResultSrc, ALUControl);
    RegFile: entity work.Register_File port map(clk, RegWrite, instr(19 downto 15), instr(24 downto 20), instr(11 downto 7), Result, RD1, RD2);
    ExtUnit: entity work.Imm_Ext port map(instr, ImmExt_out);

    -- 3. EXECUTE STAGE
    -- Mux for ALU Source B
    SrcB <= ImmExt_out when ALUSrc = '1' else RD2;
    
    CoreALU: entity work.ALU port map(RD1, SrcB, ALUControl, ALUResult, Zero);

    -- 4. MEMORY STAGE
    DataMem: entity work.Data_Memory port map(clk, MemWrite, ALUResult, RD2, ReadData);
    
    -- Result Multiplexer: Select between ALU result (00), memory data (01), and PC+4 (10)
    Result <= ReadData when ResultSrc = "01" else
              PC_plus4 when ResultSrc = "10" else
              ALUResult;

    -- 5. BRANCH AND JUMP LOGIC
    -- Calculate branch target: PC + immediate (for beq and jal)
    BranchTarget <= std_logic_vector(unsigned(PC_out) + unsigned(ImmExt_out));
    
    -- Calculate jump target for JALR: (rs1 + immediate) with LSB cleared
    JumpTarget <= ALUResult(31 downto 1) & '0';
    
    -- Branch decision: jump if it's a branch AND registers are equal
    PCSrc <= Branch AND Zero;
    
    -- PC Selection: Jump (JAL/JALR) overrides branch
    -- For JAL: use BranchTarget (PC + imm)
    -- For JALR: use JumpTarget (rs1 + imm with LSB=0)
    PC_next <= JumpTarget when (Jump = '1' and instr(6 downto 0) = "1100111") else  -- JALR
               BranchTarget when (Jump = '1' or PCSrc = '1') else                     -- JAL or BEQ taken
               PC_plus4;                                                               -- Normal increment

    -- Debug outputs
    PC_debug    <= PC_out;
    instr_debug <= instr;
    ALU_debug   <= ALUResult;
    RD1_debug   <= RD1;
    RD2_debug   <= RD2;
    Result_debug<= Result;

end architecture;
