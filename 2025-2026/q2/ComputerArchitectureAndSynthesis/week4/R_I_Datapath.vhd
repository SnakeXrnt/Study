library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- NUMERIC_STD is often useful, although standard vector slicing is used for addresses here.

entity R_I_Datapath is
    port (
        CLK   : in  STD_LOGIC;                         -- Clock signal for synchronous elements (Register File)
        Instr : in  STD_LOGIC_VECTOR(31 downto 0)      -- The 32-bit instruction word input
    );
end entity R_I_Datapath;

architecture structural of R_I_Datapath is

    -- 1. COMPONENT DECLARATIONS
    
    -- Component for the Control Unit (Assumed entity: Control_Unit)
    component Control_Unit
        port (
            Instr    : in  STD_LOGIC_VECTOR(31 downto 0);
            RegWrite : out STD_LOGIC;
            ALUOp    : out STD_LOGIC_VECTOR(1 downto 0);
            ALUSrc   : out STD_LOGIC
        );
    end component;

    -- Component for the Register File (Assumed entity: regfile)
    component regfile
        port (
            clk : in STD_LOGIC;
            we3 : in STD_LOGIC;                                  -- Write Enable (controlled by RegWrite)
            a1  : in STD_LOGIC_VECTOR(4 downto 0);               -- Read Address 1 (RS1)
            a2  : in STD_LOGIC_VECTOR(4 downto 0);               -- Read Address 2 (RS2)
            a3  : in STD_LOGIC_VECTOR(4 downto 0);               -- Write Address (RD)
            wd3 : in STD_LOGIC_VECTOR(31 downto 0);              -- Write Data (ALU Result)
            rd1 : out STD_LOGIC_VECTOR(31 downto 0);             -- Read Data 1 (ALU Input A)
            rd2 : out STD_LOGIC_VECTOR(31 downto 0)              -- Read Data 2 (MUX Input 0)
        );
    end component;

    -- Component for the ALU (Assumed entity: riscv_alu)
    component riscv_alu
        port (
            A      : in  STD_LOGIC_VECTOR(31 downto 0);
            B      : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUOP  : in  STD_LOGIC_VECTOR(1 downto 0);
            Result : out STD_LOGIC_VECTOR(31 downto 0);
            Zero   : out STD_LOGIC
        );
    end component;

    -- Component for the Immediate Extender (Assumed entity: Immediate_Extender)
    component Immediate_Extender
        port (
            Instr_In : in  STD_LOGIC_VECTOR(31 downto 0);
            Imm_Out  : out STD_LOGIC_VECTOR(31 downto 0)        -- MUX Input 1
        );
    end component;
    
    
    -- 2. INTERNAL SIGNAL DECLARATIONS (WIRING)
    
    -- Control Signals (Outputs of Control_Unit)
    signal RegWrite_s : STD_LOGIC;
    signal ALUOp_s    : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUSrc_s   : STD_LOGIC;                          -- MUX Select signal [3], [4]

    -- **Address Signals (Dynamically extracted from instruction)**
    signal RS1_ADDR_s : STD_LOGIC_VECTOR(4 downto 0);       -- Connects to regfile a1
    signal RS2_ADDR_s : STD_LOGIC_VECTOR(4 downto 0);       -- Connects to regfile a2
    signal RD_ADDR_s  : STD_LOGIC_VECTOR(4 downto 0);       -- Connects to regfile a3

    -- Data Signals
    signal RS1_Data_s   : STD_LOGIC_VECTOR(31 downto 0);      -- Read Data 1 (ALU Input A)
    signal RS2_Data_s   : STD_LOGIC_VECTOR(31 downto 0);      -- Read Data 2 (MUX Input 0)
    signal Imm_Extended_s : STD_LOGIC_VECTOR(31 downto 0);    -- Immediate Value (MUX Input 1)
    signal ALU_B_Input_s  : STD_LOGIC_VECTOR(31 downto 0);    -- Output of MUX (ALU Input B)
    signal ALU_Result_s : STD_LOGIC_VECTOR(31 downto 0);      -- ALU Result (RegFile Write Data)
    signal ALU_Zero_s : STD_LOGIC;                            -- Zero flag output

begin

    -- 3. CONCURRENT ADDRESS EXTRACTION (Combinational Logic)
    -- This section translates the instruction fields into dynamic address signals.
    RS1_ADDR_s <= Instr(19 downto 15);
    RS2_ADDR_s <= Instr(24 downto 20);
    RD_ADDR_s  <= Instr(11 downto 7);

    
    -- 4. COMPONENT INSTANTIATIONS (Structural Connections using Hierarchy [1], [5])

    -- A. Control Unit: Instruction Decoding
    CU: Control_Unit
        port map (
            Instr    => Instr,
            RegWrite => RegWrite_s,
            ALUOp    => ALUOp_s,
            ALUSrc   => ALUSrc_s
        );

    -- B. Immediate Extender: Calculates Immediate Value (I-Type Support)
    IE: Immediate_Extender
        port map (
            Instr_In => Instr,
            Imm_Out  => Imm_Extended_s
        );
        
    -- C. ALU Input Multiplexer (2:1 MUX)
    -- This MUX selects ALU input B based on the ALUSrc control signal [6], [7].
    -- '0' selects Register Data (R-Type), '1' selects Immediate Data (I-Type: addi).
    ALU_MUX: with ALUSrc_s select
        ALU_B_Input_s <= RS2_Data_s when '0',
                         Imm_Extended_s when '1',
                         (others => 'X') when others;


    -- D. Register File: Multi-ported memory for temporary variables [8]
    RF: regfile
        port map (
            clk => CLK,
            we3 => RegWrite_s,
            a1  => RS1_ADDR_s,
            a2  => RS2_ADDR_s,
            a3  => RD_ADDR_s,
            wd3 => ALU_Result_s,
            rd1 => RS1_Data_s,          -- Output to ALU A input
            rd2 => RS2_Data_s           -- Output to MUX input 0
        );

    -- E. Arithmetic Logic Unit (ALU): Core calculation unit [9]
    ALU: riscv_alu
        port map (
            A      => RS1_Data_s,        -- Input A always comes from Register File (rd1)
            B      => ALU_B_Input_s,     -- Input B comes from the MUX output
            ALUOP  => ALUOp_s,           -- Control Signal from Control Unit
            Result => ALU_Result_s,      -- Connects back to RegFile Write Data (wd3)
            Zero   => ALU_Zero_s
        );

end architecture structural;
