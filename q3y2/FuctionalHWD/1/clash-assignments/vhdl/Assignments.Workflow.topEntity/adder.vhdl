-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.adder_types.all;

entity adder is
  port(-- clock
       MAX10_CLK1_50 : in adder_types.clk_CLK50;
       SW            : in std_logic_vector(9 downto 0);
       KEY           : in std_logic_vector(1 downto 0);
       LEDR          : out unsigned(4 downto 0));
end;

architecture structural of adder is
  signal \c$app_arg\   : adder_types.rst_CLK50;
  signal ena           : adder_types.en_CLK50;
  signal \c$app_arg_0\ : unsigned(4 downto 0) := to_unsigned(0,5);
  signal \c$app_arg_1\ : unsigned(4 downto 0) := to_unsigned(0,5);
  signal SW_0          : adder_types.Tuple2;
  signal KEY_0         : adder_types.Tuple2_0;

begin
  SW_0 <= adder_types.Tuple2'(adder_types.fromSLV(SW));

  KEY_0 <= adder_types.Tuple2_0'(adder_types.fromSLV(KEY));

  \c$app_arg\ <= '1' when (not KEY_0.Tuple2_0_sel0_boolean_0) = true else '0';

  ena <= not KEY_0.Tuple2_0_sel1_boolean_1;

  -- register begin
  capp_arg_0_register : process(MAX10_CLK1_50,\c$app_arg\)
  begin
    if \c$app_arg\ =  '1'  then
      \c$app_arg_0\ <= to_unsigned(0,5);
    elsif rising_edge(MAX10_CLK1_50) then
      if ena then
        \c$app_arg_0\ <= SW_0.Tuple2_sel1_unsigned_1;
      end if;
    end if;
  end process;
  -- register end

  -- register begin
  capp_arg_1_register : process(MAX10_CLK1_50,\c$app_arg\)
  begin
    if \c$app_arg\ =  '1'  then
      \c$app_arg_1\ <= to_unsigned(0,5);
    elsif rising_edge(MAX10_CLK1_50) then
      if ena then
        \c$app_arg_1\ <= SW_0.Tuple2_sel0_unsigned_0;
      end if;
    end if;
  end process;
  -- register end

  LEDR <= \c$app_arg_1\ + \c$app_arg_0\;


end;

