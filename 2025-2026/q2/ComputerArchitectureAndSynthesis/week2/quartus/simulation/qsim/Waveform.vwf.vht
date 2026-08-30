-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/21/2025 11:57:13"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Counter4Bit
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Counter4Bit_vhd_vec_tst IS
END Counter4Bit_vhd_vec_tst;
ARCHITECTURE Counter4Bit_arch OF Counter4Bit_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL enable : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
COMPONENT Counter4Bit
	PORT (
	clk : IN STD_LOGIC;
	count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	enable : IN STD_LOGIC;
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Counter4Bit
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	count => count,
	enable => enable,
	reset => reset
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	clk <= '1';
	WAIT FOR 10000 ps;
	FOR i IN 1 TO 49
	LOOP
		clk <= '0';
		WAIT FOR 10000 ps;
		clk <= '1';
		WAIT FOR 10000 ps;
	END LOOP;
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;

-- enable
t_prcs_enable: PROCESS
BEGIN
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 20000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 35000 ps;
	enable <= '0';
	WAIT FOR 15000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 10000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 10000 ps;
	enable <= '1';
	WAIT FOR 25000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 25000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 10000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 35000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 15000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 30000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 10000 ps;
	enable <= '1';
	WAIT FOR 20000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 20000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 10000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 15000 ps;
	enable <= '1';
	WAIT FOR 20000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 15000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 10000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 5000 ps;
	enable <= '0';
	WAIT FOR 5000 ps;
	enable <= '1';
	WAIT FOR 15000 ps;
	enable <= '0';
WAIT;
END PROCESS t_prcs_enable;

-- reset
t_prcs_reset: PROCESS
BEGIN
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 20000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 20000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 25000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 25000 ps;
	reset <= '1';
	WAIT FOR 20000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 25000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 20000 ps;
	reset <= '0';
	WAIT FOR 20000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 30000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 15000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 20000 ps;
	reset <= '0';
	WAIT FOR 10000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 15000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
	WAIT FOR 35000 ps;
	reset <= '1';
	WAIT FOR 5000 ps;
	reset <= '0';
	WAIT FOR 5000 ps;
	reset <= '1';
	WAIT FOR 10000 ps;
	reset <= '0';
WAIT;
END PROCESS t_prcs_reset;
END Counter4Bit_arch;
