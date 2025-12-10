library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Required for reporting in Modelsim/Quartus simulation environment
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL; 

-- Define the time period for each test step (e.g., 10 ns, as seen in examples)


entity tb_riscv_alu_opt is 
    -- Testbenches typically have no ports, as they drive signals internally [5]
end entity tb_riscv_alu_opt;

architecture sim of tb_riscv_alu_opt is
	 constant CLK_PERIOD : TIME := 10 ns;

    -- 1. Component Declaration: Matches the entity being tested (DUT)
    component riscv_alu_opt
        port (
            A       : in STD_LOGIC_VECTOR(31 downto 0);
            B       : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOP   : in STD_LOGIC_VECTOR(2 downto 0);
            Result  : out STD_LOGIC_VECTOR(31 downto 0);
            Zero    : out STD_LOGIC
        );
    end component;
    
    -- 2. Testbench Signals (Internal connection points)
    signal TB_A      : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal TB_B      : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal TB_ALUOP  : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal TB_Result : STD_LOGIC_VECTOR(31 downto 0);
    signal TB_Zero   : STD_LOGIC;
    
    -- 3. ALU Operation Constants (Copied from the DUT for reference)
    constant OP_AND   : STD_LOGIC_VECTOR(2 downto 0) := "000";
    constant OP_OR    : STD_LOGIC_VECTOR(2 downto 0) := "001";
    constant OP_ADD   : STD_LOGIC_VECTOR(2 downto 0) := "010";
    constant OP_SUB   : STD_LOGIC_VECTOR(2 downto 0) := "011";
    constant OP_SLL   : STD_LOGIC_VECTOR(2 downto 0) := "100"; -- SSL corrected to SLL
	constant OP_SRL   : STD_LOGIC_VECTOR(2 downto 0) := "101";
    constant OP_SRA   : STD_LOGIC_VECTOR(2 downto 0) := "110";
    constant OP_SLT   : STD_LOGIC_VECTOR(2 downto 0) := "111";
    
    -- Function to convert expected result (UNSIGNED or SIGNED) back to STD_LOGIC_VECTOR
    -- This helps in self-checking assertions.
    -- We assume 32-bit width for the ALU (x"..." or 32 bits of zeroes).
    
begin
    
    -- 4. Instantiate Device Under Test (DUT) [5]
    dut_alu: riscv_alu_opt 
        port map (
            A       => TB_A,
            B       => TB_B,
            ALUOP   => TB_ALUOP,
            Result  => TB_Result,
            Zero    => TB_Zero
        );

    -- 5. Test Stimulus Generator (Process Block)
    process
        variable Expected_Result : STD_LOGIC_VECTOR(31 downto 0);
        variable Expected_Zero   : STD_LOGIC;
        
        -- Helper procedure for applying stimuli and checking output
        procedure Check_Result (
            Test_Name     : STRING; 
            Op_Code       : STD_LOGIC_VECTOR(2 downto 0); 
            Input_A       : STD_LOGIC_VECTOR(31 downto 0); 
            Input_B       : STD_LOGIC_VECTOR(31 downto 0); 
            Expected_R    : STD_LOGIC_VECTOR(31 downto 0); 
            Expected_Z    : STD_LOGIC
        ) is
        begin
            TB_ALUOP <= Op_Code;
            TB_A <= Input_A;
            TB_B <= Input_B;
            
            -- Wait for propagation delay [6]
            wait for CLK_PERIOD; 
            
            -- Self-Checking Assertions [3, 4]
            assert TB_Result = Expected_R
                report Test_Name & " failed: Result incorrect. Expected " & 
                       to_hstring(Expected_R) & ", got " & to_hstring(TB_Result)
                severity error;
                
            assert TB_Zero = Expected_Z
                report Test_Name & " failed: Zero flag incorrect. Expected " & 
                       STD_LOGIC'image(Expected_Z) & ", got " & STD_LOGIC'image(TB_Zero)
                severity error;
        end procedure;

    begin
        report "Starting RISC-V ALU (Optimized) Testbench" severity note;
        wait for 1 ns; -- Initial stabilization

        -------------------------------------------------------------------
        -- 1. ADD Operation (OP_ADD = "010")
        -------------------------------------------------------------------
        Expected_Result := x"0000000C"; -- 10 + 2 = 12
        Expected_Zero := '0';
        Check_Result("ADD_01", OP_ADD, x"0000000A", x"00000002", Expected_Result, Expected_Zero);
        
        Expected_Result := x"00000000"; -- 5 + (-5) = 0
        Expected_Zero := '1';
        Check_Result("ADD_02 (Zero Check)", OP_ADD, x"00000005", x"FFFFFFFb", Expected_Result, Expected_Zero);
        
        -------------------------------------------------------------------
        -- 2. SUB Operation (OP_SUB = "011")
        -------------------------------------------------------------------
        Expected_Result := x"00000008"; -- 10 - 2 = 8
        Expected_Zero := '0';
        Check_Result("SUB_01", OP_SUB, x"0000000A", x"00000002", Expected_Result, Expected_Zero);

        Expected_Result := x"00000000"; -- 10 - 10 = 0
        Expected_Zero := '1';
        Check_Result("SUB_02 (Zero Check)", OP_SUB, x"0000000A", x"0000000A", Expected_Result, Expected_Zero);

        -------------------------------------------------------------------
        -- 3. AND Operation (OP_AND = "000")
        -------------------------------------------------------------------
        Expected_Result := x"00000000"; -- 0xF0 & 0x0F = 0x00
        Expected_Zero := '1';
        Check_Result("AND_01 (Zero Check)", OP_AND, x"000000F0", x"0000000F", Expected_Result, Expected_Zero);
        
        Expected_Result := x"0000000A"; -- 0x0A & 0x0F = 0x0A
        Expected_Zero := '0';
        Check_Result("AND_02", OP_AND, x"0000000A", x"0000000F", Expected_Result, Expected_Zero);

        -------------------------------------------------------------------
        -- 4. OR Operation (OP_OR = "001")
        -------------------------------------------------------------------
        Expected_Result := x"000000FF"; -- 0xF0 | 0x0F = 0xFF
        Expected_Zero := '0';
        Check_Result("OR_01", OP_OR, x"000000F0", x"0000000F", Expected_Result, Expected_Zero);
        
        -------------------------------------------------------------------
        -- 5. Shift Left Logical (SLL/OP_SLL = "100")
        -- Shift A=1 (0x1) left by B=4 (shamt=4). Result: 16 (0x10)
        -------------------------------------------------------------------
        Expected_Result := x"00000010"; 
        Expected_Zero := '0';
        Check_Result("SLL_01", OP_SLL, x"00000001", x"00000004", Expected_Result, Expected_Zero);
        
        -------------------------------------------------------------------
        -- 6. Shift Right Logical (SRL/OP_SRL = "101")
        -- Shift A=8 (0x8) right by B=2 (shamt=2). Result: 2 (0x2)
        -------------------------------------------------------------------
        Expected_Result := x"00000002"; 
        Expected_Zero := '0';
        Check_Result("SRL_01", OP_SRL, x"00000008", x"00000002", Expected_Result, Expected_Zero);
        
        -- SRL on negative number (A = -1, 0xFFFFFFFF) right by 1. Should become 0x7FFFFFFF
        Expected_Result := x"7FFFFFFF"; 
        Expected_Zero := '0';
        Check_Result("SRL_02 (Unsigned Fill)", OP_SRL, x"FFFFFFFF", x"00000001", Expected_Result, Expected_Zero);


        -------------------------------------------------------------------
        -- 7. Shift Right Arithmetic (SRA/OP_SRA = "110")
        -- Shift A = -8 (0xFFFFFFF8) right by B=2 (shamt=2). Should remain negative (0xFFFFFFFE)
        -------------------------------------------------------------------
        Expected_Result := x"FFFFFFFE"; 
        Expected_Zero := '0';
        Check_Result("SRA_01 (Sign Fill)", OP_SRA, x"FFFFFFF8", x"00000002", Expected_Result, Expected_Zero);

        -------------------------------------------------------------------
        -- 8. Set Less Than (SLT/OP_SLT = "111")
        -- SLT is signed comparison. Result is 0x00000001 if A < B, else 0x00000000.
        -------------------------------------------------------------------
        -- Case 1: A < B (Signed positive) -> True (1)
        Expected_Result := x"00000001";
        Expected_Zero := '0';
        Check_Result("SLT_01 (True)", OP_SLT, x"00000005", x"0000000A", Expected_Result, Expected_Zero);

        -- Case 2: A > B (Signed positive) -> False (0)
        Expected_Result := x"00000000";
        Expected_Zero := '1';
        Check_Result("SLT_02 (False)", OP_SLT, x"0000000A", x"00000005", Expected_Result, Expected_Zero);

        -- Case 3: A < B (Signed negative comparison) -> True (1)
        -- A = -1 (0xFFFFFFFF), B = 10 (0x0000000A). -1 < 10 is TRUE.
        Expected_Result := x"00000001";
        Expected_Zero := '0';
        Check_Result("SLT_03 (Signed True)", OP_SLT, x"FFFFFFFF", x"0000000A", Expected_Result, Expected_Zero);
        
        report "Testbench finished successfully" severity note;
        wait; -- Wait forever to stop simulation [6, 7]
    end process;

end architecture sim;