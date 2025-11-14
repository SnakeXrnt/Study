library IEEE; use IEEE.STD_LOGIC_1164.all;

entity week1 is
    port(a, b, cin: in STD_LOGIC;
         s, cout: out STD_LOGIC);
end;

architecture synth of week1 is
    signal p, g: STD_LOGIC;
begin
    p <= a xor b;
    g <= a and b;
    s <= p xor cin;
    cout <= g or (p and cin);
end;