library ieee;
use ieee.std_logic_1164.all;

entity week1a2 is 
	port(
		A 		: in std_logic_vector(2 downto 0);
		B		: in std_logic_vector(2 downto 0);
		SUM 	: out std_logic_vector(3 downto 0)
	);
end week1a2;

architecture structural of week1a2 is

	component week1
		port(
			a 		: in std_logic;
			b 		: in std_logic;
			cin 	: in std_logic;
			s		: out std_logic;
			cout 	: out std_logic
		);
	end component;
	
	signal c1, c2, c3 : std_logic;

begin 

	FA0: week1 port map(A(0), B(0), '0', SUM(0), c1);
	FA1: week1 port map(A(1), B(1), c1, SUM(1), c2);
	FA2: week1 port map(A(2), B(2), c2, SUM(2), c3);
	
	SUM(3) <= c3;

end structural;


