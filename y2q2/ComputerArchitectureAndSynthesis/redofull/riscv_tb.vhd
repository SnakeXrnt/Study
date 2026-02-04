library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- This was missing! The "Shell" must be declared even if it's empty.
entity riscv_tb is
end entity;

architecture sim of riscv_tb is
    -- Signals are the "virtual wires" for the simulation
    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    
    -- Debug wires to watch the processor work
    signal PC_out     : std_logic_vector(31 downto 0);
    signal Instr_out  : std_logic_vector(31 downto 0);
    signal Result_out : std_logic_vector(31 downto 0);

begin
    -- UUT (Unit Under Test): This "plugs in" your Top-Level design
    UUT: entity work.riscv_top 
        port map (
            clk          => clk, 
            reset        => reset, 
            PC_debug     => PC_out,
            instr_debug  => Instr_out,
            Result_debug => Result_out
        );

    -- The "Heartbeat": Toggles the clock every 10ns (50MHz)
    clk <= not clk after 10 ns;

    -- The "Start Sequence": Holds reset, then lets go to start the program
    process 
    begin
        reset <= '1';
        wait for 25 ns; -- Wait a bit for things to stabilize
        reset <= '0';
        wait;           -- Wait forever (keep the clock running)
    end process;

end architecture;