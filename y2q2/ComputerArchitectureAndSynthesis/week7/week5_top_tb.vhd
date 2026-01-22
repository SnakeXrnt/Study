library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity week5_top_tb is
end entity week5_top_tb;

architecture testbench of week5_top_tb is
    -- Signals to connect to UUT
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    
    -- Debug signals to observe in waveform
    signal PC_debug    : std_logic_vector(31 downto 0);
    signal instr_debug : std_logic_vector(31 downto 0);
    signal ALU_debug   : std_logic_vector(31 downto 0);
    
    -- Clock period definition
    constant clk_period : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.week5_top
        port map (
            clk         => clk,
            reset       => reset,
            PC_debug    => PC_debug,
            instr_debug => instr_debug,
            ALU_debug   => ALU_debug
        );
    
    -- Clock process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;
    
    -- Stimulus process
    stimulus: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 25 ns;
        reset <= '0';
        
        -- Let CPU run for multiple cycles
        wait for 300 ns;
        
        -- End simulation
        report "Simulation completed successfully";
        wait;
    end process;
    
end architecture testbench;
