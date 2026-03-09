library IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ram_array is
  port(
       clk  : in  STD_LOGIC;
       re   : in  STD_LOGIC;
		 we 	: in 	STD_LOGIC;
       adr  : in  STD_LOGIC_VECTOR(3 downto 0);
		 din	: in 	STD_LOGIC_VECTOR(7 downto 0);
       dout : out STD_LOGIC_VECTOR(7 downto 0)
  );
end;

architecture synth of ram_array is
	type mem_type is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
	
	signal mem : mem_type;
	
begin

    process(clk)
    begin
        if (rising_edge(clk)) then
        
            if (we = '1') then
                mem(to_integer(unsigned(adr))) <= din;
            end if;

            if (re = '1') then
                dout <= mem(to_integer(unsigned(adr)));
            else 
                dout <= (others => 'Z');
            end if;
				
            
        end if;
    end process;
    
end;
