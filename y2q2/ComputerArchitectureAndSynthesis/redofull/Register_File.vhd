library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is
    port (
        clk, we3    : in  std_logic;                     -- we3 is RegWrite [6]
        a1, a2, a3  : in  std_logic_vector(4 downto 0);  -- rs1, rs2, rd
        wd3         : in  std_logic_vector(31 downto 0); -- Data to write
        rd1, rd2    : out std_logic_vector(31 downto 0)  -- Data read
    );
end entity;

architecture behavioral of Register_File is
    type ram_type is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal mem : ram_type := (others => (others => '0'));
begin
    -- Synchronous Write: Result is stored on rising edge if RegWrite is high [6]
    process(clk) begin
        if rising_edge(clk) then
            if we3 = '1' then mem(to_integer(unsigned(a3))) <= wd3; end if;
        end if;
    end process;
    -- Asynchronous Read: Operands are immediately available [7]
    rd1 <= (others => '0') when a1 = "00000" else mem(to_integer(unsigned(a1)));
    rd2 <= (others => '0') when a2 = "00000" else mem(to_integer(unsigned(a2)));
end architecture;
