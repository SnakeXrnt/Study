library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
-- Optional: use STD_TEXTIO for more complex self-checking/reporting

entity tb_riscv_alu is
end entity tb_riscv_alu;

architecture test_ops of tb_riscv_alu is

    -- Define the component (the ALU you built above)
    component riscv_alu
        port (
            A       : in  STD_LOGIC_VECTOR(31 downto 0);
            B       : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUOp   : in  STD_LOGIC_VECTOR(1 downto 0);
            
            Result  : out STD_LOGIC_VECTOR(31 downto 0);
            Zero    : out STD_LOGIC
        );
    end component;

    -- Signals declared in the testbench match the DUT ports
    signal A_s, B_s, Result_s : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal ALUOp_s            : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal Zero_s             : STD_LOGIC := '0';
    
    -- Constants for control signals (must match the encoding in alu.vhd)
    constant OP_AND : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant OP_OR  : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant OP_ADD : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant OP_SUB : STD_LOGIC_VECTOR(1 downto 0) := "11";

    constant T_DELAY : time := 10 ns; -- Simulation delay [16]

begin
    -- Instantiate the Device Under Test (DUT)
    DUT: riscv_alu port map(
        A => A_s, 
        B => B_s, 
        ALUOp => ALUOp_s, 
        Result => Result_s, 
        Zero => Zero_s
    );

    -- Stimuli Process to apply inputs and test outputs
    process begin
        
        -- ---------------------------
        -- Test 1: Addition (ADD)
        -- A=5, B=10. Expected Result=15, Zero=0.
        A_s <= x"00000005"; 
        B_s <= x"0000000A"; 
        ALUOp_s <= OP_ADD; 
        wait for T_DELAY; 
        
        assert Result_s = x"0000000F" report "ADD test 1 failed" severity ERROR;
        assert Zero_s = '0' report "ADD zero flag failed (expected 0)" severity ERROR;

        -- Test 2: Subtraction resulting in Zero (SUB)
        -- A=100, B=100. Expected Result=0, Zero=1.
        A_s <= x"00000064"; 
        B_s <= x"00000064";
        ALUOp_s <= OP_SUB;
        wait for T_DELAY;

        assert Result_s = x"00000000" report "SUB test 2 failed (expected 0)" severity ERROR;
        assert Zero_s = '1' report "SUB zero flag failed (expected 1)" severity ERROR;

        -- ---------------------------
        -- Test 3: Bitwise AND (AND)
        -- A = 1010, B = 0110. Expected Result = 0010 (x"02")
        A_s <= x"0000000A"; -- 1010 binary (using hex for clarity)
        B_s <= x"00000006"; -- 0110 binary
        ALUOp_s <= OP_AND;
        wait for T_DELAY;

        assert Result_s = x"00000002" report "AND test 3 failed" severity ERROR;
        assert Zero_s = '0' report "AND zero flag failed (expected 0)" severity ERROR;
        
        -- ---------------------------
        -- Test 4: Bitwise OR (OR)
        -- A = 1010, B = 0110. Expected Result = 1110 (x"0E")
        A_s <= x"0000000A";
        B_s <= x"00000006";
        ALUOp_s <= OP_OR;
        wait for T_DELAY;

        assert Result_s = x"0000000E" report "OR test 4 failed" severity ERROR;
        assert Zero_s = '0' report "OR zero flag failed (expected 0)" severity ERROR;
        
        -- ---------------------------
        
        wait; -- Wait forever to stop the process after tests [16]
    end process;

end architecture test_ops;