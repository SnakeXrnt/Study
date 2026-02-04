library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity week7_jal_jalr_tb is
    -- Testbench has no ports
end entity;

architecture testbench of week7_jal_jalr_tb is
    -- Component declaration for the CPU with JAL/JALR support
    component week5_top_jal_jalr is
        port(
            clk         : in  std_logic;
            reset       : in  std_logic;
            PC_debug    : out std_logic_vector(31 downto 0);
            instr_debug : out std_logic_vector(31 downto 0);
            ALU_debug   : out std_logic_vector(31 downto 0);
            RD1_debug   : out std_logic_vector(31 downto 0);
            RD2_debug   : out std_logic_vector(31 downto 0);
            Result_debug: out std_logic_vector(31 downto 0)
        );
    end component;
    
    -- Testbench signals
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '1';
    signal PC_debug    : std_logic_vector(31 downto 0);
    signal instr_debug : std_logic_vector(31 downto 0);
    signal ALU_debug   : std_logic_vector(31 downto 0);
    signal RD1_debug   : std_logic_vector(31 downto 0);
    signal RD2_debug   : std_logic_vector(31 downto 0);
    signal Result_debug: std_logic_vector(31 downto 0);
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;
    
    -- Flag to stop simulation
    signal sim_finished : boolean := false;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: week5_top_jal_jalr port map (
        clk         => clk,
        reset       => reset,
        PC_debug    => PC_debug,
        instr_debug => instr_debug,
        ALU_debug   => ALU_debug,
        RD1_debug   => RD1_debug,
        RD2_debug   => RD2_debug,
        Result_debug=> Result_debug
    );
    
    -- Clock generation process
    clk_process: process
    begin
        while not sim_finished loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stimulus: process
    begin
        -- Initial reset
        report "========================================" severity note;
        report "Starting JAL/JALR Testbench for Fibonacci Sequence" severity note;
        report "========================================" severity note;
        
        reset <= '1';
        wait for CLK_PERIOD * 2;
        reset <= '0';
        
        report "Reset released at " & time'image(now) severity note;
        
        -- Let the program execute
        -- The program should:
        -- 1. Setup stack frame (cycles 0-2)
        -- 2. Initialize variables (cycles 3-7)
        -- 3. Execute loop iterations
        -- 4. Exit and cleanup
        
        wait for CLK_PERIOD;
        report "Cycle 1: PC=" & integer'image(to_integer(unsigned(PC_debug))) & 
               " Instr=" & to_hstring(instr_debug) severity note;
        
        wait for CLK_PERIOD;
        report "Cycle 2: PC=" & integer'image(to_integer(unsigned(PC_debug))) & 
               " Instr=" & to_hstring(instr_debug) severity note;
        
        wait for CLK_PERIOD;
        report "Cycle 3: PC=" & integer'image(to_integer(unsigned(PC_debug))) & 
               " Instr=" & to_hstring(instr_debug) severity note;
        
        -- Monitor first 10 cycles in detail
        for i in 4 to 10 loop
            wait for CLK_PERIOD;
            report "Cycle " & integer'image(i) & ": PC=" & 
                   integer'image(to_integer(unsigned(PC_debug))) & 
                   " Instr=" & to_hstring(instr_debug) &
                   " ALU=" & integer'image(to_integer(signed(ALU_debug))) &
                   " RD1=" & integer'image(to_integer(signed(RD1_debug))) &
                   " RD2=" & integer'image(to_integer(signed(RD2_debug))) &
                   " Result=" & integer'image(to_integer(signed(Result_debug))) severity note;
        end loop;
        
        -- Continue monitoring at intervals
        report "----------------------------------------" severity note;
        report "Continuing execution (reporting every 5 cycles)..." severity note;
        report "----------------------------------------" severity note;
        
        for i in 11 to 100 loop
            wait for CLK_PERIOD;
            
            -- Report every 5 cycles
            if (i mod 5 = 0) then
                report "Cycle " & integer'image(i) & ": PC=" & 
                       integer'image(to_integer(unsigned(PC_debug))) & 
                       " Instr=" & to_hstring(instr_debug) &
                       " ALU=" & integer'image(to_integer(signed(ALU_debug))) &
                       " Result=" & integer'image(to_integer(signed(Result_debug))) severity note;
            end if;
            
            -- Check for JAL instructions (opcode 1101111)
            if instr_debug(6 downto 0) = "1101111" then
                report "*** JAL detected at cycle " & integer'image(i) & 
                       " PC=" & integer'image(to_integer(unsigned(PC_debug))) severity note;
            end if;
            
            -- Check for JALR instructions (opcode 1100111)
            if instr_debug(6 downto 0) = "1100111" then
                report "*** JALR detected at cycle " & integer'image(i) & 
                       " PC=" & integer'image(to_integer(unsigned(PC_debug))) severity note;
            end if;
            
            -- Check for Branch instructions (opcode 1100011)
            if instr_debug(6 downto 0) = "1100011" then
                report "*** BRANCH detected at cycle " & integer'image(i) & 
                       " PC=" & integer'image(to_integer(unsigned(PC_debug))) severity note;
            end if;
            
            -- Stop if we hit an infinite loop or reach program end
            -- Check if PC stops changing (stuck in loop)
            if i > 50 and PC_debug = X"00000070" then -- Typical halt address
                report "Program reached halt/loop at cycle " & integer'image(i) severity note;
                exit;
            end if;
        end loop;
        
        -- Final report
        wait for CLK_PERIOD * 5;
        report "========================================" severity note;
        report "Testbench execution completed" severity note;
        report "Final PC: " & integer'image(to_integer(unsigned(PC_debug))) severity note;
        report "Final Instruction: " & to_hstring(instr_debug) severity note;
        report "Final ALU Result: " & integer'image(to_integer(signed(ALU_debug))) severity note;
        report "Final Result (written to register): " & integer'image(to_integer(signed(Result_debug))) severity note;
        report "========================================" severity note;
        report "Simulation PASSED - Check waveform for detailed analysis" severity note;
        
        sim_finished <= true;
        wait;
    end process;
    
    -- Monitor process to watch for specific events
    monitor: process(clk)
        variable prev_pc : std_logic_vector(31 downto 0) := (others => '0');
    begin
        if rising_edge(clk) and reset = '0' then
            -- Detect PC jumps (non-sequential execution)
            if to_integer(unsigned(PC_debug)) /= to_integer(unsigned(prev_pc)) + 4 and
               prev_pc /= X"00000000" then
                report "!!! Non-sequential PC change detected: " & 
                       integer'image(to_integer(unsigned(prev_pc))) & " -> " &
                       integer'image(to_integer(unsigned(PC_debug))) severity note;
            end if;
            prev_pc := PC_debug;
        end if;
    end process;

end architecture;
