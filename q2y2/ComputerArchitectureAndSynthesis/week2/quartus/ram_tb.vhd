library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ram_tb is
-- Testbenches have no inputs/outputs
end ram_tb;

architecture sim of ram_tb is

    -- 1. Component Declaration (Matches your RAM entity)
    component ram_array is
        port(
           clk  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           re   : in  STD_LOGIC;
           adr  : in  STD_LOGIC_VECTOR(3 downto 0);
           din  : in  STD_LOGIC_VECTOR(7 downto 0);
           dout : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- 2. Internal Signals
    signal tb_clk  : STD_LOGIC := '0';
    signal tb_we   : STD_LOGIC := '0';
    signal tb_re   : STD_LOGIC := '0';
    signal tb_adr  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal tb_din  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal tb_dout : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- 3. Connect the RAM
    uut: ram_array port map (
        clk  => tb_clk,
        we   => tb_we,
        re   => tb_re,
        adr  => tb_adr,
        din  => tb_din,
        dout => tb_dout
    );

    -- 4. Generate Clock (Toggles every 10ns)
    process
    begin
        tb_clk <= '0';
        wait for 10 ns;
        tb_clk <= '1';
        wait for 10 ns;
    end process;

    -- 5. The Testing Logic
    process
    begin
        wait for 20 ns;

        -- STEP 1: WRITE "10101010" (Hex AA) to Address 5
        tb_adr <= "0101";       -- Address 5
        tb_din <= "10101010";   -- Data AA
        tb_we  <= '1';          -- Enable Write
        tb_re  <= '0';          -- Disable Read
        wait for 20 ns;         -- Wait for clock edge
        
        tb_we  <= '0';          -- Turn off Write
        wait for 20 ns;

        -- STEP 2: WRITE "11110000" (Hex F0) to Address 15
        tb_adr <= "1111";       -- Address 15
        tb_din <= "11110000";   -- Data F0
        tb_we  <= '1';
        wait for 20 ns;

        tb_we  <= '0';
        wait for 20 ns;

        -- STEP 3: READ Address 5 (Should see "10101010")
        tb_adr <= "0101";
        tb_re  <= '1';          -- Enable Read
        wait for 20 ns;

        -- STEP 4: READ Address 15 (Should see "11110000")
        tb_adr <= "1111";
        wait for 20 ns;

        -- STEP 5: READ Address 0 (Should be "00000000" / Empty)
        tb_adr <= "0000";
        wait for 20 ns;

        -- Stop Simulation
        tb_re <= '0';
        wait;
    end process;

end;