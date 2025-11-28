library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity rom_array is
  port(
       clk  : in  STD_LOGIC;
       re   : in  STD_LOGIC;
       adr  : in  STD_LOGIC_VECTOR(2 downto 0);
       dout : out STD_LOGIC_VECTOR(15 downto 0)
  );
end;

architecture synth of rom_array is

    -- 1. DEFINE THE TYPE
    -- We use (0 to 7) so it matches the order of the list below (Top=0, Bottom=7)
    type mem_type is array (0 to 7) of STD_LOGIC_VECTOR (15 downto 0);

    -- 2. DECLARE AND INITIALIZE THE SIGNAL
    -- The ":=" operator tells VHDL to load these values at startup.
    signal mem : mem_type := (
        "1011001011100101", -- Address 0
        "0100110110010010", -- Address 1
        "1110001010111000", -- Address 2
        "0011101001001101", -- Address 3
        "1001010111100011", -- Address 4
        "0110110010010011", -- Address 5
        "1100001110101010", -- Address 6
        "0001110101100100"  -- Address 7
    );

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
        
            if (re = '1') then
                -- logic reads from the 'mem' signal defined above
                dout <= mem(to_integer(unsigned(adr))); 
            else
                dout <= (others => 'Z');
            end if;
            
        end if;
    end process;
    
end;