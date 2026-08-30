library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity riscv_top is 
    port(
        clk          : in  std_logic;
        reset        : in  std_logic;
        PC_debug     : out std_logic_vector(31 downto 0);
        instr_debug  : out std_logic_vector(31 downto 0);
        ALU_debug    : out std_logic_vector(31 downto 0);
        RD1_debug    : out std_logic_vector(31 downto 0);
        RD2_debug    : out std_logic_vector(31 downto 0);
        Result_debug : out std_logic_vector(31 downto 0)
    );
end entity;

architecture structural of riscv_top is
    signal PC_current  : std_logic_vector(31 downto 0);
    signal instr       : std_logic_vector(31 downto 0);
    signal RegWrite    : std_logic;
    signal ALUSrc      : std_logic;
    signal ALUControl  : std_logic_vector(2 downto 0);
    signal RD1         : std_logic_vector(31 downto 0);
    signal RD2         : std_logic_vector(31 downto 0);
    signal ImmExt      : std_logic_vector(31 downto 0);
    signal ALUResult   : std_logic_vector(31 downto 0);
    signal SrcB        : std_logic_vector(31 downto 0);
    signal ReadData    : std_logic_vector(31 downto 0); 
    signal Result_final: std_logic_vector(31 downto 0); 
    signal ResultSrc   : std_logic_vector(1 downto 0);                       
    signal MemWrite    : std_logic;
    signal Zero        : std_logic;                     
    signal Branch      : std_logic;                     
    signal PCSrc       : std_logic;                     
    signal PC_plus4    : std_logic_vector(31 downto 0); 
    signal PC_target   : std_logic_vector(31 downto 0); 
    signal PC_next     : std_logic_vector(31 downto 0);
    signal Jump        : std_logic_vector(1 downto 0);
    signal debug_fib : std_logic_vector(31 downto 0) := (others => '0');

begin 
    process(clk, reset)
    begin
        if reset = '1' then
            PC_current <= (others => '0');
            debug_fib <= (others => '0');
        elsif rising_edge(clk) then
            PC_current <= PC_next;
            if (instr(6 downto 0) = "0110011" and           -- R-type opcode
                instr(14 downto 12) = "000" and             -- Funct3 = ADD/SUB
                instr(31 downto 25) = "0000000" and         -- Funct7 = ADD 
                instr(11 downto 7) = "01111") then          -- rd = a5 (destination)
                debug_fib <= ALUResult; 
            end if;
        end if;
    end process;

    PC_plus4  <= std_logic_vector(unsigned(PC_current) + 4);
    PC_target <= std_logic_vector(signed(PC_current) + signed(ImmExt));

   
    process(Branch, Zero, ALUResult, instr)
    begin
        if (Branch = '1') then
            case instr(14 downto 12) is
                when "000" => PCSrc <= Zero;              -- BEQ
                when "101" => PCSrc <= not ALUResult(0);  -- BGT/BGE (using SLT logic)
                when others => PCSrc <= '0';
            end case;
        else
            PCSrc <= '0';
        end if;
    end process;

    
    process(PCSrc, Jump, PC_plus4, PC_target, ALUResult)
    begin
        if (Jump = "10") then 
            PC_next <= ALUResult;                 -- JALR (Target from Register)
        elsif (Jump = "01" or PCSrc = '1') then 
            PC_next <= PC_target;                 -- JAL or Branch
        else 
            PC_next <= PC_plus4;                  -- Normal +4
        end if;
    end process;

    SrcB <= RD2 when ALUSrc = '0' else ImmExt;

    process(ResultSrc, ALUResult, ReadData, PC_plus4)
    begin
        case ResultSrc is
            when "00"   => Result_final <= ALUResult;  -- Math
            when "01"   => Result_final <= ReadData;   -- Load Word
            when "10"   => Result_final <= PC_plus4;   -- Save Return Addr (JAL/JALR)
            when others => Result_final <= ALUResult;
        end case;
    end process;

    PC_debug     <= PC_current;
    instr_debug  <= instr;
    ALU_debug    <= ALUResult;
    RD1_debug    <= RD1;
    RD2_debug    <= RD2;
    Result_debug <= debug_fib;

    CU: entity work.ControlUnit
    port map(
        op         => instr(6 downto 0),   
        funct3     => instr(14 downto 12),
        funct7     => instr(31 downto 25), 
        RegWrite   => RegWrite,
        ALUSrc     => ALUSrc,
        ALUControl => ALUControl,
        Branch     => Branch, 
        Jump       => Jump,
        MemWrite   => MemWrite,
        ResultSrc  => ResultSrc
    );

    RF: entity work.Register_File
    port map(
        clk => clk,
        we3 => RegWrite,               
        a1  => instr(19 downto 15),     
        a2  => instr(24 downto 20),     
        a3  => instr(11 downto 7),      
        wd3 => Result_final,  
        rd1 => RD1,
        rd2 => RD2                     
    );

    EXT: entity work.Imm_Ext
    port map(
        instr => instr,                
        imm   => ImmExt               
    );

    ArithmeticUnit: entity work.ALU
    port map(
        A          => RD1,             
        B          => SrcB,            
        ALUControl => ALUControl,      
        ALUResult  => ALUResult,       
        Zero       => Zero             
    );

    IMEM: entity work.Instruction_Memory
    port map(
        A     => PC_current, 
        RD    => instr       
    );

    DMEM: entity work.Data_Memory
    port map(
        clk  => clk,
        we   => MemWrite,    
        addr => ALUResult,   
        wd   => RD2,         
        rd   => ReadData     
    );

end architecture;
