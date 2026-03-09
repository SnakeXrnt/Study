library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity jal_jalr_tb is
-- Testbench has no ports
end entity;

architecture testbench of jal_jalr_tb is
    -- Component declaration for the CPU with JAL/JALR support
    component week5_top_jal_jalr is
        port(
            clk         : in  std_logic;
            reset       : in  std_logic;
            PC_debug    : out std_logic_vector(31 downto 0);
            instr_debug : out std_logic_vector(31 downto 0);
            ALU_debug   : out std_logic_vector(31 downto 0)
        );
    end component;
    
    -- Testbench signals
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '1';
    signal PC_debug    : std_logic_vector(31 downto 0);
    signal instr_debug : std_logic_vector(31 downto 0);
    signal ALU_debug   : std_logic_vector(31 downto 0);
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: week5_top_jal_jalr port map (
        clk         => clk,
        reset       => reset,
        PC_debug    => PC_debug,
        instr_debug => instr_debug,
        ALU_debug   => ALU_debug
    );
    
    -- Clock generation process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus process
    stimulus: process
    begin
        -- Initial reset
        reset <= '1';
        wait for CLK_PERIOD * 2;
        reset <= '0';
        
        -- Test Program Execution Timeline:
        -- Cycle 0-1: Reset
        -- Cycle 2: addi x10, x0, 5      -> x10 = 5
        -- Cycle 3: addi x11, x0, 3      -> x11 = 3
        -- Cycle 4: jal x1, add_function -> Jump to 0x1C, x1 = 0x0C
        -- Cycle 5: add x12, x10, x11    -> x12 = 8
        -- Cycle 6: jalr x0, x1, 0       -> Return to 0x0C
        -- Cycle 7: addi x13, x12, 10    -> x13 = 18
        -- Cycle 8: addi x10, x13, 0     -> x10 = 18
        -- Cycle 9: jal x1, multiply_by_2-> Jump to 0x24, x1 = 0x18
        -- Cycle 10: add x12, x10, x10   -> x12 = 36
        -- Cycle 11: jalr x0, x1, 0      -> Return to 0x18
        -- Cycle 12+: beq x0, x0, halt   -> Infinite loop
        
        wait for CLK_PERIOD * 2;
        assert false report "Cycle 2: Should execute addi x10, x0, 5" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 3: Should execute addi x11, x0, 3" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 4: Should execute jal x1, add_function (PC should jump to 0x1C)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 5: Should execute add x12, x10, x11 (x12 should be 8)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 6: Should execute jalr (return to PC=0x0C)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 7: Should execute addi x13, x12, 10 (x13 should be 18)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 8: Should execute addi x10, x13, 0 (x10 should be 18)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 9: Should execute jal x1, multiply_by_2 (PC should jump to 0x24)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 10: Should execute add x12, x10, x10 (x12 should be 36)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 11: Should execute jalr (return to PC=0x18)" severity note;
        
        wait for CLK_PERIOD;
        assert false report "Cycle 12: Should execute beq (infinite loop at 0x18)" severity note;
        
        -- Run a few more cycles to verify the loop
        wait for CLK_PERIOD * 5;
        
        assert false report "Test completed successfully!" severity note;
        wait;
    end process;
    
    -- Monitor process to display debug information
    monitor: process(clk)
    begin
        if rising_edge(clk) and reset = '0' then
            report "PC: " & integer'image(to_integer(unsigned(PC_debug))) & 
                   " | Instruction: " & integer'image(to_integer(unsigned(instr_debug))) & 
                   " | ALU Result: " & integer'image(to_integer(signed(ALU_debug)))
                   severity note;
        end if;
    end process;
    
end architecture;
