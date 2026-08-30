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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "12/04/2025 15:31:29"

-- 
-- Device: Altera 10M50DAF484C7G Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	riscv_alu_opt IS
    PORT (
	A : IN std_logic_vector(31 DOWNTO 0);
	B : IN std_logic_vector(31 DOWNTO 0);
	ALUOP : IN std_logic_vector(2 DOWNTO 0);
	Result : OUT std_logic_vector(31 DOWNTO 0);
	Zero : OUT std_logic
	);
END riscv_alu_opt;

-- Design Ports Information
-- Result[0]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[1]	=>  Location: PIN_C22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[2]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[3]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[4]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[5]	=>  Location: PIN_B22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[6]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[7]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[8]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[9]	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[10]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[11]	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[12]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[13]	=>  Location: PIN_A2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[14]	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[15]	=>  Location: PIN_N15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[16]	=>  Location: PIN_D5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[17]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[18]	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[19]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[20]	=>  Location: PIN_K19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[21]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[22]	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[23]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[24]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[25]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[26]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[27]	=>  Location: PIN_B20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[28]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[29]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[30]	=>  Location: PIN_A3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[31]	=>  Location: PIN_L15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Zero	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALUOP[0]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_E11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALUOP[1]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALUOP[2]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[7]	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[6]	=>  Location: PIN_K14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[5]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[4]	=>  Location: PIN_B14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[15]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[13]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[14]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[12]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[11]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[9]	=>  Location: PIN_K18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[10]	=>  Location: PIN_J11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[8]	=>  Location: PIN_C18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[4]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[23]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[21]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[22]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[20]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[19]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[17]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[18]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[16]	=>  Location: PIN_D21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[29]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[28]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[31]	=>  Location: PIN_C7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[30]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[27]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[25]	=>  Location: PIN_A16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[26]	=>  Location: PIN_N18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[24]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[31]	=>  Location: PIN_F21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[30]	=>  Location: PIN_M14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[29]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[28]	=>  Location: PIN_A20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[27]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[26]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[25]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[24]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[23]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[22]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[21]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[20]	=>  Location: PIN_L20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[19]	=>  Location: PIN_F22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[18]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[17]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[16]	=>  Location: PIN_L14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[15]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[14]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[13]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[12]	=>  Location: PIN_M15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[11]	=>  Location: PIN_C21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[10]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[9]	=>  Location: PIN_F16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[8]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[7]	=>  Location: PIN_J12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[6]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[5]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF riscv_alu_opt IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_A : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_ALUOP : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_Result : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_Zero : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \Result[0]~output_o\ : std_logic;
SIGNAL \Result[1]~output_o\ : std_logic;
SIGNAL \Result[2]~output_o\ : std_logic;
SIGNAL \Result[3]~output_o\ : std_logic;
SIGNAL \Result[4]~output_o\ : std_logic;
SIGNAL \Result[5]~output_o\ : std_logic;
SIGNAL \Result[6]~output_o\ : std_logic;
SIGNAL \Result[7]~output_o\ : std_logic;
SIGNAL \Result[8]~output_o\ : std_logic;
SIGNAL \Result[9]~output_o\ : std_logic;
SIGNAL \Result[10]~output_o\ : std_logic;
SIGNAL \Result[11]~output_o\ : std_logic;
SIGNAL \Result[12]~output_o\ : std_logic;
SIGNAL \Result[13]~output_o\ : std_logic;
SIGNAL \Result[14]~output_o\ : std_logic;
SIGNAL \Result[15]~output_o\ : std_logic;
SIGNAL \Result[16]~output_o\ : std_logic;
SIGNAL \Result[17]~output_o\ : std_logic;
SIGNAL \Result[18]~output_o\ : std_logic;
SIGNAL \Result[19]~output_o\ : std_logic;
SIGNAL \Result[20]~output_o\ : std_logic;
SIGNAL \Result[21]~output_o\ : std_logic;
SIGNAL \Result[22]~output_o\ : std_logic;
SIGNAL \Result[23]~output_o\ : std_logic;
SIGNAL \Result[24]~output_o\ : std_logic;
SIGNAL \Result[25]~output_o\ : std_logic;
SIGNAL \Result[26]~output_o\ : std_logic;
SIGNAL \Result[27]~output_o\ : std_logic;
SIGNAL \Result[28]~output_o\ : std_logic;
SIGNAL \Result[29]~output_o\ : std_logic;
SIGNAL \Result[30]~output_o\ : std_logic;
SIGNAL \Result[31]~output_o\ : std_logic;
SIGNAL \Zero~output_o\ : std_logic;
SIGNAL \B[31]~input_o\ : std_logic;
SIGNAL \A[31]~input_o\ : std_logic;
SIGNAL \A[30]~input_o\ : std_logic;
SIGNAL \B[30]~input_o\ : std_logic;
SIGNAL \A[29]~input_o\ : std_logic;
SIGNAL \B[29]~input_o\ : std_logic;
SIGNAL \B[28]~input_o\ : std_logic;
SIGNAL \A[28]~input_o\ : std_logic;
SIGNAL \B[27]~input_o\ : std_logic;
SIGNAL \A[27]~input_o\ : std_logic;
SIGNAL \B[26]~input_o\ : std_logic;
SIGNAL \A[26]~input_o\ : std_logic;
SIGNAL \A[25]~input_o\ : std_logic;
SIGNAL \B[25]~input_o\ : std_logic;
SIGNAL \A[24]~input_o\ : std_logic;
SIGNAL \B[24]~input_o\ : std_logic;
SIGNAL \B[23]~input_o\ : std_logic;
SIGNAL \A[23]~input_o\ : std_logic;
SIGNAL \A[22]~input_o\ : std_logic;
SIGNAL \B[22]~input_o\ : std_logic;
SIGNAL \B[21]~input_o\ : std_logic;
SIGNAL \A[21]~input_o\ : std_logic;
SIGNAL \B[20]~input_o\ : std_logic;
SIGNAL \A[20]~input_o\ : std_logic;
SIGNAL \A[19]~input_o\ : std_logic;
SIGNAL \B[19]~input_o\ : std_logic;
SIGNAL \A[18]~input_o\ : std_logic;
SIGNAL \B[18]~input_o\ : std_logic;
SIGNAL \A[17]~input_o\ : std_logic;
SIGNAL \B[17]~input_o\ : std_logic;
SIGNAL \B[16]~input_o\ : std_logic;
SIGNAL \A[16]~input_o\ : std_logic;
SIGNAL \A[15]~input_o\ : std_logic;
SIGNAL \B[15]~input_o\ : std_logic;
SIGNAL \A[14]~input_o\ : std_logic;
SIGNAL \B[14]~input_o\ : std_logic;
SIGNAL \B[13]~input_o\ : std_logic;
SIGNAL \A[13]~input_o\ : std_logic;
SIGNAL \A[12]~input_o\ : std_logic;
SIGNAL \B[12]~input_o\ : std_logic;
SIGNAL \B[11]~input_o\ : std_logic;
SIGNAL \A[11]~input_o\ : std_logic;
SIGNAL \A[10]~input_o\ : std_logic;
SIGNAL \B[10]~input_o\ : std_logic;
SIGNAL \B[9]~input_o\ : std_logic;
SIGNAL \A[9]~input_o\ : std_logic;
SIGNAL \A[8]~input_o\ : std_logic;
SIGNAL \B[8]~input_o\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \B[7]~input_o\ : std_logic;
SIGNAL \B[6]~input_o\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \B[5]~input_o\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \B[4]~input_o\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \LessThan0~1_cout\ : std_logic;
SIGNAL \LessThan0~3_cout\ : std_logic;
SIGNAL \LessThan0~5_cout\ : std_logic;
SIGNAL \LessThan0~7_cout\ : std_logic;
SIGNAL \LessThan0~9_cout\ : std_logic;
SIGNAL \LessThan0~11_cout\ : std_logic;
SIGNAL \LessThan0~13_cout\ : std_logic;
SIGNAL \LessThan0~15_cout\ : std_logic;
SIGNAL \LessThan0~17_cout\ : std_logic;
SIGNAL \LessThan0~19_cout\ : std_logic;
SIGNAL \LessThan0~21_cout\ : std_logic;
SIGNAL \LessThan0~23_cout\ : std_logic;
SIGNAL \LessThan0~25_cout\ : std_logic;
SIGNAL \LessThan0~27_cout\ : std_logic;
SIGNAL \LessThan0~29_cout\ : std_logic;
SIGNAL \LessThan0~31_cout\ : std_logic;
SIGNAL \LessThan0~33_cout\ : std_logic;
SIGNAL \LessThan0~35_cout\ : std_logic;
SIGNAL \LessThan0~37_cout\ : std_logic;
SIGNAL \LessThan0~39_cout\ : std_logic;
SIGNAL \LessThan0~41_cout\ : std_logic;
SIGNAL \LessThan0~43_cout\ : std_logic;
SIGNAL \LessThan0~45_cout\ : std_logic;
SIGNAL \LessThan0~47_cout\ : std_logic;
SIGNAL \LessThan0~49_cout\ : std_logic;
SIGNAL \LessThan0~51_cout\ : std_logic;
SIGNAL \LessThan0~53_cout\ : std_logic;
SIGNAL \LessThan0~55_cout\ : std_logic;
SIGNAL \LessThan0~57_cout\ : std_logic;
SIGNAL \LessThan0~59_cout\ : std_logic;
SIGNAL \LessThan0~61_cout\ : std_logic;
SIGNAL \LessThan0~62_combout\ : std_logic;
SIGNAL \ALUOP[1]~input_o\ : std_logic;
SIGNAL \ShiftRight0~34_combout\ : std_logic;
SIGNAL \ShiftLeft0~10_combout\ : std_logic;
SIGNAL \ALUOP[0]~input_o\ : std_logic;
SIGNAL \Mux31~13_combout\ : std_logic;
SIGNAL \Mux31~14_combout\ : std_logic;
SIGNAL \Mux31~6_combout\ : std_logic;
SIGNAL \ShiftRight0~25_combout\ : std_logic;
SIGNAL \ShiftRight0~24_combout\ : std_logic;
SIGNAL \ShiftRight0~26_combout\ : std_logic;
SIGNAL \ShiftRight0~30_combout\ : std_logic;
SIGNAL \ShiftRight0~29_combout\ : std_logic;
SIGNAL \ShiftRight0~31_combout\ : std_logic;
SIGNAL \ShiftRight0~27_combout\ : std_logic;
SIGNAL \ShiftRight1~18_combout\ : std_logic;
SIGNAL \ShiftRight0~28_combout\ : std_logic;
SIGNAL \ShiftRight0~32_combout\ : std_logic;
SIGNAL \ShiftRight0~22_combout\ : std_logic;
SIGNAL \ShiftRight0~21_combout\ : std_logic;
SIGNAL \ShiftRight0~23_combout\ : std_logic;
SIGNAL \ShiftRight0~33_combout\ : std_logic;
SIGNAL \ShiftRight1~17_combout\ : std_logic;
SIGNAL \ShiftRight0~12_combout\ : std_logic;
SIGNAL \ShiftRight0~13_combout\ : std_logic;
SIGNAL \Mux31~7_combout\ : std_logic;
SIGNAL \ShiftRight1~16_combout\ : std_logic;
SIGNAL \Mux31~8_combout\ : std_logic;
SIGNAL \Mux31~9_combout\ : std_logic;
SIGNAL \ShiftRight0~17_combout\ : std_logic;
SIGNAL \ShiftRight0~18_combout\ : std_logic;
SIGNAL \ShiftRight0~19_combout\ : std_logic;
SIGNAL \ShiftRight0~15_combout\ : std_logic;
SIGNAL \ShiftRight0~14_combout\ : std_logic;
SIGNAL \ShiftRight0~16_combout\ : std_logic;
SIGNAL \ShiftRight0~20_combout\ : std_logic;
SIGNAL \Mux31~10_combout\ : std_logic;
SIGNAL \Mux31~11_combout\ : std_logic;
SIGNAL \ALUOP[2]~input_o\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \Add0~2_cout\ : std_logic;
SIGNAL \Add0~3_combout\ : std_logic;
SIGNAL \Mux31~4_combout\ : std_logic;
SIGNAL \Mux31~5_combout\ : std_logic;
SIGNAL \Mux31~12_combout\ : std_logic;
SIGNAL \ShiftRight1~20_combout\ : std_logic;
SIGNAL \ShiftRight0~37_combout\ : std_logic;
SIGNAL \ShiftRight1~19_combout\ : std_logic;
SIGNAL \ShiftRight0~36_combout\ : std_logic;
SIGNAL \ShiftRight0~46_combout\ : std_logic;
SIGNAL \ShiftRight1~22_combout\ : std_logic;
SIGNAL \ShiftRight0~44_combout\ : std_logic;
SIGNAL \ShiftRight1~21_combout\ : std_logic;
SIGNAL \ShiftRight0~45_combout\ : std_logic;
SIGNAL \ShiftRight0~47_combout\ : std_logic;
SIGNAL \Mux30~9_combout\ : std_logic;
SIGNAL \Mux30~0_combout\ : std_logic;
SIGNAL \Add0~5_combout\ : std_logic;
SIGNAL \Add0~4\ : std_logic;
SIGNAL \Add0~6_combout\ : std_logic;
SIGNAL \Mux30~1_combout\ : std_logic;
SIGNAL \ShiftLeft0~11_combout\ : std_logic;
SIGNAL \ShiftLeft0~102_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux30~2_combout\ : std_logic;
SIGNAL \Mux3~1_combout\ : std_logic;
SIGNAL \ShiftRight0~38_combout\ : std_logic;
SIGNAL \ShiftRight1~23_combout\ : std_logic;
SIGNAL \Mux22~0_combout\ : std_logic;
SIGNAL \ShiftRight1~24_combout\ : std_logic;
SIGNAL \Mux30~3_combout\ : std_logic;
SIGNAL \Mux30~4_combout\ : std_logic;
SIGNAL \ShiftRight0~39_combout\ : std_logic;
SIGNAL \ShiftRight1~26_combout\ : std_logic;
SIGNAL \ShiftRight0~40_combout\ : std_logic;
SIGNAL \Mux30~5_combout\ : std_logic;
SIGNAL \ShiftRight1~25_combout\ : std_logic;
SIGNAL \Mux30~6_combout\ : std_logic;
SIGNAL \Mux30~7_combout\ : std_logic;
SIGNAL \ShiftRight1~27_combout\ : std_logic;
SIGNAL \ShiftRight0~41_combout\ : std_logic;
SIGNAL \ShiftRight1~28_combout\ : std_logic;
SIGNAL \ShiftRight0~42_combout\ : std_logic;
SIGNAL \ShiftRight0~43_combout\ : std_logic;
SIGNAL \Mux30~8_combout\ : std_logic;
SIGNAL \Mux30~10_combout\ : std_logic;
SIGNAL \Mux28~5_combout\ : std_logic;
SIGNAL \Mux28~4_combout\ : std_logic;
SIGNAL \Mux29~5_combout\ : std_logic;
SIGNAL \Add0~8_combout\ : std_logic;
SIGNAL \Add0~7\ : std_logic;
SIGNAL \Add0~9_combout\ : std_logic;
SIGNAL \Mux28~2_combout\ : std_logic;
SIGNAL \ShiftRight1~33_combout\ : std_logic;
SIGNAL \ShiftRight1~34_combout\ : std_logic;
SIGNAL \ShiftRight1~31_combout\ : std_logic;
SIGNAL \ShiftRight1~32_combout\ : std_logic;
SIGNAL \Mux21~2_combout\ : std_logic;
SIGNAL \ShiftRight1~35_combout\ : std_logic;
SIGNAL \ShiftRight1~29_combout\ : std_logic;
SIGNAL \ShiftRight1~30_combout\ : std_logic;
SIGNAL \ShiftRight1~36_combout\ : std_logic;
SIGNAL \Mux29~0_combout\ : std_logic;
SIGNAL \Mux28~1_combout\ : std_logic;
SIGNAL \ShiftRight1~42_combout\ : std_logic;
SIGNAL \ShiftRight1~43_combout\ : std_logic;
SIGNAL \ShiftRight1~40_combout\ : std_logic;
SIGNAL \ShiftRight1~41_combout\ : std_logic;
SIGNAL \ShiftRight0~51_combout\ : std_logic;
SIGNAL \ShiftRight1~38_combout\ : std_logic;
SIGNAL \ShiftRight1~37_combout\ : std_logic;
SIGNAL \ShiftRight1~39_combout\ : std_logic;
SIGNAL \ShiftRight0~35_combout\ : std_logic;
SIGNAL \Mux29~1_combout\ : std_logic;
SIGNAL \Mux29~2_combout\ : std_logic;
SIGNAL \Mux28~3_combout\ : std_logic;
SIGNAL \Mux29~3_combout\ : std_logic;
SIGNAL \Mux28~0_combout\ : std_logic;
SIGNAL \ShiftRight0~49_combout\ : std_logic;
SIGNAL \ShiftRight0~48_combout\ : std_logic;
SIGNAL \ShiftRight0~50_combout\ : std_logic;
SIGNAL \ShiftLeft0~12_combout\ : std_logic;
SIGNAL \ShiftLeft0~13_combout\ : std_logic;
SIGNAL \ShiftLeft0~103_combout\ : std_logic;
SIGNAL \Mux29~4_combout\ : std_logic;
SIGNAL \Mux29~6_combout\ : std_logic;
SIGNAL \Mux28~11_combout\ : std_logic;
SIGNAL \Add0~11_combout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~12_combout\ : std_logic;
SIGNAL \ShiftLeft0~16_combout\ : std_logic;
SIGNAL \ShiftRight0~52_combout\ : std_logic;
SIGNAL \ShiftRight1~44_combout\ : std_logic;
SIGNAL \ShiftRight1~45_combout\ : std_logic;
SIGNAL \ShiftRight0~53_combout\ : std_logic;
SIGNAL \ShiftRight1~46_combout\ : std_logic;
SIGNAL \ShiftRight1~47_combout\ : std_logic;
SIGNAL \ShiftRight0~73_combout\ : std_logic;
SIGNAL \ShiftRight0~54_combout\ : std_logic;
SIGNAL \ShiftLeft0~14_combout\ : std_logic;
SIGNAL \ShiftLeft0~15_combout\ : std_logic;
SIGNAL \ShiftRight1~50_combout\ : std_logic;
SIGNAL \ShiftRight1~49_combout\ : std_logic;
SIGNAL \ShiftRight0~55_combout\ : std_logic;
SIGNAL \ShiftRight1~48_combout\ : std_logic;
SIGNAL \Mux28~7_combout\ : std_logic;
SIGNAL \Mux28~8_combout\ : std_logic;
SIGNAL \Mux28~6_combout\ : std_logic;
SIGNAL \Mux28~9_combout\ : std_logic;
SIGNAL \Mux28~10_combout\ : std_logic;
SIGNAL \Mux28~12_combout\ : std_logic;
SIGNAL \Mux25~6_combout\ : std_logic;
SIGNAL \Mux25~7_combout\ : std_logic;
SIGNAL \ShiftRight0~56_combout\ : std_logic;
SIGNAL \ShiftRight0~74_combout\ : std_logic;
SIGNAL \ShiftRight1~57_combout\ : std_logic;
SIGNAL \Mux25~4_combout\ : std_logic;
SIGNAL \Mux25~3_combout\ : std_logic;
SIGNAL \Mux25~5_combout\ : std_logic;
SIGNAL \ShiftRight0~57_combout\ : std_logic;
SIGNAL \Mux27~2_combout\ : std_logic;
SIGNAL \Mux27~3_combout\ : std_logic;
SIGNAL \Add0~14_combout\ : std_logic;
SIGNAL \Add0~13\ : std_logic;
SIGNAL \Add0~15_combout\ : std_logic;
SIGNAL \Mux27~4_combout\ : std_logic;
SIGNAL \Mux25~2_combout\ : std_logic;
SIGNAL \ShiftLeft0~17_combout\ : std_logic;
SIGNAL \ShiftLeft0~18_combout\ : std_logic;
SIGNAL \ShiftLeft0~19_combout\ : std_logic;
SIGNAL \ShiftLeft0~20_combout\ : std_logic;
SIGNAL \ShiftLeft0~21_combout\ : std_logic;
SIGNAL \Mux27~5_combout\ : std_logic;
SIGNAL \Mux27~6_combout\ : std_logic;
SIGNAL \Mux27~7_combout\ : std_logic;
SIGNAL \ShiftRight0~58_combout\ : std_logic;
SIGNAL \ShiftRight0~75_combout\ : std_logic;
SIGNAL \ShiftRight0~59_combout\ : std_logic;
SIGNAL \ShiftRight1~51_combout\ : std_logic;
SIGNAL \ShiftRight1~52_combout\ : std_logic;
SIGNAL \Mux26~2_combout\ : std_logic;
SIGNAL \Mux26~3_combout\ : std_logic;
SIGNAL \Add0~17_combout\ : std_logic;
SIGNAL \Add0~16\ : std_logic;
SIGNAL \Add0~18_combout\ : std_logic;
SIGNAL \Mux26~4_combout\ : std_logic;
SIGNAL \ShiftLeft0~22_combout\ : std_logic;
SIGNAL \ShiftLeft0~23_combout\ : std_logic;
SIGNAL \ShiftLeft0~24_combout\ : std_logic;
SIGNAL \ShiftLeft0~25_combout\ : std_logic;
SIGNAL \Mux26~5_combout\ : std_logic;
SIGNAL \Mux26~6_combout\ : std_logic;
SIGNAL \Mux26~7_combout\ : std_logic;
SIGNAL \ShiftLeft0~26_combout\ : std_logic;
SIGNAL \ShiftLeft0~27_combout\ : std_logic;
SIGNAL \ShiftLeft0~28_combout\ : std_logic;
SIGNAL \ShiftRight0~62_combout\ : std_logic;
SIGNAL \ShiftRight1~53_combout\ : std_logic;
SIGNAL \ShiftRight0~61_combout\ : std_logic;
SIGNAL \ShiftRight1~54_combout\ : std_logic;
SIGNAL \Mux25~8_combout\ : std_logic;
SIGNAL \Mux25~9_combout\ : std_logic;
SIGNAL \Add0~20_combout\ : std_logic;
SIGNAL \Add0~19\ : std_logic;
SIGNAL \Add0~21_combout\ : std_logic;
SIGNAL \Mux25~10_combout\ : std_logic;
SIGNAL \ShiftRight0~60_combout\ : std_logic;
SIGNAL \ShiftRight0~76_combout\ : std_logic;
SIGNAL \Mux25~11_combout\ : std_logic;
SIGNAL \Mux25~12_combout\ : std_logic;
SIGNAL \Mux25~13_combout\ : std_logic;
SIGNAL \ShiftRight0~65_combout\ : std_logic;
SIGNAL \ShiftRight0~63_combout\ : std_logic;
SIGNAL \ShiftRight1~58_combout\ : std_logic;
SIGNAL \Mux24~2_combout\ : std_logic;
SIGNAL \Mux24~3_combout\ : std_logic;
SIGNAL \Add0~23_combout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~24_combout\ : std_logic;
SIGNAL \Mux24~4_combout\ : std_logic;
SIGNAL \ShiftLeft0~29_combout\ : std_logic;
SIGNAL \ShiftLeft0~30_combout\ : std_logic;
SIGNAL \ShiftLeft0~31_combout\ : std_logic;
SIGNAL \ShiftLeft0~32_combout\ : std_logic;
SIGNAL \ShiftRight0~64_combout\ : std_logic;
SIGNAL \Mux24~5_combout\ : std_logic;
SIGNAL \Mux24~6_combout\ : std_logic;
SIGNAL \Mux24~7_combout\ : std_logic;
SIGNAL \Add0~26_combout\ : std_logic;
SIGNAL \Add0~25\ : std_logic;
SIGNAL \Add0~27_combout\ : std_logic;
SIGNAL \ShiftLeft0~34_combout\ : std_logic;
SIGNAL \ShiftLeft0~35_combout\ : std_logic;
SIGNAL \ShiftLeft0~33_combout\ : std_logic;
SIGNAL \ShiftLeft0~36_combout\ : std_logic;
SIGNAL \ShiftLeft0~37_combout\ : std_logic;
SIGNAL \ShiftRight0~66_combout\ : std_logic;
SIGNAL \Mux23~9_combout\ : std_logic;
SIGNAL \Mux23~4_combout\ : std_logic;
SIGNAL \Mux23~5_combout\ : std_logic;
SIGNAL \Mux23~6_combout\ : std_logic;
SIGNAL \Mux23~7_combout\ : std_logic;
SIGNAL \Mux23~2_combout\ : std_logic;
SIGNAL \Mux23~3_combout\ : std_logic;
SIGNAL \Mux23~8_combout\ : std_logic;
SIGNAL \Add0~29_combout\ : std_logic;
SIGNAL \Add0~28\ : std_logic;
SIGNAL \Add0~30_combout\ : std_logic;
SIGNAL \Mux22~4_combout\ : std_logic;
SIGNAL \ShiftLeft0~38_combout\ : std_logic;
SIGNAL \ShiftLeft0~39_combout\ : std_logic;
SIGNAL \ShiftLeft0~40_combout\ : std_logic;
SIGNAL \ShiftLeft0~104_combout\ : std_logic;
SIGNAL \ShiftRight1~59_combout\ : std_logic;
SIGNAL \Mux22~1_combout\ : std_logic;
SIGNAL \Mux22~2_combout\ : std_logic;
SIGNAL \ShiftRight0~67_combout\ : std_logic;
SIGNAL \Mux22~3_combout\ : std_logic;
SIGNAL \Mux22~5_combout\ : std_logic;
SIGNAL \Mux22~6_combout\ : std_logic;
SIGNAL \Mux21~8_combout\ : std_logic;
SIGNAL \Mux21~3_combout\ : std_logic;
SIGNAL \ShiftRight0~68_combout\ : std_logic;
SIGNAL \ShiftLeft0~41_combout\ : std_logic;
SIGNAL \ShiftLeft0~42_combout\ : std_logic;
SIGNAL \ShiftLeft0~43_combout\ : std_logic;
SIGNAL \ShiftLeft0~105_combout\ : std_logic;
SIGNAL \Mux21~4_combout\ : std_logic;
SIGNAL \Add0~32_combout\ : std_logic;
SIGNAL \Add0~31\ : std_logic;
SIGNAL \Add0~33_combout\ : std_logic;
SIGNAL \Mux21~5_combout\ : std_logic;
SIGNAL \Mux21~6_combout\ : std_logic;
SIGNAL \Mux21~7_combout\ : std_logic;
SIGNAL \ShiftLeft0~44_combout\ : std_logic;
SIGNAL \ShiftLeft0~45_combout\ : std_logic;
SIGNAL \ShiftLeft0~46_combout\ : std_logic;
SIGNAL \ShiftLeft0~106_combout\ : std_logic;
SIGNAL \Mux20~1_combout\ : std_logic;
SIGNAL \Mux20~2_combout\ : std_logic;
SIGNAL \ShiftRight0~69_combout\ : std_logic;
SIGNAL \ShiftRight0~70_combout\ : std_logic;
SIGNAL \Mux20~3_combout\ : std_logic;
SIGNAL \Mux20~4_combout\ : std_logic;
SIGNAL \Add0~35_combout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~36_combout\ : std_logic;
SIGNAL \Mux20~5_combout\ : std_logic;
SIGNAL \Mux20~0_combout\ : std_logic;
SIGNAL \Mux20~6_combout\ : std_logic;
SIGNAL \Add0~38_combout\ : std_logic;
SIGNAL \Add0~37\ : std_logic;
SIGNAL \Add0~39_combout\ : std_logic;
SIGNAL \Mux19~4_combout\ : std_logic;
SIGNAL \Mux19~1_combout\ : std_logic;
SIGNAL \Mux19~2_combout\ : std_logic;
SIGNAL \ShiftRight0~71_combout\ : std_logic;
SIGNAL \ShiftLeft0~47_combout\ : std_logic;
SIGNAL \ShiftLeft0~48_combout\ : std_logic;
SIGNAL \ShiftLeft0~49_combout\ : std_logic;
SIGNAL \ShiftLeft0~50_combout\ : std_logic;
SIGNAL \Mux19~3_combout\ : std_logic;
SIGNAL \Mux19~5_combout\ : std_logic;
SIGNAL \Mux19~0_combout\ : std_logic;
SIGNAL \Mux19~6_combout\ : std_logic;
SIGNAL \Mux18~0_combout\ : std_logic;
SIGNAL \Add0~41_combout\ : std_logic;
SIGNAL \Add0~40\ : std_logic;
SIGNAL \Add0~42_combout\ : std_logic;
SIGNAL \ShiftRight1~55_combout\ : std_logic;
SIGNAL \Mux18~1_combout\ : std_logic;
SIGNAL \Mux18~2_combout\ : std_logic;
SIGNAL \ShiftRight0~77_combout\ : std_logic;
SIGNAL \ShiftLeft0~52_combout\ : std_logic;
SIGNAL \ShiftLeft0~53_combout\ : std_logic;
SIGNAL \ShiftLeft0~54_combout\ : std_logic;
SIGNAL \ShiftLeft0~51_combout\ : std_logic;
SIGNAL \ShiftLeft0~55_combout\ : std_logic;
SIGNAL \Mux18~3_combout\ : std_logic;
SIGNAL \Mux18~4_combout\ : std_logic;
SIGNAL \Mux18~5_combout\ : std_logic;
SIGNAL \Mux18~6_combout\ : std_logic;
SIGNAL \Mux17~4_combout\ : std_logic;
SIGNAL \ShiftRight0~78_combout\ : std_logic;
SIGNAL \Mux17~1_combout\ : std_logic;
SIGNAL \Mux17~2_combout\ : std_logic;
SIGNAL \ShiftLeft0~57_combout\ : std_logic;
SIGNAL \ShiftLeft0~58_combout\ : std_logic;
SIGNAL \ShiftLeft0~59_combout\ : std_logic;
SIGNAL \ShiftLeft0~56_combout\ : std_logic;
SIGNAL \ShiftLeft0~60_combout\ : std_logic;
SIGNAL \Mux17~3_combout\ : std_logic;
SIGNAL \Add0~44_combout\ : std_logic;
SIGNAL \Add0~43\ : std_logic;
SIGNAL \Add0~45_combout\ : std_logic;
SIGNAL \Mux17~5_combout\ : std_logic;
SIGNAL \Mux17~0_combout\ : std_logic;
SIGNAL \Mux17~6_combout\ : std_logic;
SIGNAL \Mux16~4_combout\ : std_logic;
SIGNAL \Add0~47_combout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~48_combout\ : std_logic;
SIGNAL \Mux16~1_combout\ : std_logic;
SIGNAL \Mux16~2_combout\ : std_logic;
SIGNAL \ShiftLeft0~62_combout\ : std_logic;
SIGNAL \ShiftLeft0~63_combout\ : std_logic;
SIGNAL \ShiftLeft0~64_combout\ : std_logic;
SIGNAL \ShiftLeft0~61_combout\ : std_logic;
SIGNAL \ShiftLeft0~65_combout\ : std_logic;
SIGNAL \ShiftRight0~72_combout\ : std_logic;
SIGNAL \Mux16~3_combout\ : std_logic;
SIGNAL \Mux16~5_combout\ : std_logic;
SIGNAL \Mux16~0_combout\ : std_logic;
SIGNAL \Mux16~6_combout\ : std_logic;
SIGNAL \Add0~50_combout\ : std_logic;
SIGNAL \Add0~49\ : std_logic;
SIGNAL \Add0~51_combout\ : std_logic;
SIGNAL \Mux15~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux15~1_combout\ : std_logic;
SIGNAL \Mux15~2_combout\ : std_logic;
SIGNAL \Mux15~4_combout\ : std_logic;
SIGNAL \ShiftLeft0~66_combout\ : std_logic;
SIGNAL \ShiftLeft0~67_combout\ : std_logic;
SIGNAL \ShiftLeft0~68_combout\ : std_logic;
SIGNAL \Mux15~5_combout\ : std_logic;
SIGNAL \Mux15~3_combout\ : std_logic;
SIGNAL \Mux15~6_combout\ : std_logic;
SIGNAL \Mux15~7_combout\ : std_logic;
SIGNAL \Mux15~8_combout\ : std_logic;
SIGNAL \ShiftLeft0~69_combout\ : std_logic;
SIGNAL \ShiftLeft0~70_combout\ : std_logic;
SIGNAL \ShiftLeft0~71_combout\ : std_logic;
SIGNAL \Mux12~0_combout\ : std_logic;
SIGNAL \Mux12~1_combout\ : std_logic;
SIGNAL \Mux12~2_combout\ : std_logic;
SIGNAL \Mux14~0_combout\ : std_logic;
SIGNAL \Mux14~1_combout\ : std_logic;
SIGNAL \Mux12~4_combout\ : std_logic;
SIGNAL \Mux12~3_combout\ : std_logic;
SIGNAL \Add0~53_combout\ : std_logic;
SIGNAL \Add0~52\ : std_logic;
SIGNAL \Add0~54_combout\ : std_logic;
SIGNAL \Mux14~2_combout\ : std_logic;
SIGNAL \Mux14~3_combout\ : std_logic;
SIGNAL \Mux14~5_combout\ : std_logic;
SIGNAL \Mux14~4_combout\ : std_logic;
SIGNAL \Mux14~6_combout\ : std_logic;
SIGNAL \Mux13~4_combout\ : std_logic;
SIGNAL \Mux13~0_combout\ : std_logic;
SIGNAL \ShiftLeft0~72_combout\ : std_logic;
SIGNAL \ShiftLeft0~73_combout\ : std_logic;
SIGNAL \ShiftLeft0~74_combout\ : std_logic;
SIGNAL \Mux13~1_combout\ : std_logic;
SIGNAL \Add0~56_combout\ : std_logic;
SIGNAL \Add0~55\ : std_logic;
SIGNAL \Add0~57_combout\ : std_logic;
SIGNAL \ShiftRight1~56_combout\ : std_logic;
SIGNAL \Mux13~2_combout\ : std_logic;
SIGNAL \Mux13~3_combout\ : std_logic;
SIGNAL \Mux13~5_combout\ : std_logic;
SIGNAL \Mux12~9_combout\ : std_logic;
SIGNAL \ShiftLeft0~75_combout\ : std_logic;
SIGNAL \ShiftLeft0~76_combout\ : std_logic;
SIGNAL \ShiftLeft0~77_combout\ : std_logic;
SIGNAL \Mux12~5_combout\ : std_logic;
SIGNAL \Mux12~6_combout\ : std_logic;
SIGNAL \Add0~59_combout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~60_combout\ : std_logic;
SIGNAL \Mux12~7_combout\ : std_logic;
SIGNAL \ShiftRight1~60_combout\ : std_logic;
SIGNAL \Mux12~8_combout\ : std_logic;
SIGNAL \Mux12~10_combout\ : std_logic;
SIGNAL \Mux11~4_combout\ : std_logic;
SIGNAL \Add0~62_combout\ : std_logic;
SIGNAL \Add0~61\ : std_logic;
SIGNAL \Add0~63_combout\ : std_logic;
SIGNAL \Mux11~2_combout\ : std_logic;
SIGNAL \ShiftLeft0~78_combout\ : std_logic;
SIGNAL \ShiftLeft0~79_combout\ : std_logic;
SIGNAL \ShiftLeft0~80_combout\ : std_logic;
SIGNAL \Mux11~0_combout\ : std_logic;
SIGNAL \Mux11~1_combout\ : std_logic;
SIGNAL \Mux11~3_combout\ : std_logic;
SIGNAL \Mux11~5_combout\ : std_logic;
SIGNAL \Mux10~4_combout\ : std_logic;
SIGNAL \Add0~65_combout\ : std_logic;
SIGNAL \Add0~64\ : std_logic;
SIGNAL \Add0~66_combout\ : std_logic;
SIGNAL \ShiftLeft0~81_combout\ : std_logic;
SIGNAL \ShiftLeft0~82_combout\ : std_logic;
SIGNAL \ShiftLeft0~83_combout\ : std_logic;
SIGNAL \Mux10~0_combout\ : std_logic;
SIGNAL \Mux10~1_combout\ : std_logic;
SIGNAL \Mux10~2_combout\ : std_logic;
SIGNAL \Mux10~3_combout\ : std_logic;
SIGNAL \Mux10~5_combout\ : std_logic;
SIGNAL \Add0~68_combout\ : std_logic;
SIGNAL \Add0~67\ : std_logic;
SIGNAL \Add0~69_combout\ : std_logic;
SIGNAL \Mux9~2_combout\ : std_logic;
SIGNAL \Mux9~0_combout\ : std_logic;
SIGNAL \ShiftLeft0~84_combout\ : std_logic;
SIGNAL \ShiftLeft0~85_combout\ : std_logic;
SIGNAL \ShiftLeft0~86_combout\ : std_logic;
SIGNAL \Mux9~1_combout\ : std_logic;
SIGNAL \Mux9~3_combout\ : std_logic;
SIGNAL \Mux9~4_combout\ : std_logic;
SIGNAL \Mux9~5_combout\ : std_logic;
SIGNAL \Mux8~4_combout\ : std_logic;
SIGNAL \Add0~71_combout\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~72_combout\ : std_logic;
SIGNAL \ShiftLeft0~87_combout\ : std_logic;
SIGNAL \ShiftLeft0~88_combout\ : std_logic;
SIGNAL \ShiftLeft0~89_combout\ : std_logic;
SIGNAL \Mux8~0_combout\ : std_logic;
SIGNAL \Mux8~1_combout\ : std_logic;
SIGNAL \Mux8~2_combout\ : std_logic;
SIGNAL \Mux8~3_combout\ : std_logic;
SIGNAL \Mux8~5_combout\ : std_logic;
SIGNAL \Add0~74_combout\ : std_logic;
SIGNAL \Add0~73\ : std_logic;
SIGNAL \Add0~75_combout\ : std_logic;
SIGNAL \Mux7~5_combout\ : std_logic;
SIGNAL \ShiftLeft0~90_combout\ : std_logic;
SIGNAL \ShiftLeft0~91_combout\ : std_logic;
SIGNAL \Mux7~1_combout\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Mux7~2_combout\ : std_logic;
SIGNAL \Mux7~3_combout\ : std_logic;
SIGNAL \Mux7~4_combout\ : std_logic;
SIGNAL \Mux7~6_combout\ : std_logic;
SIGNAL \ShiftRight1~61_combout\ : std_logic;
SIGNAL \Mux7~7_combout\ : std_logic;
SIGNAL \Mux7~8_combout\ : std_logic;
SIGNAL \Mux7~combout\ : std_logic;
SIGNAL \ShiftLeft0~92_combout\ : std_logic;
SIGNAL \ShiftLeft0~93_combout\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux6~1_combout\ : std_logic;
SIGNAL \Mux6~2_combout\ : std_logic;
SIGNAL \Mux6~3_combout\ : std_logic;
SIGNAL \Add0~77_combout\ : std_logic;
SIGNAL \Add0~76\ : std_logic;
SIGNAL \Add0~78_combout\ : std_logic;
SIGNAL \Mux6~4_combout\ : std_logic;
SIGNAL \Mux6~combout\ : std_logic;
SIGNAL \ShiftLeft0~95_combout\ : std_logic;
SIGNAL \ShiftLeft0~94_combout\ : std_logic;
SIGNAL \ShiftLeft0~96_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux5~1_combout\ : std_logic;
SIGNAL \Mux5~2_combout\ : std_logic;
SIGNAL \ShiftRight1~62_combout\ : std_logic;
SIGNAL \Mux5~3_combout\ : std_logic;
SIGNAL \Add0~80_combout\ : std_logic;
SIGNAL \Add0~79\ : std_logic;
SIGNAL \Add0~81_combout\ : std_logic;
SIGNAL \Mux5~4_combout\ : std_logic;
SIGNAL \Mux5~combout\ : std_logic;
SIGNAL \Add0~83_combout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~84_combout\ : std_logic;
SIGNAL \ShiftLeft0~97_combout\ : std_logic;
SIGNAL \ShiftLeft0~98_combout\ : std_logic;
SIGNAL \ShiftLeft0~99_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux4~1_combout\ : std_logic;
SIGNAL \Mux4~2_combout\ : std_logic;
SIGNAL \ShiftRight1~63_combout\ : std_logic;
SIGNAL \Mux4~3_combout\ : std_logic;
SIGNAL \Mux4~4_combout\ : std_logic;
SIGNAL \Mux4~combout\ : std_logic;
SIGNAL \Add0~86_combout\ : std_logic;
SIGNAL \Add0~85\ : std_logic;
SIGNAL \Add0~87_combout\ : std_logic;
SIGNAL \Mux3~10_combout\ : std_logic;
SIGNAL \ShiftLeft0~100_combout\ : std_logic;
SIGNAL \Mux3~2_combout\ : std_logic;
SIGNAL \Mux3~3_combout\ : std_logic;
SIGNAL \Mux3~4_combout\ : std_logic;
SIGNAL \ShiftRight1~64_combout\ : std_logic;
SIGNAL \Mux3~7_combout\ : std_logic;
SIGNAL \Mux3~6_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Mux3~5_combout\ : std_logic;
SIGNAL \Mux3~8_combout\ : std_logic;
SIGNAL \Mux3~9_combout\ : std_logic;
SIGNAL \Mux3~11_combout\ : std_logic;
SIGNAL \Mux3~12_combout\ : std_logic;
SIGNAL \ShiftLeft0~101_combout\ : std_logic;
SIGNAL \Mux2~3_combout\ : std_logic;
SIGNAL \Mux2~4_combout\ : std_logic;
SIGNAL \Mux2~9_combout\ : std_logic;
SIGNAL \Mux2~5_combout\ : std_logic;
SIGNAL \Mux2~6_combout\ : std_logic;
SIGNAL \Mux2~2_combout\ : std_logic;
SIGNAL \Add0~89_combout\ : std_logic;
SIGNAL \Add0~88\ : std_logic;
SIGNAL \Add0~90_combout\ : std_logic;
SIGNAL \Mux2~7_combout\ : std_logic;
SIGNAL \Mux2~8_combout\ : std_logic;
SIGNAL \Mux1~1_combout\ : std_logic;
SIGNAL \Mux1~2_combout\ : std_logic;
SIGNAL \Add0~92_combout\ : std_logic;
SIGNAL \Add0~91\ : std_logic;
SIGNAL \Add0~93_combout\ : std_logic;
SIGNAL \Mux1~3_combout\ : std_logic;
SIGNAL \Mux1~4_combout\ : std_logic;
SIGNAL \Mux1~5_combout\ : std_logic;
SIGNAL \Mux1~6_combout\ : std_logic;
SIGNAL \Mux1~7_combout\ : std_logic;
SIGNAL \Mux1~8_combout\ : std_logic;
SIGNAL \Mux1~9_combout\ : std_logic;
SIGNAL \Mux1~10_combout\ : std_logic;
SIGNAL \Mux0~4_combout\ : std_logic;
SIGNAL \Mux0~5_combout\ : std_logic;
SIGNAL \Mux0~6_combout\ : std_logic;
SIGNAL \Mux0~7_combout\ : std_logic;
SIGNAL \Mux0~8_combout\ : std_logic;
SIGNAL \Add0~95_combout\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~96_combout\ : std_logic;
SIGNAL \Mux0~1_combout\ : std_logic;
SIGNAL \Mux0~2_combout\ : std_logic;
SIGNAL \Mux0~3_combout\ : std_logic;
SIGNAL \Mux0~9_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \Equal0~7_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~8_combout\ : std_logic;
SIGNAL \Equal0~9_combout\ : std_logic;
SIGNAL \Equal0~10_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_A <= A;
ww_B <= B;
ww_ALUOP <= ALUOP;
Result <= ww_Result;
Zero <= ww_Zero;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y47_N24
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X78_Y40_N9
\Result[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux31~12_combout\,
	devoe => ww_devoe,
	o => \Result[0]~output_o\);

-- Location: IOOBUF_X78_Y35_N2
\Result[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux30~10_combout\,
	devoe => ww_devoe,
	o => \Result[1]~output_o\);

-- Location: IOOBUF_X56_Y54_N16
\Result[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux29~6_combout\,
	devoe => ww_devoe,
	o => \Result[2]~output_o\);

-- Location: IOOBUF_X31_Y39_N9
\Result[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux28~12_combout\,
	devoe => ww_devoe,
	o => \Result[3]~output_o\);

-- Location: IOOBUF_X49_Y54_N9
\Result[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux27~7_combout\,
	devoe => ww_devoe,
	o => \Result[4]~output_o\);

-- Location: IOOBUF_X78_Y43_N9
\Result[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux26~7_combout\,
	devoe => ww_devoe,
	o => \Result[5]~output_o\);

-- Location: IOOBUF_X56_Y54_N9
\Result[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux25~13_combout\,
	devoe => ww_devoe,
	o => \Result[6]~output_o\);

-- Location: IOOBUF_X78_Y42_N2
\Result[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux24~7_combout\,
	devoe => ww_devoe,
	o => \Result[7]~output_o\);

-- Location: IOOBUF_X78_Y40_N23
\Result[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux23~8_combout\,
	devoe => ww_devoe,
	o => \Result[8]~output_o\);

-- Location: IOOBUF_X26_Y39_N23
\Result[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux22~6_combout\,
	devoe => ww_devoe,
	o => \Result[9]~output_o\);

-- Location: IOOBUF_X22_Y39_N30
\Result[10]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux21~7_combout\,
	devoe => ww_devoe,
	o => \Result[10]~output_o\);

-- Location: IOOBUF_X26_Y39_N16
\Result[11]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux20~6_combout\,
	devoe => ww_devoe,
	o => \Result[11]~output_o\);

-- Location: IOOBUF_X56_Y54_N23
\Result[12]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux19~6_combout\,
	devoe => ww_devoe,
	o => \Result[12]~output_o\);

-- Location: IOOBUF_X26_Y39_N2
\Result[13]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux18~6_combout\,
	devoe => ww_devoe,
	o => \Result[13]~output_o\);

-- Location: IOOBUF_X24_Y39_N9
\Result[14]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux17~6_combout\,
	devoe => ww_devoe,
	o => \Result[14]~output_o\);

-- Location: IOOBUF_X78_Y29_N16
\Result[15]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux16~6_combout\,
	devoe => ww_devoe,
	o => \Result[15]~output_o\);

-- Location: IOOBUF_X24_Y39_N30
\Result[16]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux15~8_combout\,
	devoe => ww_devoe,
	o => \Result[16]~output_o\);

-- Location: IOOBUF_X54_Y54_N2
\Result[17]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux14~6_combout\,
	devoe => ww_devoe,
	o => \Result[17]~output_o\);

-- Location: IOOBUF_X26_Y39_N30
\Result[18]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux13~5_combout\,
	devoe => ww_devoe,
	o => \Result[18]~output_o\);

-- Location: IOOBUF_X78_Y42_N16
\Result[19]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux12~10_combout\,
	devoe => ww_devoe,
	o => \Result[19]~output_o\);

-- Location: IOOBUF_X78_Y42_N9
\Result[20]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux11~5_combout\,
	devoe => ww_devoe,
	o => \Result[20]~output_o\);

-- Location: IOOBUF_X78_Y41_N2
\Result[21]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux10~5_combout\,
	devoe => ww_devoe,
	o => \Result[21]~output_o\);

-- Location: IOOBUF_X31_Y39_N23
\Result[22]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux9~5_combout\,
	devoe => ww_devoe,
	o => \Result[22]~output_o\);

-- Location: IOOBUF_X60_Y54_N30
\Result[23]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux8~5_combout\,
	devoe => ww_devoe,
	o => \Result[23]~output_o\);

-- Location: IOOBUF_X78_Y43_N16
\Result[24]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~combout\,
	devoe => ww_devoe,
	o => \Result[24]~output_o\);

-- Location: IOOBUF_X62_Y54_N30
\Result[25]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~combout\,
	devoe => ww_devoe,
	o => \Result[25]~output_o\);

-- Location: IOOBUF_X49_Y54_N16
\Result[26]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux5~combout\,
	devoe => ww_devoe,
	o => \Result[26]~output_o\);

-- Location: IOOBUF_X78_Y44_N9
\Result[27]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux4~combout\,
	devoe => ww_devoe,
	o => \Result[27]~output_o\);

-- Location: IOOBUF_X49_Y54_N30
\Result[28]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux3~12_combout\,
	devoe => ww_devoe,
	o => \Result[28]~output_o\);

-- Location: IOOBUF_X46_Y54_N30
\Result[29]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux2~8_combout\,
	devoe => ww_devoe,
	o => \Result[29]~output_o\);

-- Location: IOOBUF_X26_Y39_N9
\Result[30]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux1~10_combout\,
	devoe => ww_devoe,
	o => \Result[30]~output_o\);

-- Location: IOOBUF_X78_Y36_N16
\Result[31]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux0~9_combout\,
	devoe => ww_devoe,
	o => \Result[31]~output_o\);

-- Location: IOOBUF_X51_Y54_N16
\Zero~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Equal0~10_combout\,
	devoe => ww_devoe,
	o => \Zero~output_o\);

-- Location: IOIBUF_X78_Y35_N22
\B[31]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(31),
	o => \B[31]~input_o\);

-- Location: IOIBUF_X34_Y39_N1
\A[31]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(31),
	o => \A[31]~input_o\);

-- Location: IOIBUF_X31_Y39_N1
\A[30]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(30),
	o => \A[30]~input_o\);

-- Location: IOIBUF_X78_Y33_N15
\B[30]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(30),
	o => \B[30]~input_o\);

-- Location: IOIBUF_X54_Y54_N29
\A[29]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(29),
	o => \A[29]~input_o\);

-- Location: IOIBUF_X58_Y54_N15
\B[29]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(29),
	o => \B[29]~input_o\);

-- Location: IOIBUF_X66_Y54_N1
\B[28]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(28),
	o => \B[28]~input_o\);

-- Location: IOIBUF_X51_Y54_N22
\A[28]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(28),
	o => \A[28]~input_o\);

-- Location: IOIBUF_X34_Y39_N29
\B[27]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(27),
	o => \B[27]~input_o\);

-- Location: IOIBUF_X46_Y54_N8
\A[27]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(27),
	o => \A[27]~input_o\);

-- Location: IOIBUF_X31_Y39_N15
\B[26]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(26),
	o => \B[26]~input_o\);

-- Location: IOIBUF_X78_Y34_N23
\A[26]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(26),
	o => \A[26]~input_o\);

-- Location: IOIBUF_X60_Y54_N15
\A[25]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(25),
	o => \A[25]~input_o\);

-- Location: IOIBUF_X60_Y54_N22
\B[25]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(25),
	o => \B[25]~input_o\);

-- Location: IOIBUF_X58_Y54_N29
\A[24]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(24),
	o => \A[24]~input_o\);

-- Location: IOIBUF_X78_Y34_N1
\B[24]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(24),
	o => \B[24]~input_o\);

-- Location: IOIBUF_X66_Y54_N8
\B[23]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(23),
	o => \B[23]~input_o\);

-- Location: IOIBUF_X78_Y37_N22
\A[23]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(23),
	o => \A[23]~input_o\);

-- Location: IOIBUF_X29_Y39_N15
\A[22]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(22),
	o => \A[22]~input_o\);

-- Location: IOIBUF_X58_Y54_N1
\B[22]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(22),
	o => \B[22]~input_o\);

-- Location: IOIBUF_X29_Y39_N8
\B[21]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(21),
	o => \B[21]~input_o\);

-- Location: IOIBUF_X34_Y39_N8
\A[21]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(21),
	o => \A[21]~input_o\);

-- Location: IOIBUF_X78_Y37_N1
\B[20]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(20),
	o => \B[20]~input_o\);

-- Location: IOIBUF_X66_Y54_N15
\A[20]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(20),
	o => \A[20]~input_o\);

-- Location: IOIBUF_X78_Y41_N8
\A[19]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(19),
	o => \A[19]~input_o\);

-- Location: IOIBUF_X78_Y31_N1
\B[19]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(19),
	o => \B[19]~input_o\);

-- Location: IOIBUF_X78_Y37_N8
\A[18]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(18),
	o => \A[18]~input_o\);

-- Location: IOIBUF_X78_Y34_N8
\B[18]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(18),
	o => \B[18]~input_o\);

-- Location: IOIBUF_X51_Y54_N29
\A[17]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(17),
	o => \A[17]~input_o\);

-- Location: IOIBUF_X66_Y54_N22
\B[17]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(17),
	o => \B[17]~input_o\);

-- Location: IOIBUF_X78_Y36_N23
\B[16]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(16),
	o => \B[16]~input_o\);

-- Location: IOIBUF_X78_Y36_N8
\A[16]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(16),
	o => \A[16]~input_o\);

-- Location: IOIBUF_X64_Y54_N1
\A[15]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(15),
	o => \A[15]~input_o\);

-- Location: IOIBUF_X54_Y54_N15
\B[15]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(15),
	o => \B[15]~input_o\);

-- Location: IOIBUF_X51_Y54_N1
\A[14]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(14),
	o => \A[14]~input_o\);

-- Location: IOIBUF_X58_Y54_N8
\B[14]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(14),
	o => \B[14]~input_o\);

-- Location: IOIBUF_X78_Y34_N15
\B[13]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(13),
	o => \B[13]~input_o\);

-- Location: IOIBUF_X56_Y54_N29
\A[13]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(13),
	o => \A[13]~input_o\);

-- Location: IOIBUF_X54_Y54_N22
\A[12]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(12),
	o => \A[12]~input_o\);

-- Location: IOIBUF_X78_Y33_N22
\B[12]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(12),
	o => \B[12]~input_o\);

-- Location: IOIBUF_X78_Y36_N1
\B[11]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(11),
	o => \B[11]~input_o\);

-- Location: IOIBUF_X31_Y39_N29
\A[11]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(11),
	o => \A[11]~input_o\);

-- Location: IOIBUF_X49_Y54_N22
\A[10]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(10),
	o => \A[10]~input_o\);

-- Location: IOIBUF_X29_Y39_N1
\B[10]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(10),
	o => \B[10]~input_o\);

-- Location: IOIBUF_X71_Y54_N29
\B[9]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(9),
	o => \B[9]~input_o\);

-- Location: IOIBUF_X78_Y42_N22
\A[9]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(9),
	o => \A[9]~input_o\);

-- Location: IOIBUF_X69_Y54_N22
\A[8]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(8),
	o => \A[8]~input_o\);

-- Location: IOIBUF_X58_Y54_N22
\B[8]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(8),
	o => \B[8]~input_o\);

-- Location: IOIBUF_X34_Y39_N22
\A[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

-- Location: IOIBUF_X54_Y54_N8
\B[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(7),
	o => \B[7]~input_o\);

-- Location: IOIBUF_X78_Y40_N1
\B[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(6),
	o => \B[6]~input_o\);

-- Location: IOIBUF_X78_Y41_N23
\A[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

-- Location: IOIBUF_X66_Y54_N29
\A[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

-- Location: IOIBUF_X60_Y54_N8
\B[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(5),
	o => \B[5]~input_o\);

-- Location: IOIBUF_X56_Y54_N1
\A[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

-- Location: IOIBUF_X34_Y39_N15
\B[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(4),
	o => \B[4]~input_o\);

-- Location: IOIBUF_X46_Y54_N22
\B[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: IOIBUF_X49_Y54_N1
\A[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: IOIBUF_X46_Y54_N15
\B[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: IOIBUF_X60_Y54_N1
\A[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: IOIBUF_X36_Y39_N29
\B[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: IOIBUF_X78_Y41_N15
\A[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: IOIBUF_X36_Y39_N22
\B[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: IOIBUF_X36_Y39_N15
\A[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: LCCOMB_X54_Y38_N0
\LessThan0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~1_cout\ = CARRY((\B[0]~input_o\ & !\A[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[0]~input_o\,
	datad => VCC,
	cout => \LessThan0~1_cout\);

-- Location: LCCOMB_X54_Y38_N2
\LessThan0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~3_cout\ = CARRY((\B[1]~input_o\ & (\A[1]~input_o\ & !\LessThan0~1_cout\)) # (!\B[1]~input_o\ & ((\A[1]~input_o\) # (!\LessThan0~1_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[1]~input_o\,
	datad => VCC,
	cin => \LessThan0~1_cout\,
	cout => \LessThan0~3_cout\);

-- Location: LCCOMB_X54_Y38_N4
\LessThan0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~5_cout\ = CARRY((\B[2]~input_o\ & ((!\LessThan0~3_cout\) # (!\A[2]~input_o\))) # (!\B[2]~input_o\ & (!\A[2]~input_o\ & !\LessThan0~3_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \A[2]~input_o\,
	datad => VCC,
	cin => \LessThan0~3_cout\,
	cout => \LessThan0~5_cout\);

-- Location: LCCOMB_X54_Y38_N6
\LessThan0~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~7_cout\ = CARRY((\B[3]~input_o\ & (\A[3]~input_o\ & !\LessThan0~5_cout\)) # (!\B[3]~input_o\ & ((\A[3]~input_o\) # (!\LessThan0~5_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \A[3]~input_o\,
	datad => VCC,
	cin => \LessThan0~5_cout\,
	cout => \LessThan0~7_cout\);

-- Location: LCCOMB_X54_Y38_N8
\LessThan0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~9_cout\ = CARRY((\A[4]~input_o\ & (\B[4]~input_o\ & !\LessThan0~7_cout\)) # (!\A[4]~input_o\ & ((\B[4]~input_o\) # (!\LessThan0~7_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[4]~input_o\,
	datab => \B[4]~input_o\,
	datad => VCC,
	cin => \LessThan0~7_cout\,
	cout => \LessThan0~9_cout\);

-- Location: LCCOMB_X54_Y38_N10
\LessThan0~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~11_cout\ = CARRY((\A[5]~input_o\ & ((!\LessThan0~9_cout\) # (!\B[5]~input_o\))) # (!\A[5]~input_o\ & (!\B[5]~input_o\ & !\LessThan0~9_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \B[5]~input_o\,
	datad => VCC,
	cin => \LessThan0~9_cout\,
	cout => \LessThan0~11_cout\);

-- Location: LCCOMB_X54_Y38_N12
\LessThan0~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~13_cout\ = CARRY((\B[6]~input_o\ & ((!\LessThan0~11_cout\) # (!\A[6]~input_o\))) # (!\B[6]~input_o\ & (!\A[6]~input_o\ & !\LessThan0~11_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[6]~input_o\,
	datab => \A[6]~input_o\,
	datad => VCC,
	cin => \LessThan0~11_cout\,
	cout => \LessThan0~13_cout\);

-- Location: LCCOMB_X54_Y38_N14
\LessThan0~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~15_cout\ = CARRY((\A[7]~input_o\ & ((!\LessThan0~13_cout\) # (!\B[7]~input_o\))) # (!\A[7]~input_o\ & (!\B[7]~input_o\ & !\LessThan0~13_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[7]~input_o\,
	datad => VCC,
	cin => \LessThan0~13_cout\,
	cout => \LessThan0~15_cout\);

-- Location: LCCOMB_X54_Y38_N16
\LessThan0~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~17_cout\ = CARRY((\A[8]~input_o\ & (\B[8]~input_o\ & !\LessThan0~15_cout\)) # (!\A[8]~input_o\ & ((\B[8]~input_o\) # (!\LessThan0~15_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[8]~input_o\,
	datab => \B[8]~input_o\,
	datad => VCC,
	cin => \LessThan0~15_cout\,
	cout => \LessThan0~17_cout\);

-- Location: LCCOMB_X54_Y38_N18
\LessThan0~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~19_cout\ = CARRY((\B[9]~input_o\ & (\A[9]~input_o\ & !\LessThan0~17_cout\)) # (!\B[9]~input_o\ & ((\A[9]~input_o\) # (!\LessThan0~17_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[9]~input_o\,
	datab => \A[9]~input_o\,
	datad => VCC,
	cin => \LessThan0~17_cout\,
	cout => \LessThan0~19_cout\);

-- Location: LCCOMB_X54_Y38_N20
\LessThan0~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~21_cout\ = CARRY((\A[10]~input_o\ & (\B[10]~input_o\ & !\LessThan0~19_cout\)) # (!\A[10]~input_o\ & ((\B[10]~input_o\) # (!\LessThan0~19_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[10]~input_o\,
	datab => \B[10]~input_o\,
	datad => VCC,
	cin => \LessThan0~19_cout\,
	cout => \LessThan0~21_cout\);

-- Location: LCCOMB_X54_Y38_N22
\LessThan0~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~23_cout\ = CARRY((\B[11]~input_o\ & (\A[11]~input_o\ & !\LessThan0~21_cout\)) # (!\B[11]~input_o\ & ((\A[11]~input_o\) # (!\LessThan0~21_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[11]~input_o\,
	datab => \A[11]~input_o\,
	datad => VCC,
	cin => \LessThan0~21_cout\,
	cout => \LessThan0~23_cout\);

-- Location: LCCOMB_X54_Y38_N24
\LessThan0~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~25_cout\ = CARRY((\A[12]~input_o\ & (\B[12]~input_o\ & !\LessThan0~23_cout\)) # (!\A[12]~input_o\ & ((\B[12]~input_o\) # (!\LessThan0~23_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[12]~input_o\,
	datab => \B[12]~input_o\,
	datad => VCC,
	cin => \LessThan0~23_cout\,
	cout => \LessThan0~25_cout\);

-- Location: LCCOMB_X54_Y38_N26
\LessThan0~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~27_cout\ = CARRY((\B[13]~input_o\ & (\A[13]~input_o\ & !\LessThan0~25_cout\)) # (!\B[13]~input_o\ & ((\A[13]~input_o\) # (!\LessThan0~25_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[13]~input_o\,
	datab => \A[13]~input_o\,
	datad => VCC,
	cin => \LessThan0~25_cout\,
	cout => \LessThan0~27_cout\);

-- Location: LCCOMB_X54_Y38_N28
\LessThan0~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~29_cout\ = CARRY((\A[14]~input_o\ & (\B[14]~input_o\ & !\LessThan0~27_cout\)) # (!\A[14]~input_o\ & ((\B[14]~input_o\) # (!\LessThan0~27_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[14]~input_o\,
	datab => \B[14]~input_o\,
	datad => VCC,
	cin => \LessThan0~27_cout\,
	cout => \LessThan0~29_cout\);

-- Location: LCCOMB_X54_Y38_N30
\LessThan0~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~31_cout\ = CARRY((\A[15]~input_o\ & ((!\LessThan0~29_cout\) # (!\B[15]~input_o\))) # (!\A[15]~input_o\ & (!\B[15]~input_o\ & !\LessThan0~29_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[15]~input_o\,
	datab => \B[15]~input_o\,
	datad => VCC,
	cin => \LessThan0~29_cout\,
	cout => \LessThan0~31_cout\);

-- Location: LCCOMB_X54_Y37_N0
\LessThan0~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~33_cout\ = CARRY((\B[16]~input_o\ & ((!\LessThan0~31_cout\) # (!\A[16]~input_o\))) # (!\B[16]~input_o\ & (!\A[16]~input_o\ & !\LessThan0~31_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[16]~input_o\,
	datab => \A[16]~input_o\,
	datad => VCC,
	cin => \LessThan0~31_cout\,
	cout => \LessThan0~33_cout\);

-- Location: LCCOMB_X54_Y37_N2
\LessThan0~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~35_cout\ = CARRY((\A[17]~input_o\ & ((!\LessThan0~33_cout\) # (!\B[17]~input_o\))) # (!\A[17]~input_o\ & (!\B[17]~input_o\ & !\LessThan0~33_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[17]~input_o\,
	datab => \B[17]~input_o\,
	datad => VCC,
	cin => \LessThan0~33_cout\,
	cout => \LessThan0~35_cout\);

-- Location: LCCOMB_X54_Y37_N4
\LessThan0~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~37_cout\ = CARRY((\A[18]~input_o\ & (\B[18]~input_o\ & !\LessThan0~35_cout\)) # (!\A[18]~input_o\ & ((\B[18]~input_o\) # (!\LessThan0~35_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[18]~input_o\,
	datab => \B[18]~input_o\,
	datad => VCC,
	cin => \LessThan0~35_cout\,
	cout => \LessThan0~37_cout\);

-- Location: LCCOMB_X54_Y37_N6
\LessThan0~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~39_cout\ = CARRY((\A[19]~input_o\ & ((!\LessThan0~37_cout\) # (!\B[19]~input_o\))) # (!\A[19]~input_o\ & (!\B[19]~input_o\ & !\LessThan0~37_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[19]~input_o\,
	datab => \B[19]~input_o\,
	datad => VCC,
	cin => \LessThan0~37_cout\,
	cout => \LessThan0~39_cout\);

-- Location: LCCOMB_X54_Y37_N8
\LessThan0~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~41_cout\ = CARRY((\B[20]~input_o\ & ((!\LessThan0~39_cout\) # (!\A[20]~input_o\))) # (!\B[20]~input_o\ & (!\A[20]~input_o\ & !\LessThan0~39_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[20]~input_o\,
	datab => \A[20]~input_o\,
	datad => VCC,
	cin => \LessThan0~39_cout\,
	cout => \LessThan0~41_cout\);

-- Location: LCCOMB_X54_Y37_N10
\LessThan0~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~43_cout\ = CARRY((\B[21]~input_o\ & (\A[21]~input_o\ & !\LessThan0~41_cout\)) # (!\B[21]~input_o\ & ((\A[21]~input_o\) # (!\LessThan0~41_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[21]~input_o\,
	datab => \A[21]~input_o\,
	datad => VCC,
	cin => \LessThan0~41_cout\,
	cout => \LessThan0~43_cout\);

-- Location: LCCOMB_X54_Y37_N12
\LessThan0~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~45_cout\ = CARRY((\A[22]~input_o\ & (\B[22]~input_o\ & !\LessThan0~43_cout\)) # (!\A[22]~input_o\ & ((\B[22]~input_o\) # (!\LessThan0~43_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[22]~input_o\,
	datab => \B[22]~input_o\,
	datad => VCC,
	cin => \LessThan0~43_cout\,
	cout => \LessThan0~45_cout\);

-- Location: LCCOMB_X54_Y37_N14
\LessThan0~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~47_cout\ = CARRY((\B[23]~input_o\ & (\A[23]~input_o\ & !\LessThan0~45_cout\)) # (!\B[23]~input_o\ & ((\A[23]~input_o\) # (!\LessThan0~45_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[23]~input_o\,
	datab => \A[23]~input_o\,
	datad => VCC,
	cin => \LessThan0~45_cout\,
	cout => \LessThan0~47_cout\);

-- Location: LCCOMB_X54_Y37_N16
\LessThan0~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~49_cout\ = CARRY((\A[24]~input_o\ & (\B[24]~input_o\ & !\LessThan0~47_cout\)) # (!\A[24]~input_o\ & ((\B[24]~input_o\) # (!\LessThan0~47_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[24]~input_o\,
	datab => \B[24]~input_o\,
	datad => VCC,
	cin => \LessThan0~47_cout\,
	cout => \LessThan0~49_cout\);

-- Location: LCCOMB_X54_Y37_N18
\LessThan0~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~51_cout\ = CARRY((\A[25]~input_o\ & ((!\LessThan0~49_cout\) # (!\B[25]~input_o\))) # (!\A[25]~input_o\ & (!\B[25]~input_o\ & !\LessThan0~49_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[25]~input_o\,
	datab => \B[25]~input_o\,
	datad => VCC,
	cin => \LessThan0~49_cout\,
	cout => \LessThan0~51_cout\);

-- Location: LCCOMB_X54_Y37_N20
\LessThan0~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~53_cout\ = CARRY((\B[26]~input_o\ & ((!\LessThan0~51_cout\) # (!\A[26]~input_o\))) # (!\B[26]~input_o\ & (!\A[26]~input_o\ & !\LessThan0~51_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[26]~input_o\,
	datab => \A[26]~input_o\,
	datad => VCC,
	cin => \LessThan0~51_cout\,
	cout => \LessThan0~53_cout\);

-- Location: LCCOMB_X54_Y37_N22
\LessThan0~55\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~55_cout\ = CARRY((\B[27]~input_o\ & (\A[27]~input_o\ & !\LessThan0~53_cout\)) # (!\B[27]~input_o\ & ((\A[27]~input_o\) # (!\LessThan0~53_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[27]~input_o\,
	datab => \A[27]~input_o\,
	datad => VCC,
	cin => \LessThan0~53_cout\,
	cout => \LessThan0~55_cout\);

-- Location: LCCOMB_X54_Y37_N24
\LessThan0~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~57_cout\ = CARRY((\B[28]~input_o\ & ((!\LessThan0~55_cout\) # (!\A[28]~input_o\))) # (!\B[28]~input_o\ & (!\A[28]~input_o\ & !\LessThan0~55_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[28]~input_o\,
	datab => \A[28]~input_o\,
	datad => VCC,
	cin => \LessThan0~55_cout\,
	cout => \LessThan0~57_cout\);

-- Location: LCCOMB_X54_Y37_N26
\LessThan0~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~59_cout\ = CARRY((\A[29]~input_o\ & ((!\LessThan0~57_cout\) # (!\B[29]~input_o\))) # (!\A[29]~input_o\ & (!\B[29]~input_o\ & !\LessThan0~57_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[29]~input_o\,
	datab => \B[29]~input_o\,
	datad => VCC,
	cin => \LessThan0~57_cout\,
	cout => \LessThan0~59_cout\);

-- Location: LCCOMB_X54_Y37_N28
\LessThan0~61\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~61_cout\ = CARRY((\A[30]~input_o\ & (\B[30]~input_o\ & !\LessThan0~59_cout\)) # (!\A[30]~input_o\ & ((\B[30]~input_o\) # (!\LessThan0~59_cout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \B[30]~input_o\,
	datad => VCC,
	cin => \LessThan0~59_cout\,
	cout => \LessThan0~61_cout\);

-- Location: LCCOMB_X54_Y37_N30
\LessThan0~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \LessThan0~62_combout\ = (\B[31]~input_o\ & (\A[31]~input_o\ & \LessThan0~61_cout\)) # (!\B[31]~input_o\ & ((\A[31]~input_o\) # (\LessThan0~61_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010011010100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \B[31]~input_o\,
	datab => \A[31]~input_o\,
	cin => \LessThan0~61_cout\,
	combout => \LessThan0~62_combout\);

-- Location: IOIBUF_X46_Y54_N1
\ALUOP[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ALUOP(1),
	o => \ALUOP[1]~input_o\);

-- Location: LCCOMB_X46_Y38_N24
\ShiftRight0~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~34_combout\ = (!\B[0]~input_o\ & (!\B[2]~input_o\ & (!\B[1]~input_o\ & !\B[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \B[2]~input_o\,
	datac => \B[1]~input_o\,
	datad => \B[3]~input_o\,
	combout => \ShiftRight0~34_combout\);

-- Location: LCCOMB_X52_Y36_N22
\ShiftLeft0~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~10_combout\ = (\B[4]~input_o\) # (!\ShiftRight0~34_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datac => \ShiftRight0~34_combout\,
	combout => \ShiftLeft0~10_combout\);

-- Location: IOIBUF_X78_Y37_N15
\ALUOP[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ALUOP(0),
	o => \ALUOP[0]~input_o\);

-- Location: LCCOMB_X52_Y36_N20
\Mux31~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~13_combout\ = (!\ALUOP[1]~input_o\ & (\A[0]~input_o\ & (!\ShiftLeft0~10_combout\ & !\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \ShiftLeft0~10_combout\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux31~13_combout\);

-- Location: LCCOMB_X52_Y36_N30
\Mux31~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~14_combout\ = (\Mux31~13_combout\) # ((\LessThan0~62_combout\ & (\ALUOP[1]~input_o\ & \ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~62_combout\,
	datab => \Mux31~13_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux31~14_combout\);

-- Location: LCCOMB_X54_Y40_N0
\Mux31~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~6_combout\ = \ALUOP[0]~input_o\ $ (\ALUOP[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	combout => \Mux31~6_combout\);

-- Location: LCCOMB_X51_Y40_N12
\ShiftRight0~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~25_combout\ = (\B[1]~input_o\ & ((\A[18]~input_o\))) # (!\B[1]~input_o\ & (\A[16]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[16]~input_o\,
	datad => \A[18]~input_o\,
	combout => \ShiftRight0~25_combout\);

-- Location: LCCOMB_X51_Y40_N18
\ShiftRight0~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~24_combout\ = (\B[1]~input_o\ & ((\A[19]~input_o\))) # (!\B[1]~input_o\ & (\A[17]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[17]~input_o\,
	datac => \A[19]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~24_combout\);

-- Location: LCCOMB_X51_Y40_N14
\ShiftRight0~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~26_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~24_combout\))) # (!\B[0]~input_o\ & (\ShiftRight0~25_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~25_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight0~24_combout\,
	combout => \ShiftRight0~26_combout\);

-- Location: LCCOMB_X49_Y38_N0
\ShiftRight0~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~30_combout\ = (\B[1]~input_o\ & ((\A[26]~input_o\))) # (!\B[1]~input_o\ & (\A[24]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[24]~input_o\,
	datac => \A[26]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~30_combout\);

-- Location: LCCOMB_X51_Y36_N26
\ShiftRight0~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~29_combout\ = (\B[1]~input_o\ & ((\A[27]~input_o\))) # (!\B[1]~input_o\ & (\A[25]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[1]~input_o\,
	datac => \A[25]~input_o\,
	datad => \A[27]~input_o\,
	combout => \ShiftRight0~29_combout\);

-- Location: LCCOMB_X50_Y40_N2
\ShiftRight0~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~31_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~29_combout\))) # (!\B[0]~input_o\ & (\ShiftRight0~30_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~30_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight0~29_combout\,
	combout => \ShiftRight0~31_combout\);

-- Location: LCCOMB_X45_Y40_N24
\ShiftRight0~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~27_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[29]~input_o\))) # (!\B[0]~input_o\ & (\A[28]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[28]~input_o\,
	datab => \B[0]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[29]~input_o\,
	combout => \ShiftRight0~27_combout\);

-- Location: LCCOMB_X52_Y36_N28
\ShiftRight1~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~18_combout\ = (\B[0]~input_o\ & (\A[31]~input_o\)) # (!\B[0]~input_o\ & ((\A[30]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \A[30]~input_o\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight1~18_combout\);

-- Location: LCCOMB_X49_Y42_N16
\ShiftRight0~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~28_combout\ = (\ShiftRight0~27_combout\) # ((\B[1]~input_o\ & \ShiftRight1~18_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~27_combout\,
	datab => \B[1]~input_o\,
	datac => \ShiftRight1~18_combout\,
	combout => \ShiftRight0~28_combout\);

-- Location: LCCOMB_X52_Y40_N24
\ShiftRight0~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~32_combout\ = (\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftRight0~28_combout\))) # (!\B[2]~input_o\ & (\ShiftRight0~31_combout\)))) # (!\B[3]~input_o\ & (\B[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~31_combout\,
	datad => \ShiftRight0~28_combout\,
	combout => \ShiftRight0~32_combout\);

-- Location: LCCOMB_X49_Y40_N0
\ShiftRight0~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~22_combout\ = (\B[1]~input_o\ & (\A[22]~input_o\)) # (!\B[1]~input_o\ & ((\A[20]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[22]~input_o\,
	datac => \A[20]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~22_combout\);

-- Location: LCCOMB_X51_Y40_N8
\ShiftRight0~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~21_combout\ = (\B[1]~input_o\ & ((\A[23]~input_o\))) # (!\B[1]~input_o\ & (\A[21]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[21]~input_o\,
	datad => \A[23]~input_o\,
	combout => \ShiftRight0~21_combout\);

-- Location: LCCOMB_X52_Y40_N6
\ShiftRight0~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~23_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~21_combout\))) # (!\B[0]~input_o\ & (\ShiftRight0~22_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datac => \ShiftRight0~22_combout\,
	datad => \ShiftRight0~21_combout\,
	combout => \ShiftRight0~23_combout\);

-- Location: LCCOMB_X52_Y40_N2
\ShiftRight0~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~33_combout\ = (\ShiftRight0~32_combout\ & (((\B[3]~input_o\) # (\ShiftRight0~23_combout\)))) # (!\ShiftRight0~32_combout\ & (\ShiftRight0~26_combout\ & (!\B[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~26_combout\,
	datab => \ShiftRight0~32_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~23_combout\,
	combout => \ShiftRight0~33_combout\);

-- Location: LCCOMB_X49_Y39_N10
\ShiftRight1~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~17_combout\ = (\B[0]~input_o\ & (\A[5]~input_o\)) # (!\B[0]~input_o\ & ((\A[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datac => \A[5]~input_o\,
	datad => \A[4]~input_o\,
	combout => \ShiftRight1~17_combout\);

-- Location: LCCOMB_X49_Y39_N16
\ShiftRight0~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~12_combout\ = (\B[1]~input_o\ & ((\B[0]~input_o\ & (\A[7]~input_o\)) # (!\B[0]~input_o\ & ((\A[6]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[6]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~12_combout\);

-- Location: LCCOMB_X49_Y39_N4
\ShiftRight0~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~13_combout\ = (\ShiftRight0~12_combout\) # ((\ShiftRight1~17_combout\ & !\B[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~17_combout\,
	datab => \B[1]~input_o\,
	datad => \ShiftRight0~12_combout\,
	combout => \ShiftRight0~13_combout\);

-- Location: LCCOMB_X49_Y41_N8
\Mux31~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~7_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & (\A[1]~input_o\)) # (!\B[0]~input_o\ & ((\A[0]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[1]~input_o\,
	combout => \Mux31~7_combout\);

-- Location: LCCOMB_X49_Y41_N2
\ShiftRight1~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~16_combout\ = (\B[0]~input_o\ & ((\A[3]~input_o\))) # (!\B[0]~input_o\ & (\A[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[2]~input_o\,
	datab => \B[0]~input_o\,
	datad => \A[3]~input_o\,
	combout => \ShiftRight1~16_combout\);

-- Location: LCCOMB_X49_Y41_N12
\Mux31~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~8_combout\ = (!\B[2]~input_o\ & ((\Mux31~7_combout\) # ((\B[1]~input_o\ & \ShiftRight1~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[2]~input_o\,
	datac => \Mux31~7_combout\,
	datad => \ShiftRight1~16_combout\,
	combout => \Mux31~8_combout\);

-- Location: LCCOMB_X52_Y40_N16
\Mux31~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~9_combout\ = (!\B[3]~input_o\ & ((\Mux31~8_combout\) # ((\B[2]~input_o\ & \ShiftRight0~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~13_combout\,
	datad => \Mux31~8_combout\,
	combout => \Mux31~9_combout\);

-- Location: LCCOMB_X46_Y39_N24
\ShiftRight0~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~17_combout\ = (\B[1]~input_o\ & (\A[11]~input_o\)) # (!\B[1]~input_o\ & ((\A[9]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[11]~input_o\,
	datac => \A[9]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~17_combout\);

-- Location: LCCOMB_X46_Y39_N2
\ShiftRight0~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~18_combout\ = (\B[1]~input_o\ & (\A[10]~input_o\)) # (!\B[1]~input_o\ & ((\A[8]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[10]~input_o\,
	datad => \A[8]~input_o\,
	combout => \ShiftRight0~18_combout\);

-- Location: LCCOMB_X46_Y39_N28
\ShiftRight0~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~19_combout\ = (\B[0]~input_o\ & (\ShiftRight0~17_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~18_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftRight0~17_combout\,
	datad => \ShiftRight0~18_combout\,
	combout => \ShiftRight0~19_combout\);

-- Location: LCCOMB_X51_Y41_N26
\ShiftRight0~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~15_combout\ = (\B[1]~input_o\ & (\A[14]~input_o\)) # (!\B[1]~input_o\ & ((\A[12]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[14]~input_o\,
	datad => \A[12]~input_o\,
	combout => \ShiftRight0~15_combout\);

-- Location: LCCOMB_X51_Y41_N8
\ShiftRight0~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~14_combout\ = (\B[1]~input_o\ & (\A[15]~input_o\)) # (!\B[1]~input_o\ & ((\A[13]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[15]~input_o\,
	datad => \A[13]~input_o\,
	combout => \ShiftRight0~14_combout\);

-- Location: LCCOMB_X51_Y41_N12
\ShiftRight0~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~16_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~14_combout\))) # (!\B[0]~input_o\ & (\ShiftRight0~15_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~15_combout\,
	datab => \ShiftRight0~14_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight0~16_combout\);

-- Location: LCCOMB_X52_Y40_N10
\ShiftRight0~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~20_combout\ = (\B[2]~input_o\ & ((\ShiftRight0~16_combout\))) # (!\B[2]~input_o\ & (\ShiftRight0~19_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~19_combout\,
	datad => \ShiftRight0~16_combout\,
	combout => \ShiftRight0~20_combout\);

-- Location: LCCOMB_X52_Y40_N28
\Mux31~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~10_combout\ = (!\B[4]~input_o\ & ((\Mux31~9_combout\) # ((\B[3]~input_o\ & \ShiftRight0~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \Mux31~9_combout\,
	datac => \B[4]~input_o\,
	datad => \ShiftRight0~20_combout\,
	combout => \Mux31~10_combout\);

-- Location: LCCOMB_X52_Y40_N4
\Mux31~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~11_combout\ = (\Mux31~6_combout\ & ((\Mux31~10_combout\) # ((\ShiftRight0~33_combout\ & \B[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux31~6_combout\,
	datab => \ShiftRight0~33_combout\,
	datac => \B[4]~input_o\,
	datad => \Mux31~10_combout\,
	combout => \Mux31~11_combout\);

-- Location: IOIBUF_X51_Y54_N8
\ALUOP[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ALUOP(2),
	o => \ALUOP[2]~input_o\);

-- Location: LCCOMB_X50_Y40_N8
\Add0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = \B[0]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[0]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~0_combout\);

-- Location: LCCOMB_X51_Y38_N16
\Add0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~2_cout\ = CARRY(\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datad => VCC,
	cout => \Add0~2_cout\);

-- Location: LCCOMB_X51_Y38_N18
\Add0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~3_combout\ = (\A[0]~input_o\ & ((\Add0~0_combout\ & (\Add0~2_cout\ & VCC)) # (!\Add0~0_combout\ & (!\Add0~2_cout\)))) # (!\A[0]~input_o\ & ((\Add0~0_combout\ & (!\Add0~2_cout\)) # (!\Add0~0_combout\ & ((\Add0~2_cout\) # (GND)))))
-- \Add0~4\ = CARRY((\A[0]~input_o\ & (!\Add0~0_combout\ & !\Add0~2_cout\)) # (!\A[0]~input_o\ & ((!\Add0~2_cout\) # (!\Add0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[0]~input_o\,
	datab => \Add0~0_combout\,
	datad => VCC,
	cin => \Add0~2_cout\,
	combout => \Add0~3_combout\,
	cout => \Add0~4\);

-- Location: LCCOMB_X52_Y36_N0
\Mux31~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~4_combout\ = (!\ALUOP[1]~input_o\ & ((\A[0]~input_o\ & ((\B[0]~input_o\) # (\ALUOP[0]~input_o\))) # (!\A[0]~input_o\ & (\B[0]~input_o\ & \ALUOP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux31~4_combout\);

-- Location: LCCOMB_X52_Y36_N10
\Mux31~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~5_combout\ = (!\ALUOP[2]~input_o\ & ((\Mux31~4_combout\) # ((\Add0~3_combout\ & \ALUOP[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~3_combout\,
	datab => \ALUOP[2]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \Mux31~4_combout\,
	combout => \Mux31~5_combout\);

-- Location: LCCOMB_X52_Y36_N16
\Mux31~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux31~12_combout\ = (\Mux31~5_combout\) # ((\ALUOP[2]~input_o\ & ((\Mux31~14_combout\) # (\Mux31~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux31~14_combout\,
	datab => \Mux31~11_combout\,
	datac => \ALUOP[2]~input_o\,
	datad => \Mux31~5_combout\,
	combout => \Mux31~12_combout\);

-- Location: LCCOMB_X49_Y40_N12
\ShiftRight1~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~20_combout\ = (\B[1]~input_o\ & (\A[20]~input_o\)) # (!\B[1]~input_o\ & ((\A[18]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[20]~input_o\,
	datad => \A[18]~input_o\,
	combout => \ShiftRight1~20_combout\);

-- Location: LCCOMB_X50_Y40_N14
\ShiftRight0~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~37_combout\ = (\B[0]~input_o\ & (\ShiftRight1~20_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~24_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~20_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight0~24_combout\,
	combout => \ShiftRight0~37_combout\);

-- Location: LCCOMB_X49_Y40_N2
\ShiftRight1~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~19_combout\ = (\B[1]~input_o\ & ((\A[24]~input_o\))) # (!\B[1]~input_o\ & (\A[22]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[22]~input_o\,
	datad => \A[24]~input_o\,
	combout => \ShiftRight1~19_combout\);

-- Location: LCCOMB_X50_Y40_N12
\ShiftRight0~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~36_combout\ = (\B[0]~input_o\ & (\ShiftRight1~19_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~21_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~19_combout\,
	datab => \ShiftRight0~21_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight0~36_combout\);

-- Location: LCCOMB_X50_Y40_N22
\ShiftRight0~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~46_combout\ = (\B[2]~input_o\ & (((\B[3]~input_o\) # (\ShiftRight0~36_combout\)))) # (!\B[2]~input_o\ & (\ShiftRight0~37_combout\ & (!\B[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftRight0~37_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~36_combout\,
	combout => \ShiftRight0~46_combout\);

-- Location: LCCOMB_X45_Y40_N20
\ShiftRight1~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~22_combout\ = (\B[0]~input_o\ & (\A[30]~input_o\)) # (!\B[0]~input_o\ & ((\A[29]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \B[0]~input_o\,
	datad => \A[29]~input_o\,
	combout => \ShiftRight1~22_combout\);

-- Location: LCCOMB_X45_Y40_N30
\ShiftRight0~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~44_combout\ = (\B[1]~input_o\ & (((!\B[0]~input_o\ & \A[31]~input_o\)))) # (!\B[1]~input_o\ & (\ShiftRight1~22_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~22_combout\,
	datab => \B[0]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[31]~input_o\,
	combout => \ShiftRight0~44_combout\);

-- Location: LCCOMB_X45_Y40_N18
\ShiftRight1~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~21_combout\ = (\B[1]~input_o\ & (\A[28]~input_o\)) # (!\B[1]~input_o\ & ((\A[26]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[28]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[26]~input_o\,
	combout => \ShiftRight1~21_combout\);

-- Location: LCCOMB_X50_Y40_N28
\ShiftRight0~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~45_combout\ = (\B[0]~input_o\ & (\ShiftRight1~21_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~29_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~21_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight0~29_combout\,
	combout => \ShiftRight0~45_combout\);

-- Location: LCCOMB_X47_Y38_N22
\ShiftRight0~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~47_combout\ = (\ShiftRight0~46_combout\ & (((\ShiftRight0~44_combout\)) # (!\B[3]~input_o\))) # (!\ShiftRight0~46_combout\ & (\B[3]~input_o\ & ((\ShiftRight0~45_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~46_combout\,
	datab => \B[3]~input_o\,
	datac => \ShiftRight0~44_combout\,
	datad => \ShiftRight0~45_combout\,
	combout => \ShiftRight0~47_combout\);

-- Location: LCCOMB_X47_Y38_N16
\Mux30~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~9_combout\ = (\B[4]~input_o\ & (\ALUOP[0]~input_o\ & (\ALUOP[2]~input_o\ & !\ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[2]~input_o\,
	datad => \ALUOP[1]~input_o\,
	combout => \Mux30~9_combout\);

-- Location: LCCOMB_X46_Y38_N26
\Mux30~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~0_combout\ = (!\ALUOP[1]~input_o\ & ((\B[1]~input_o\ & ((\ALUOP[0]~input_o\) # (\A[1]~input_o\))) # (!\B[1]~input_o\ & (\ALUOP[0]~input_o\ & \A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datac => \ALUOP[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \Mux30~0_combout\);

-- Location: LCCOMB_X51_Y38_N8
\Add0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~5_combout\ = \B[1]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~5_combout\);

-- Location: LCCOMB_X51_Y38_N20
\Add0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~6_combout\ = ((\Add0~5_combout\ $ (\A[1]~input_o\ $ (!\Add0~4\)))) # (GND)
-- \Add0~7\ = CARRY((\Add0~5_combout\ & ((\A[1]~input_o\) # (!\Add0~4\))) # (!\Add0~5_combout\ & (\A[1]~input_o\ & !\Add0~4\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~5_combout\,
	datab => \A[1]~input_o\,
	datad => VCC,
	cin => \Add0~4\,
	combout => \Add0~6_combout\,
	cout => \Add0~7\);

-- Location: LCCOMB_X46_Y38_N12
\Mux30~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~1_combout\ = (!\ALUOP[2]~input_o\ & ((\Mux30~0_combout\) # ((\Add0~6_combout\ & \ALUOP[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux30~0_combout\,
	datab => \Add0~6_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux30~1_combout\);

-- Location: LCCOMB_X49_Y41_N6
\ShiftLeft0~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~11_combout\ = (\B[0]~input_o\ & (\A[0]~input_o\)) # (!\B[0]~input_o\ & ((\A[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \ShiftLeft0~11_combout\);

-- Location: LCCOMB_X47_Y38_N6
\ShiftLeft0~102\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~102_combout\ = (!\B[2]~input_o\ & (\ShiftLeft0~11_combout\ & (!\B[3]~input_o\ & !\B[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~11_combout\,
	datac => \B[3]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~102_combout\);

-- Location: LCCOMB_X50_Y36_N8
\Mux3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (\ALUOP[2]~input_o\ & !\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux3~0_combout\);

-- Location: LCCOMB_X47_Y38_N24
\Mux30~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~2_combout\ = (\ShiftLeft0~102_combout\ & (\Mux3~0_combout\ & (!\ALUOP[1]~input_o\ & !\B[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~102_combout\,
	datab => \Mux3~0_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux30~2_combout\);

-- Location: LCCOMB_X47_Y38_N26
\Mux3~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~1_combout\ = (\B[4]~input_o\ & (!\ALUOP[0]~input_o\ & (\ALUOP[2]~input_o\ & \ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[2]~input_o\,
	datad => \ALUOP[1]~input_o\,
	combout => \Mux3~1_combout\);

-- Location: LCCOMB_X50_Y40_N18
\ShiftRight0~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~38_combout\ = (!\B[2]~input_o\ & ((\B[0]~input_o\ & (\ShiftRight1~21_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~29_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~21_combout\,
	datab => \ShiftRight0~29_combout\,
	datac => \B[0]~input_o\,
	datad => \B[2]~input_o\,
	combout => \ShiftRight0~38_combout\);

-- Location: LCCOMB_X49_Y38_N2
\ShiftRight1~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~23_combout\ = (\B[2]~input_o\ & ((\B[1]~input_o\ & ((\A[31]~input_o\))) # (!\B[1]~input_o\ & (\ShiftRight1~22_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~22_combout\,
	datab => \A[31]~input_o\,
	datac => \B[2]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight1~23_combout\);

-- Location: LCCOMB_X50_Y40_N24
\Mux22~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~0_combout\ = (\B[2]~input_o\ & ((\ShiftRight0~36_combout\))) # (!\B[2]~input_o\ & (\ShiftRight0~37_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \ShiftRight0~37_combout\,
	datad => \ShiftRight0~36_combout\,
	combout => \Mux22~0_combout\);

-- Location: LCCOMB_X49_Y38_N28
\ShiftRight1~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~24_combout\ = (\B[3]~input_o\ & ((\ShiftRight0~38_combout\) # ((\ShiftRight1~23_combout\)))) # (!\B[3]~input_o\ & (((\Mux22~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~38_combout\,
	datab => \ShiftRight1~23_combout\,
	datac => \B[3]~input_o\,
	datad => \Mux22~0_combout\,
	combout => \ShiftRight1~24_combout\);

-- Location: LCCOMB_X47_Y38_N4
\Mux30~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~3_combout\ = (\Mux30~1_combout\) # ((\Mux30~2_combout\) # ((\Mux3~1_combout\ & \ShiftRight1~24_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux30~1_combout\,
	datab => \Mux30~2_combout\,
	datac => \Mux3~1_combout\,
	datad => \ShiftRight1~24_combout\,
	combout => \Mux30~3_combout\);

-- Location: LCCOMB_X47_Y38_N30
\Mux30~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~4_combout\ = (!\B[4]~input_o\ & (\ALUOP[2]~input_o\ & (\ALUOP[0]~input_o\ $ (\ALUOP[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[2]~input_o\,
	datad => \ALUOP[1]~input_o\,
	combout => \Mux30~4_combout\);

-- Location: LCCOMB_X49_Y39_N6
\ShiftRight0~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~39_combout\ = (\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[8]~input_o\))) # (!\B[0]~input_o\ & (\A[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[1]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[8]~input_o\,
	combout => \ShiftRight0~39_combout\);

-- Location: LCCOMB_X49_Y39_N8
\ShiftRight1~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~26_combout\ = (\B[0]~input_o\ & (\A[6]~input_o\)) # (!\B[0]~input_o\ & ((\A[5]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[5]~input_o\,
	combout => \ShiftRight1~26_combout\);

-- Location: LCCOMB_X49_Y39_N2
\ShiftRight0~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~40_combout\ = (\ShiftRight0~39_combout\) # ((!\B[1]~input_o\ & \ShiftRight1~26_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~39_combout\,
	datab => \B[1]~input_o\,
	datad => \ShiftRight1~26_combout\,
	combout => \ShiftRight0~40_combout\);

-- Location: LCCOMB_X51_Y38_N2
\Mux30~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~5_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[2]~input_o\))) # (!\B[0]~input_o\ & (\A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[1]~input_o\,
	datac => \A[2]~input_o\,
	datad => \B[1]~input_o\,
	combout => \Mux30~5_combout\);

-- Location: LCCOMB_X51_Y38_N12
\ShiftRight1~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~25_combout\ = (\B[0]~input_o\ & (\A[4]~input_o\)) # (!\B[0]~input_o\ & ((\A[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[4]~input_o\,
	datad => \A[3]~input_o\,
	combout => \ShiftRight1~25_combout\);

-- Location: LCCOMB_X51_Y38_N6
\Mux30~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~6_combout\ = (!\B[2]~input_o\ & ((\Mux30~5_combout\) # ((\B[1]~input_o\ & \ShiftRight1~25_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \Mux30~5_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~25_combout\,
	combout => \Mux30~6_combout\);

-- Location: LCCOMB_X47_Y38_N0
\Mux30~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~7_combout\ = (!\B[3]~input_o\ & ((\Mux30~6_combout\) # ((\ShiftRight0~40_combout\ & \B[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~40_combout\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \Mux30~6_combout\,
	combout => \Mux30~7_combout\);

-- Location: LCCOMB_X51_Y41_N22
\ShiftRight1~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~27_combout\ = (\B[1]~input_o\ & ((\A[16]~input_o\))) # (!\B[1]~input_o\ & (\A[14]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[14]~input_o\,
	datad => \A[16]~input_o\,
	combout => \ShiftRight1~27_combout\);

-- Location: LCCOMB_X51_Y41_N24
\ShiftRight0~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~41_combout\ = (\B[0]~input_o\ & (\ShiftRight1~27_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~27_combout\,
	datab => \ShiftRight0~14_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight0~41_combout\);

-- Location: LCCOMB_X46_Y39_N30
\ShiftRight1~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~28_combout\ = (\B[1]~input_o\ & ((\A[12]~input_o\))) # (!\B[1]~input_o\ & (\A[10]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[10]~input_o\,
	datac => \A[12]~input_o\,
	combout => \ShiftRight1~28_combout\);

-- Location: LCCOMB_X46_Y39_N8
\ShiftRight0~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~42_combout\ = (\B[0]~input_o\ & ((\ShiftRight1~28_combout\))) # (!\B[0]~input_o\ & (\ShiftRight0~17_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftRight0~17_combout\,
	datac => \ShiftRight1~28_combout\,
	combout => \ShiftRight0~42_combout\);

-- Location: LCCOMB_X47_Y38_N10
\ShiftRight0~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~43_combout\ = (\B[2]~input_o\ & (\ShiftRight0~41_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~42_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~41_combout\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~42_combout\,
	combout => \ShiftRight0~43_combout\);

-- Location: LCCOMB_X47_Y38_N20
\Mux30~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~8_combout\ = (\Mux30~4_combout\ & ((\Mux30~7_combout\) # ((\B[3]~input_o\ & \ShiftRight0~43_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux30~4_combout\,
	datab => \Mux30~7_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~43_combout\,
	combout => \Mux30~8_combout\);

-- Location: LCCOMB_X47_Y38_N2
\Mux30~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux30~10_combout\ = (\Mux30~3_combout\) # ((\Mux30~8_combout\) # ((\ShiftRight0~47_combout\ & \Mux30~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~47_combout\,
	datab => \Mux30~9_combout\,
	datac => \Mux30~3_combout\,
	datad => \Mux30~8_combout\,
	combout => \Mux30~10_combout\);

-- Location: LCCOMB_X54_Y40_N20
\Mux28~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~5_combout\ = (\ALUOP[2]~input_o\) # ((\ALUOP[0]~input_o\ & !\ALUOP[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	combout => \Mux28~5_combout\);

-- Location: LCCOMB_X54_Y40_N26
\Mux28~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~4_combout\ = (\ALUOP[1]~input_o\) # (\ALUOP[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux28~4_combout\);

-- Location: LCCOMB_X52_Y38_N22
\Mux29~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~5_combout\ = (\Mux28~5_combout\ & ((\B[2]~input_o\) # ((\Mux28~4_combout\) # (\A[2]~input_o\)))) # (!\Mux28~5_combout\ & (\B[2]~input_o\ & (!\Mux28~4_combout\ & \A[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \B[2]~input_o\,
	datac => \Mux28~4_combout\,
	datad => \A[2]~input_o\,
	combout => \Mux29~5_combout\);

-- Location: LCCOMB_X51_Y38_N0
\Add0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~8_combout\ = \B[2]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[2]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~8_combout\);

-- Location: LCCOMB_X51_Y38_N22
\Add0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~9_combout\ = (\Add0~8_combout\ & ((\A[2]~input_o\ & (\Add0~7\ & VCC)) # (!\A[2]~input_o\ & (!\Add0~7\)))) # (!\Add0~8_combout\ & ((\A[2]~input_o\ & (!\Add0~7\)) # (!\A[2]~input_o\ & ((\Add0~7\) # (GND)))))
-- \Add0~10\ = CARRY((\Add0~8_combout\ & (!\A[2]~input_o\ & !\Add0~7\)) # (!\Add0~8_combout\ & ((!\Add0~7\) # (!\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~8_combout\,
	datab => \A[2]~input_o\,
	datad => VCC,
	cin => \Add0~7\,
	combout => \Add0~9_combout\,
	cout => \Add0~10\);

-- Location: LCCOMB_X50_Y41_N10
\Mux28~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~2_combout\ = (\ALUOP[1]~input_o\) # ((!\B[4]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[1]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux28~2_combout\);

-- Location: LCCOMB_X51_Y40_N24
\ShiftRight1~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~33_combout\ = (\B[1]~input_o\ & ((\A[21]~input_o\))) # (!\B[1]~input_o\ & (\A[19]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[19]~input_o\,
	datad => \A[21]~input_o\,
	combout => \ShiftRight1~33_combout\);

-- Location: LCCOMB_X50_Y40_N10
\ShiftRight1~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~34_combout\ = (\B[0]~input_o\ & ((\ShiftRight1~33_combout\))) # (!\B[0]~input_o\ & (\ShiftRight1~20_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~20_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight1~33_combout\,
	combout => \ShiftRight1~34_combout\);

-- Location: LCCOMB_X49_Y40_N14
\ShiftRight1~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~31_combout\ = (\B[1]~input_o\ & (\A[25]~input_o\)) # (!\B[1]~input_o\ & ((\A[23]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[25]~input_o\,
	datad => \A[23]~input_o\,
	combout => \ShiftRight1~31_combout\);

-- Location: LCCOMB_X50_Y40_N16
\ShiftRight1~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~32_combout\ = (\B[0]~input_o\ & (\ShiftRight1~31_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight1~19_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~31_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight1~19_combout\,
	combout => \ShiftRight1~32_combout\);

-- Location: LCCOMB_X49_Y37_N22
\Mux21~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~2_combout\ = (\B[2]~input_o\ & ((\ShiftRight1~32_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~34_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftRight1~34_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~32_combout\,
	combout => \Mux21~2_combout\);

-- Location: LCCOMB_X45_Y40_N28
\ShiftRight1~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~35_combout\ = (\B[1]~input_o\ & (((\A[31]~input_o\)))) # (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[31]~input_o\))) # (!\B[0]~input_o\ & (\A[30]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \A[31]~input_o\,
	datac => \B[1]~input_o\,
	datad => \B[0]~input_o\,
	combout => \ShiftRight1~35_combout\);

-- Location: LCCOMB_X45_Y40_N8
\ShiftRight1~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~29_combout\ = (\B[0]~input_o\ & ((\B[1]~input_o\ & ((\A[29]~input_o\))) # (!\B[1]~input_o\ & (\A[27]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \B[1]~input_o\,
	datac => \A[27]~input_o\,
	datad => \A[29]~input_o\,
	combout => \ShiftRight1~29_combout\);

-- Location: LCCOMB_X45_Y40_N10
\ShiftRight1~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~30_combout\ = (\ShiftRight1~29_combout\) # ((!\B[0]~input_o\ & \ShiftRight1~21_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datac => \ShiftRight1~29_combout\,
	datad => \ShiftRight1~21_combout\,
	combout => \ShiftRight1~30_combout\);

-- Location: LCCOMB_X45_Y40_N6
\ShiftRight1~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~36_combout\ = (\B[2]~input_o\ & (\ShiftRight1~35_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight1~30_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftRight1~35_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~30_combout\,
	combout => \ShiftRight1~36_combout\);

-- Location: LCCOMB_X52_Y38_N24
\Mux29~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~0_combout\ = (!\ALUOP[0]~input_o\ & ((\B[3]~input_o\ & ((\ShiftRight1~36_combout\))) # (!\B[3]~input_o\ & (\Mux21~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux21~2_combout\,
	datab => \B[3]~input_o\,
	datac => \ALUOP[0]~input_o\,
	datad => \ShiftRight1~36_combout\,
	combout => \Mux29~0_combout\);

-- Location: LCCOMB_X49_Y37_N0
\Mux28~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~1_combout\ = (\B[3]~input_o\) # ((\B[1]~input_o\ & !\B[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \B[2]~input_o\,
	datad => \B[3]~input_o\,
	combout => \Mux28~1_combout\);

-- Location: LCCOMB_X46_Y39_N18
\ShiftRight1~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~42_combout\ = (\B[1]~input_o\ & ((\A[13]~input_o\))) # (!\B[1]~input_o\ & (\A[11]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[11]~input_o\,
	datab => \A[13]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight1~42_combout\);

-- Location: LCCOMB_X46_Y39_N4
\ShiftRight1~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~43_combout\ = (\B[0]~input_o\ & (\ShiftRight1~42_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight1~28_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftRight1~42_combout\,
	datac => \ShiftRight1~28_combout\,
	combout => \ShiftRight1~43_combout\);

-- Location: LCCOMB_X51_Y40_N2
\ShiftRight1~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~40_combout\ = (\B[1]~input_o\ & (\A[17]~input_o\)) # (!\B[1]~input_o\ & ((\A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[17]~input_o\,
	datad => \A[15]~input_o\,
	combout => \ShiftRight1~40_combout\);

-- Location: LCCOMB_X51_Y41_N18
\ShiftRight1~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~41_combout\ = (\B[0]~input_o\ & ((\ShiftRight1~40_combout\))) # (!\B[0]~input_o\ & (\ShiftRight1~27_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~27_combout\,
	datab => \ShiftRight1~40_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight1~41_combout\);

-- Location: LCCOMB_X50_Y41_N14
\ShiftRight0~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~51_combout\ = (\B[2]~input_o\ & ((\ShiftRight1~41_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~43_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~43_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~41_combout\,
	combout => \ShiftRight0~51_combout\);

-- Location: LCCOMB_X49_Y39_N30
\ShiftRight1~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~38_combout\ = (\B[1]~input_o\ & ((\A[9]~input_o\))) # (!\B[1]~input_o\ & (\A[7]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[1]~input_o\,
	datad => \A[9]~input_o\,
	combout => \ShiftRight1~38_combout\);

-- Location: LCCOMB_X49_Y39_N20
\ShiftRight1~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~37_combout\ = (!\B[0]~input_o\ & ((\B[1]~input_o\ & ((\A[8]~input_o\))) # (!\B[1]~input_o\ & (\A[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \B[1]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[8]~input_o\,
	combout => \ShiftRight1~37_combout\);

-- Location: LCCOMB_X49_Y39_N0
\ShiftRight1~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~39_combout\ = (\ShiftRight1~37_combout\) # ((\ShiftRight1~38_combout\ & \B[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~38_combout\,
	datab => \ShiftRight1~37_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight1~39_combout\);

-- Location: LCCOMB_X50_Y41_N0
\ShiftRight0~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~35_combout\ = (!\B[2]~input_o\ & !\B[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[2]~input_o\,
	datad => \B[3]~input_o\,
	combout => \ShiftRight0~35_combout\);

-- Location: LCCOMB_X50_Y41_N20
\Mux29~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~1_combout\ = (\ShiftRight0~35_combout\ & (((!\Mux28~1_combout\ & \ShiftRight1~16_combout\)))) # (!\ShiftRight0~35_combout\ & ((\ShiftRight1~39_combout\) # ((\Mux28~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~39_combout\,
	datab => \ShiftRight0~35_combout\,
	datac => \Mux28~1_combout\,
	datad => \ShiftRight1~16_combout\,
	combout => \Mux29~1_combout\);

-- Location: LCCOMB_X50_Y41_N16
\Mux29~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~2_combout\ = (\Mux28~1_combout\ & ((\Mux29~1_combout\ & ((\ShiftRight0~51_combout\))) # (!\Mux29~1_combout\ & (\ShiftRight1~17_combout\)))) # (!\Mux28~1_combout\ & (((\Mux29~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~17_combout\,
	datab => \Mux28~1_combout\,
	datac => \ShiftRight0~51_combout\,
	datad => \Mux29~1_combout\,
	combout => \Mux29~2_combout\);

-- Location: LCCOMB_X50_Y41_N28
\Mux28~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~3_combout\ = (\ALUOP[1]~input_o\ & (!\B[4]~input_o\ & !\ALUOP[0]~input_o\)) # (!\ALUOP[1]~input_o\ & ((\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[1]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux28~3_combout\);

-- Location: LCCOMB_X52_Y38_N26
\Mux29~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~3_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & ((\Mux29~2_combout\))) # (!\Mux28~3_combout\ & (\Mux29~0_combout\)))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~2_combout\,
	datab => \Mux29~0_combout\,
	datac => \Mux29~2_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux29~3_combout\);

-- Location: LCCOMB_X50_Y41_N2
\Mux28~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~0_combout\ = (!\ALUOP[1]~input_o\ & (\B[4]~input_o\ $ (!\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[1]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux28~0_combout\);

-- Location: LCCOMB_X49_Y37_N10
\ShiftRight0~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~49_combout\ = (!\B[1]~input_o\ & (\B[3]~input_o\ & (\B[2]~input_o\ & \ShiftRight1~18_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~18_combout\,
	combout => \ShiftRight0~49_combout\);

-- Location: LCCOMB_X49_Y37_N24
\ShiftRight0~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~48_combout\ = (\B[3]~input_o\ & (\ShiftRight1~30_combout\ & (!\B[2]~input_o\))) # (!\B[3]~input_o\ & (((\B[2]~input_o\ & \ShiftRight1~32_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~30_combout\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~32_combout\,
	combout => \ShiftRight0~48_combout\);

-- Location: LCCOMB_X49_Y37_N4
\ShiftRight0~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~50_combout\ = (\ShiftRight0~49_combout\) # ((\ShiftRight0~48_combout\) # ((\ShiftRight1~34_combout\ & \ShiftRight0~35_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~49_combout\,
	datab => \ShiftRight0~48_combout\,
	datac => \ShiftRight1~34_combout\,
	datad => \ShiftRight0~35_combout\,
	combout => \ShiftRight0~50_combout\);

-- Location: LCCOMB_X49_Y41_N16
\ShiftLeft0~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~12_combout\ = (!\B[0]~input_o\ & ((\B[1]~input_o\ & ((\A[0]~input_o\))) # (!\B[1]~input_o\ & (\A[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[2]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~12_combout\);

-- Location: LCCOMB_X49_Y41_N26
\ShiftLeft0~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~13_combout\ = (\ShiftLeft0~12_combout\) # ((\A[1]~input_o\ & (!\B[1]~input_o\ & \B[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datab => \B[1]~input_o\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~12_combout\,
	combout => \ShiftLeft0~13_combout\);

-- Location: LCCOMB_X52_Y38_N0
\ShiftLeft0~103\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~103_combout\ = (!\B[2]~input_o\ & (!\B[3]~input_o\ & \ShiftLeft0~13_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~13_combout\,
	combout => \ShiftLeft0~103_combout\);

-- Location: LCCOMB_X52_Y38_N20
\Mux29~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~4_combout\ = (\Mux29~3_combout\ & (((\ShiftRight0~50_combout\)) # (!\Mux28~0_combout\))) # (!\Mux29~3_combout\ & (\Mux28~0_combout\ & ((\ShiftLeft0~103_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux29~3_combout\,
	datab => \Mux28~0_combout\,
	datac => \ShiftRight0~50_combout\,
	datad => \ShiftLeft0~103_combout\,
	combout => \Mux29~4_combout\);

-- Location: LCCOMB_X52_Y38_N8
\Mux29~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux29~6_combout\ = (\Mux29~5_combout\ & (((\Mux29~4_combout\) # (!\Mux28~4_combout\)))) # (!\Mux29~5_combout\ & (\Add0~9_combout\ & (\Mux28~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux29~5_combout\,
	datab => \Add0~9_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux29~4_combout\,
	combout => \Mux29~6_combout\);

-- Location: LCCOMB_X49_Y38_N6
\Mux28~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~11_combout\ = (\Mux28~4_combout\ & (((\Mux28~5_combout\)))) # (!\Mux28~4_combout\ & ((\A[3]~input_o\ & ((\B[3]~input_o\) # (\Mux28~5_combout\))) # (!\A[3]~input_o\ & (\B[3]~input_o\ & \Mux28~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~4_combout\,
	datab => \A[3]~input_o\,
	datac => \B[3]~input_o\,
	datad => \Mux28~5_combout\,
	combout => \Mux28~11_combout\);

-- Location: LCCOMB_X50_Y37_N16
\Add0~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~11_combout\ = \B[3]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~11_combout\);

-- Location: LCCOMB_X51_Y38_N24
\Add0~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~12_combout\ = ((\A[3]~input_o\ $ (\Add0~11_combout\ $ (!\Add0~10\)))) # (GND)
-- \Add0~13\ = CARRY((\A[3]~input_o\ & ((\Add0~11_combout\) # (!\Add0~10\))) # (!\A[3]~input_o\ & (\Add0~11_combout\ & !\Add0~10\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \Add0~11_combout\,
	datad => VCC,
	cin => \Add0~10\,
	combout => \Add0~12_combout\,
	cout => \Add0~13\);

-- Location: LCCOMB_X46_Y38_N14
\ShiftLeft0~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~16_combout\ = (!\B[1]~input_o\ & !\B[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[1]~input_o\,
	datad => \B[0]~input_o\,
	combout => \ShiftLeft0~16_combout\);

-- Location: LCCOMB_X51_Y39_N16
\ShiftRight0~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~52_combout\ = (\B[3]~input_o\ & \A[31]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \A[31]~input_o\,
	combout => \ShiftRight0~52_combout\);

-- Location: LCCOMB_X50_Y40_N20
\ShiftRight1~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~44_combout\ = (\B[0]~input_o\ & (\ShiftRight0~22_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight1~33_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~22_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight1~33_combout\,
	combout => \ShiftRight1~44_combout\);

-- Location: LCCOMB_X50_Y40_N30
\ShiftRight1~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~45_combout\ = (\B[0]~input_o\ & (\ShiftRight0~30_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight1~31_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~30_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight1~31_combout\,
	combout => \ShiftRight1~45_combout\);

-- Location: LCCOMB_X51_Y39_N26
\ShiftRight0~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~53_combout\ = (\B[3]~input_o\) # ((\B[2]~input_o\ & ((!\ShiftRight1~45_combout\))) # (!\B[2]~input_o\ & (!\ShiftRight1~44_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~44_combout\,
	datab => \B[3]~input_o\,
	datac => \ShiftRight1~45_combout\,
	datad => \B[2]~input_o\,
	combout => \ShiftRight0~53_combout\);

-- Location: LCCOMB_X45_Y40_N0
\ShiftRight1~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~46_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & (\A[28]~input_o\)) # (!\B[0]~input_o\ & ((\A[27]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[28]~input_o\,
	datab => \B[1]~input_o\,
	datac => \A[27]~input_o\,
	datad => \B[0]~input_o\,
	combout => \ShiftRight1~46_combout\);

-- Location: LCCOMB_X45_Y40_N2
\ShiftRight1~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~47_combout\ = (\ShiftRight1~46_combout\) # ((\B[1]~input_o\ & \ShiftRight1~22_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftRight1~46_combout\,
	datac => \B[1]~input_o\,
	datad => \ShiftRight1~22_combout\,
	combout => \ShiftRight1~47_combout\);

-- Location: LCCOMB_X51_Y39_N6
\ShiftRight0~73\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~73_combout\ = (\ShiftRight0~53_combout\ & ((\B[2]~input_o\) # ((!\ShiftRight1~47_combout\) # (!\B[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~53_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight1~47_combout\,
	combout => \ShiftRight0~73_combout\);

-- Location: LCCOMB_X51_Y39_N20
\ShiftRight0~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~54_combout\ = ((\ShiftLeft0~16_combout\ & (\ShiftRight0~52_combout\ & \B[2]~input_o\))) # (!\ShiftRight0~73_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~16_combout\,
	datab => \ShiftRight0~52_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight0~73_combout\,
	combout => \ShiftRight0~54_combout\);

-- Location: LCCOMB_X49_Y41_N20
\ShiftLeft0~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~14_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[2]~input_o\))) # (!\B[0]~input_o\ & (\A[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[0]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[2]~input_o\,
	combout => \ShiftLeft0~14_combout\);

-- Location: LCCOMB_X50_Y39_N24
\ShiftLeft0~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~15_combout\ = (\ShiftRight0~35_combout\ & ((\ShiftLeft0~14_combout\) # ((\B[1]~input_o\ & \ShiftLeft0~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~14_combout\,
	datab => \B[1]~input_o\,
	datac => \ShiftLeft0~11_combout\,
	datad => \ShiftRight0~35_combout\,
	combout => \ShiftLeft0~15_combout\);

-- Location: LCCOMB_X46_Y39_N14
\ShiftRight1~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~50_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~15_combout\))) # (!\B[0]~input_o\ & (\ShiftRight1~42_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftRight1~42_combout\,
	datad => \ShiftRight0~15_combout\,
	combout => \ShiftRight1~50_combout\);

-- Location: LCCOMB_X51_Y40_N28
\ShiftRight1~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~49_combout\ = (\B[0]~input_o\ & (\ShiftRight0~25_combout\)) # (!\B[0]~input_o\ & ((\ShiftRight1~40_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~25_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftRight1~40_combout\,
	combout => \ShiftRight1~49_combout\);

-- Location: LCCOMB_X50_Y39_N28
\ShiftRight0~55\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~55_combout\ = (\B[2]~input_o\ & ((\ShiftRight1~49_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~50_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~50_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~49_combout\,
	combout => \ShiftRight0~55_combout\);

-- Location: LCCOMB_X49_Y39_N18
\ShiftRight1~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~48_combout\ = (\B[0]~input_o\ & ((\ShiftRight0~18_combout\))) # (!\B[0]~input_o\ & (\ShiftRight1~38_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~38_combout\,
	datab => \ShiftRight0~18_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftRight1~48_combout\);

-- Location: LCCOMB_X50_Y39_N26
\Mux28~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~7_combout\ = (\Mux28~1_combout\ & (((!\ShiftRight0~35_combout\)))) # (!\Mux28~1_combout\ & ((\ShiftRight0~35_combout\ & (\ShiftRight1~25_combout\)) # (!\ShiftRight0~35_combout\ & ((\ShiftRight1~48_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~25_combout\,
	datab => \ShiftRight1~48_combout\,
	datac => \Mux28~1_combout\,
	datad => \ShiftRight0~35_combout\,
	combout => \Mux28~7_combout\);

-- Location: LCCOMB_X50_Y39_N22
\Mux28~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~8_combout\ = (\Mux28~1_combout\ & ((\Mux28~7_combout\ & (\ShiftRight0~55_combout\)) # (!\Mux28~7_combout\ & ((\ShiftRight1~26_combout\))))) # (!\Mux28~1_combout\ & (((\Mux28~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~1_combout\,
	datab => \ShiftRight0~55_combout\,
	datac => \Mux28~7_combout\,
	datad => \ShiftRight1~26_combout\,
	combout => \Mux28~8_combout\);

-- Location: LCCOMB_X51_Y39_N30
\Mux28~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~6_combout\ = (!\ALUOP[0]~input_o\ & (((\ShiftRight0~52_combout\ & \B[2]~input_o\)) # (!\ShiftRight0~73_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~73_combout\,
	datab => \ShiftRight0~52_combout\,
	datac => \B[2]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux28~6_combout\);

-- Location: LCCOMB_X50_Y39_N16
\Mux28~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~9_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & (\Mux28~8_combout\)) # (!\Mux28~3_combout\ & ((\Mux28~6_combout\))))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~8_combout\,
	datab => \Mux28~2_combout\,
	datac => \Mux28~6_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux28~9_combout\);

-- Location: LCCOMB_X50_Y39_N18
\Mux28~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~10_combout\ = (\Mux28~0_combout\ & ((\Mux28~9_combout\ & (\ShiftRight0~54_combout\)) # (!\Mux28~9_combout\ & ((\ShiftLeft0~15_combout\))))) # (!\Mux28~0_combout\ & (((\Mux28~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~54_combout\,
	datab => \ShiftLeft0~15_combout\,
	datac => \Mux28~0_combout\,
	datad => \Mux28~9_combout\,
	combout => \Mux28~10_combout\);

-- Location: LCCOMB_X49_Y38_N16
\Mux28~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux28~12_combout\ = (\Mux28~11_combout\ & (((\Mux28~10_combout\) # (!\Mux28~4_combout\)))) # (!\Mux28~11_combout\ & (\Add0~12_combout\ & ((\Mux28~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~11_combout\,
	datab => \Add0~12_combout\,
	datac => \Mux28~10_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux28~12_combout\);

-- Location: LCCOMB_X47_Y41_N6
\Mux25~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~6_combout\ = (\ALUOP[1]~input_o\) # (((!\B[4]~input_o\ & \ALUOP[0]~input_o\)) # (!\ALUOP[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datac => \ALUOP[2]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux25~6_combout\);

-- Location: LCCOMB_X47_Y41_N0
\Mux25~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~7_combout\ = (\ALUOP[2]~input_o\ & ((\ALUOP[1]~input_o\) # (\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux25~7_combout\);

-- Location: LCCOMB_X52_Y40_N22
\ShiftRight0~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~56_combout\ = (\B[3]~input_o\) # ((\B[2]~input_o\ & (!\ShiftRight0~31_combout\)) # (!\B[2]~input_o\ & ((!\ShiftRight0~23_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~31_combout\,
	datad => \ShiftRight0~23_combout\,
	combout => \ShiftRight0~56_combout\);

-- Location: LCCOMB_X52_Y40_N30
\ShiftRight0~74\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~74_combout\ = (\ShiftRight0~56_combout\ & (((\B[2]~input_o\) # (!\ShiftRight0~28_combout\)) # (!\B[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~56_combout\,
	datad => \ShiftRight0~28_combout\,
	combout => \ShiftRight0~74_combout\);

-- Location: LCCOMB_X47_Y39_N6
\ShiftRight1~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~57_combout\ = ((\A[31]~input_o\ & (\B[2]~input_o\ & \B[3]~input_o\))) # (!\ShiftRight0~74_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~74_combout\,
	combout => \ShiftRight1~57_combout\);

-- Location: LCCOMB_X52_Y40_N26
\Mux25~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~4_combout\ = (!\B[4]~input_o\ & (\Mux31~6_combout\ & ((\B[3]~input_o\) # (\B[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \B[4]~input_o\,
	datad => \Mux31~6_combout\,
	combout => \Mux25~4_combout\);

-- Location: LCCOMB_X46_Y41_N24
\Mux25~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~3_combout\ = (\B[3]~input_o\) # ((\B[4]~input_o\) # (\ALUOP[1]~input_o\ $ (!\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[4]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux25~3_combout\);

-- Location: LCCOMB_X46_Y41_N2
\Mux25~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~5_combout\ = (\Mux25~3_combout\ & ((\Mux25~4_combout\) # (!\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~4_combout\,
	datab => \Mux25~3_combout\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux25~5_combout\);

-- Location: LCCOMB_X52_Y40_N8
\ShiftRight0~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~57_combout\ = (\B[2]~input_o\ & (\ShiftRight0~26_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~26_combout\,
	datab => \B[2]~input_o\,
	datad => \ShiftRight0~16_combout\,
	combout => \ShiftRight0~57_combout\);

-- Location: LCCOMB_X47_Y39_N28
\Mux27~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~2_combout\ = (\Mux25~5_combout\ & ((\Mux25~4_combout\ & ((\ShiftRight0~57_combout\))) # (!\Mux25~4_combout\ & (\ShiftRight1~57_combout\)))) # (!\Mux25~5_combout\ & (((\Mux25~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~57_combout\,
	datab => \Mux25~5_combout\,
	datac => \Mux25~4_combout\,
	datad => \ShiftRight0~57_combout\,
	combout => \Mux27~2_combout\);

-- Location: LCCOMB_X47_Y41_N4
\Mux27~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~3_combout\ = (\Mux27~2_combout\ & ((\Mux25~3_combout\) # ((\ShiftRight0~19_combout\)))) # (!\Mux27~2_combout\ & (!\Mux25~3_combout\ & ((\ShiftRight0~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux27~2_combout\,
	datab => \Mux25~3_combout\,
	datac => \ShiftRight0~19_combout\,
	datad => \ShiftRight0~13_combout\,
	combout => \Mux27~3_combout\);

-- Location: LCCOMB_X47_Y41_N26
\Add0~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~14_combout\ = \B[4]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~14_combout\);

-- Location: LCCOMB_X51_Y38_N26
\Add0~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~15_combout\ = (\Add0~14_combout\ & ((\A[4]~input_o\ & (\Add0~13\ & VCC)) # (!\A[4]~input_o\ & (!\Add0~13\)))) # (!\Add0~14_combout\ & ((\A[4]~input_o\ & (!\Add0~13\)) # (!\A[4]~input_o\ & ((\Add0~13\) # (GND)))))
-- \Add0~16\ = CARRY((\Add0~14_combout\ & (!\A[4]~input_o\ & !\Add0~13\)) # (!\Add0~14_combout\ & ((!\Add0~13\) # (!\A[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~14_combout\,
	datab => \A[4]~input_o\,
	datad => VCC,
	cin => \Add0~13\,
	combout => \Add0~15_combout\,
	cout => \Add0~16\);

-- Location: LCCOMB_X47_Y41_N10
\Mux27~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~4_combout\ = (\Mux25~6_combout\ & ((\Mux25~7_combout\ & (\Mux27~3_combout\)) # (!\Mux25~7_combout\ & ((\Add0~15_combout\))))) # (!\Mux25~6_combout\ & (\Mux25~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~6_combout\,
	datab => \Mux25~7_combout\,
	datac => \Mux27~3_combout\,
	datad => \Add0~15_combout\,
	combout => \Mux27~4_combout\);

-- Location: LCCOMB_X47_Y41_N24
\Mux25~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~2_combout\ = (!\ALUOP[1]~input_o\ & (\ALUOP[2]~input_o\ & (\B[4]~input_o\ $ (!\ALUOP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datac => \ALUOP[2]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux25~2_combout\);

-- Location: LCCOMB_X49_Y41_N30
\ShiftLeft0~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~17_combout\ = (\B[0]~input_o\ & ((\B[1]~input_o\ & ((\A[1]~input_o\))) # (!\B[1]~input_o\ & (\A[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[3]~input_o\,
	datab => \B[1]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[1]~input_o\,
	combout => \ShiftLeft0~17_combout\);

-- Location: LCCOMB_X51_Y38_N10
\ShiftLeft0~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~18_combout\ = (\B[1]~input_o\ & ((\A[2]~input_o\))) # (!\B[1]~input_o\ & (\A[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[4]~input_o\,
	datac => \A[2]~input_o\,
	combout => \ShiftLeft0~18_combout\);

-- Location: LCCOMB_X49_Y41_N0
\ShiftLeft0~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~19_combout\ = (\ShiftLeft0~17_combout\) # ((\ShiftLeft0~18_combout\ & !\B[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~17_combout\,
	datab => \ShiftLeft0~18_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftLeft0~19_combout\);

-- Location: LCCOMB_X47_Y39_N8
\ShiftLeft0~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~20_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~16_combout\ & ((\A[0]~input_o\)))) # (!\B[2]~input_o\ & (((\ShiftLeft0~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~16_combout\,
	datab => \ShiftLeft0~19_combout\,
	datac => \B[2]~input_o\,
	datad => \A[0]~input_o\,
	combout => \ShiftLeft0~20_combout\);

-- Location: LCCOMB_X47_Y39_N2
\ShiftLeft0~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~21_combout\ = (\ShiftLeft0~20_combout\ & !\B[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~20_combout\,
	datac => \B[3]~input_o\,
	combout => \ShiftLeft0~21_combout\);

-- Location: LCCOMB_X47_Y41_N28
\Mux27~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~5_combout\ = (\Mux27~4_combout\ & (((!\ShiftRight0~74_combout\)) # (!\Mux25~2_combout\))) # (!\Mux27~4_combout\ & (\Mux25~2_combout\ & (\ShiftLeft0~21_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110001011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux27~4_combout\,
	datab => \Mux25~2_combout\,
	datac => \ShiftLeft0~21_combout\,
	datad => \ShiftRight0~74_combout\,
	combout => \Mux27~5_combout\);

-- Location: LCCOMB_X50_Y42_N24
\Mux27~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~6_combout\ = (\B[4]~input_o\ & ((\A[4]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[4]~input_o\ & (\A[4]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datac => \A[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux27~6_combout\);

-- Location: LCCOMB_X50_Y42_N4
\Mux27~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux27~7_combout\ = (\ALUOP[2]~input_o\ & (((\Mux27~5_combout\)))) # (!\ALUOP[2]~input_o\ & ((\ALUOP[1]~input_o\ & (\Mux27~5_combout\)) # (!\ALUOP[1]~input_o\ & ((\Mux27~6_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datac => \Mux27~5_combout\,
	datad => \Mux27~6_combout\,
	combout => \Mux27~7_combout\);

-- Location: LCCOMB_X50_Y40_N0
\ShiftRight0~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~58_combout\ = (\B[3]~input_o\) # ((\B[2]~input_o\ & (!\ShiftRight0~45_combout\)) # (!\B[2]~input_o\ & ((!\ShiftRight0~36_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftRight0~45_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~36_combout\,
	combout => \ShiftRight0~58_combout\);

-- Location: LCCOMB_X46_Y41_N12
\ShiftRight0~75\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~75_combout\ = ((\B[3]~input_o\ & (!\B[2]~input_o\ & \ShiftRight0~44_combout\))) # (!\ShiftRight0~58_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~44_combout\,
	datad => \ShiftRight0~58_combout\,
	combout => \ShiftRight0~75_combout\);

-- Location: LCCOMB_X50_Y40_N26
\ShiftRight0~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~59_combout\ = (\B[2]~input_o\ & (\ShiftRight0~37_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~41_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \ShiftRight0~37_combout\,
	datad => \ShiftRight0~41_combout\,
	combout => \ShiftRight0~59_combout\);

-- Location: LCCOMB_X46_Y41_N20
\ShiftRight1~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~51_combout\ = (\B[1]~input_o\ & (\A[31]~input_o\)) # (!\B[1]~input_o\ & ((\B[2]~input_o\ & (\A[31]~input_o\)) # (!\B[2]~input_o\ & ((\ShiftRight1~22_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \B[1]~input_o\,
	datac => \ShiftRight1~22_combout\,
	datad => \B[2]~input_o\,
	combout => \ShiftRight1~51_combout\);

-- Location: LCCOMB_X46_Y41_N22
\ShiftRight1~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~52_combout\ = ((\B[3]~input_o\ & \ShiftRight1~51_combout\)) # (!\ShiftRight0~58_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \ShiftRight1~51_combout\,
	datad => \ShiftRight0~58_combout\,
	combout => \ShiftRight1~52_combout\);

-- Location: LCCOMB_X46_Y41_N8
\Mux26~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~2_combout\ = (\Mux25~5_combout\ & ((\Mux25~4_combout\ & (\ShiftRight0~59_combout\)) # (!\Mux25~4_combout\ & ((\ShiftRight1~52_combout\))))) # (!\Mux25~5_combout\ & (((\Mux25~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~59_combout\,
	datab => \Mux25~5_combout\,
	datac => \ShiftRight1~52_combout\,
	datad => \Mux25~4_combout\,
	combout => \Mux26~2_combout\);

-- Location: LCCOMB_X46_Y41_N18
\Mux26~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~3_combout\ = (\Mux26~2_combout\ & ((\ShiftRight0~42_combout\) # ((\Mux25~3_combout\)))) # (!\Mux26~2_combout\ & (((\ShiftRight0~40_combout\ & !\Mux25~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~42_combout\,
	datab => \Mux26~2_combout\,
	datac => \ShiftRight0~40_combout\,
	datad => \Mux25~3_combout\,
	combout => \Mux26~3_combout\);

-- Location: LCCOMB_X54_Y40_N6
\Add0~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~17_combout\ = \ALUOP[0]~input_o\ $ (\B[5]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \B[5]~input_o\,
	combout => \Add0~17_combout\);

-- Location: LCCOMB_X51_Y38_N28
\Add0~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~18_combout\ = ((\Add0~17_combout\ $ (\A[5]~input_o\ $ (!\Add0~16\)))) # (GND)
-- \Add0~19\ = CARRY((\Add0~17_combout\ & ((\A[5]~input_o\) # (!\Add0~16\))) # (!\Add0~17_combout\ & (\A[5]~input_o\ & !\Add0~16\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~17_combout\,
	datab => \A[5]~input_o\,
	datad => VCC,
	cin => \Add0~16\,
	combout => \Add0~18_combout\,
	cout => \Add0~19\);

-- Location: LCCOMB_X47_Y41_N22
\Mux26~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~4_combout\ = (\Mux25~6_combout\ & ((\Mux25~7_combout\ & (\Mux26~3_combout\)) # (!\Mux25~7_combout\ & ((\Add0~18_combout\))))) # (!\Mux25~6_combout\ & (\Mux25~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~6_combout\,
	datab => \Mux25~7_combout\,
	datac => \Mux26~3_combout\,
	datad => \Add0~18_combout\,
	combout => \Mux26~4_combout\);

-- Location: LCCOMB_X49_Y41_N10
\ShiftLeft0~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~22_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[0]~input_o\))) # (!\B[0]~input_o\ & (\A[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[1]~input_o\,
	datab => \A[0]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~22_combout\);

-- Location: LCCOMB_X49_Y39_N28
\ShiftLeft0~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~23_combout\ = (\B[1]~input_o\ & ((\A[3]~input_o\))) # (!\B[1]~input_o\ & (\A[5]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[1]~input_o\,
	datac => \A[5]~input_o\,
	datad => \A[3]~input_o\,
	combout => \ShiftLeft0~23_combout\);

-- Location: LCCOMB_X49_Y41_N28
\ShiftLeft0~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~24_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~18_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~23_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~18_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~23_combout\,
	combout => \ShiftLeft0~24_combout\);

-- Location: LCCOMB_X49_Y41_N22
\ShiftLeft0~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~25_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & (\ShiftLeft0~22_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~24_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~22_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~24_combout\,
	combout => \ShiftLeft0~25_combout\);

-- Location: LCCOMB_X46_Y41_N28
\Mux26~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~5_combout\ = (\Mux26~4_combout\ & ((\ShiftRight0~75_combout\) # ((!\Mux25~2_combout\)))) # (!\Mux26~4_combout\ & (((\Mux25~2_combout\ & \ShiftLeft0~25_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~75_combout\,
	datab => \Mux26~4_combout\,
	datac => \Mux25~2_combout\,
	datad => \ShiftLeft0~25_combout\,
	combout => \Mux26~5_combout\);

-- Location: LCCOMB_X54_Y40_N8
\Mux26~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~6_combout\ = (\A[5]~input_o\ & ((\ALUOP[0]~input_o\) # (\B[5]~input_o\))) # (!\A[5]~input_o\ & (\ALUOP[0]~input_o\ & \B[5]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[5]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \B[5]~input_o\,
	combout => \Mux26~6_combout\);

-- Location: LCCOMB_X54_Y40_N18
\Mux26~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux26~7_combout\ = (\ALUOP[1]~input_o\ & (\Mux26~5_combout\)) # (!\ALUOP[1]~input_o\ & ((\ALUOP[2]~input_o\ & (\Mux26~5_combout\)) # (!\ALUOP[2]~input_o\ & ((\Mux26~6_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \Mux26~5_combout\,
	datac => \Mux26~6_combout\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux26~7_combout\);

-- Location: LCCOMB_X49_Y39_N22
\ShiftLeft0~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~26_combout\ = (\B[1]~input_o\ & ((\A[4]~input_o\))) # (!\B[1]~input_o\ & (\A[6]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[1]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[4]~input_o\,
	combout => \ShiftLeft0~26_combout\);

-- Location: LCCOMB_X49_Y39_N24
\ShiftLeft0~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~27_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~23_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~26_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~26_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~23_combout\,
	combout => \ShiftLeft0~27_combout\);

-- Location: LCCOMB_X50_Y38_N0
\ShiftLeft0~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~28_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftLeft0~13_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~27_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~27_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~13_combout\,
	combout => \ShiftLeft0~28_combout\);

-- Location: LCCOMB_X50_Y41_N22
\ShiftRight0~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~62_combout\ = (\B[2]~input_o\ & (\ShiftRight1~34_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight1~41_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftRight1~34_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~41_combout\,
	combout => \ShiftRight0~62_combout\);

-- Location: LCCOMB_X46_Y38_N16
\ShiftRight1~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~53_combout\ = (\B[2]~input_o\ & (((\A[31]~input_o\)))) # (!\B[2]~input_o\ & ((\ShiftLeft0~16_combout\ & (\A[30]~input_o\)) # (!\ShiftLeft0~16_combout\ & ((\A[31]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~16_combout\,
	datad => \A[31]~input_o\,
	combout => \ShiftRight1~53_combout\);

-- Location: LCCOMB_X49_Y37_N28
\ShiftRight0~61\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~61_combout\ = (\B[3]~input_o\) # ((\B[2]~input_o\ & (!\ShiftRight1~30_combout\)) # (!\B[2]~input_o\ & ((!\ShiftRight1~32_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~30_combout\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~32_combout\,
	combout => \ShiftRight0~61_combout\);

-- Location: LCCOMB_X46_Y38_N18
\ShiftRight1~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~54_combout\ = ((\B[3]~input_o\ & \ShiftRight1~53_combout\)) # (!\ShiftRight0~61_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \ShiftRight1~53_combout\,
	datad => \ShiftRight0~61_combout\,
	combout => \ShiftRight1~54_combout\);

-- Location: LCCOMB_X46_Y41_N30
\Mux25~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~8_combout\ = (\Mux25~4_combout\ & (((\ShiftRight0~62_combout\)) # (!\Mux25~5_combout\))) # (!\Mux25~4_combout\ & (\Mux25~5_combout\ & ((\ShiftRight1~54_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~4_combout\,
	datab => \Mux25~5_combout\,
	datac => \ShiftRight0~62_combout\,
	datad => \ShiftRight1~54_combout\,
	combout => \Mux25~8_combout\);

-- Location: LCCOMB_X46_Y41_N16
\Mux25~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~9_combout\ = (\Mux25~8_combout\ & ((\Mux25~3_combout\) # ((\ShiftRight1~43_combout\)))) # (!\Mux25~8_combout\ & (!\Mux25~3_combout\ & ((\ShiftRight1~39_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~8_combout\,
	datab => \Mux25~3_combout\,
	datac => \ShiftRight1~43_combout\,
	datad => \ShiftRight1~39_combout\,
	combout => \Mux25~9_combout\);

-- Location: LCCOMB_X54_Y40_N2
\Add0~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~20_combout\ = \B[6]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[6]~input_o\,
	datac => \ALUOP[0]~input_o\,
	combout => \Add0~20_combout\);

-- Location: LCCOMB_X51_Y38_N30
\Add0~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~21_combout\ = (\A[6]~input_o\ & ((\Add0~20_combout\ & (\Add0~19\ & VCC)) # (!\Add0~20_combout\ & (!\Add0~19\)))) # (!\A[6]~input_o\ & ((\Add0~20_combout\ & (!\Add0~19\)) # (!\Add0~20_combout\ & ((\Add0~19\) # (GND)))))
-- \Add0~22\ = CARRY((\A[6]~input_o\ & (!\Add0~20_combout\ & !\Add0~19\)) # (!\A[6]~input_o\ & ((!\Add0~19\) # (!\Add0~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[6]~input_o\,
	datab => \Add0~20_combout\,
	datad => VCC,
	cin => \Add0~19\,
	combout => \Add0~21_combout\,
	cout => \Add0~22\);

-- Location: LCCOMB_X47_Y41_N8
\Mux25~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~10_combout\ = (\Mux25~6_combout\ & ((\Mux25~7_combout\ & (\Mux25~9_combout\)) # (!\Mux25~7_combout\ & ((\Add0~21_combout\))))) # (!\Mux25~6_combout\ & (\Mux25~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~6_combout\,
	datab => \Mux25~7_combout\,
	datac => \Mux25~9_combout\,
	datad => \Add0~21_combout\,
	combout => \Mux25~10_combout\);

-- Location: LCCOMB_X49_Y37_N18
\ShiftRight0~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~60_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & (\A[31]~input_o\)) # (!\B[0]~input_o\ & ((\A[30]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \A[31]~input_o\,
	datac => \A[30]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~60_combout\);

-- Location: LCCOMB_X49_Y37_N20
\ShiftRight0~76\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~76_combout\ = ((\B[3]~input_o\ & (!\B[2]~input_o\ & \ShiftRight0~60_combout\))) # (!\ShiftRight0~61_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~61_combout\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight0~60_combout\,
	combout => \ShiftRight0~76_combout\);

-- Location: LCCOMB_X47_Y41_N2
\Mux25~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~11_combout\ = (\Mux25~2_combout\ & ((\Mux25~10_combout\ & ((\ShiftRight0~76_combout\))) # (!\Mux25~10_combout\ & (\ShiftLeft0~28_combout\)))) # (!\Mux25~2_combout\ & (((\Mux25~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~28_combout\,
	datab => \Mux25~2_combout\,
	datac => \Mux25~10_combout\,
	datad => \ShiftRight0~76_combout\,
	combout => \Mux25~11_combout\);

-- Location: LCCOMB_X54_Y40_N12
\Mux25~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~12_combout\ = (\B[6]~input_o\ & ((\ALUOP[0]~input_o\) # (\A[6]~input_o\))) # (!\B[6]~input_o\ & (\ALUOP[0]~input_o\ & \A[6]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[6]~input_o\,
	datac => \ALUOP[0]~input_o\,
	datad => \A[6]~input_o\,
	combout => \Mux25~12_combout\);

-- Location: LCCOMB_X54_Y40_N28
\Mux25~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux25~13_combout\ = (\ALUOP[2]~input_o\ & (\Mux25~11_combout\)) # (!\ALUOP[2]~input_o\ & ((\ALUOP[1]~input_o\ & (\Mux25~11_combout\)) # (!\ALUOP[1]~input_o\ & ((\Mux25~12_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \Mux25~11_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \Mux25~12_combout\,
	combout => \Mux25~13_combout\);

-- Location: LCCOMB_X50_Y39_N20
\ShiftRight0~65\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~65_combout\ = (\B[2]~input_o\ & (\ShiftRight1~44_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight1~49_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~44_combout\,
	datab => \B[2]~input_o\,
	datad => \ShiftRight1~49_combout\,
	combout => \ShiftRight0~65_combout\);

-- Location: LCCOMB_X51_Y39_N0
\ShiftRight0~63\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~63_combout\ = (\B[3]~input_o\) # ((\B[2]~input_o\ & ((!\ShiftRight1~47_combout\))) # (!\B[2]~input_o\ & (!\ShiftRight1~45_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftRight1~45_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight1~47_combout\,
	combout => \ShiftRight0~63_combout\);

-- Location: LCCOMB_X51_Y39_N24
\ShiftRight1~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~58_combout\ = ((\B[3]~input_o\ & \A[31]~input_o\)) # (!\ShiftRight0~63_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ShiftRight0~63_combout\,
	combout => \ShiftRight1~58_combout\);

-- Location: LCCOMB_X50_Y39_N30
\Mux24~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~2_combout\ = (\Mux25~4_combout\ & ((\ShiftRight0~65_combout\) # ((!\Mux25~5_combout\)))) # (!\Mux25~4_combout\ & (((\Mux25~5_combout\ & \ShiftRight1~58_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~4_combout\,
	datab => \ShiftRight0~65_combout\,
	datac => \Mux25~5_combout\,
	datad => \ShiftRight1~58_combout\,
	combout => \Mux24~2_combout\);

-- Location: LCCOMB_X50_Y39_N8
\Mux24~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~3_combout\ = (\Mux24~2_combout\ & (((\Mux25~3_combout\) # (\ShiftRight1~50_combout\)))) # (!\Mux24~2_combout\ & (\ShiftRight1~48_combout\ & (!\Mux25~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux24~2_combout\,
	datab => \ShiftRight1~48_combout\,
	datac => \Mux25~3_combout\,
	datad => \ShiftRight1~50_combout\,
	combout => \Mux24~3_combout\);

-- Location: LCCOMB_X54_Y40_N22
\Add0~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~23_combout\ = \ALUOP[0]~input_o\ $ (\B[7]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \B[7]~input_o\,
	combout => \Add0~23_combout\);

-- Location: LCCOMB_X51_Y37_N0
\Add0~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~24_combout\ = ((\Add0~23_combout\ $ (\A[7]~input_o\ $ (!\Add0~22\)))) # (GND)
-- \Add0~25\ = CARRY((\Add0~23_combout\ & ((\A[7]~input_o\) # (!\Add0~22\))) # (!\Add0~23_combout\ & (\A[7]~input_o\ & !\Add0~22\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~23_combout\,
	datab => \A[7]~input_o\,
	datad => VCC,
	cin => \Add0~22\,
	combout => \Add0~24_combout\,
	cout => \Add0~25\);

-- Location: LCCOMB_X47_Y41_N12
\Mux24~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~4_combout\ = (\Mux25~6_combout\ & ((\Mux25~7_combout\ & (\Mux24~3_combout\)) # (!\Mux25~7_combout\ & ((\Add0~24_combout\))))) # (!\Mux25~6_combout\ & (\Mux25~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux25~6_combout\,
	datab => \Mux25~7_combout\,
	datac => \Mux24~3_combout\,
	datad => \Add0~24_combout\,
	combout => \Mux24~4_combout\);

-- Location: LCCOMB_X49_Y41_N24
\ShiftLeft0~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~29_combout\ = (\ShiftLeft0~14_combout\) # ((\ShiftLeft0~11_combout\ & \B[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~11_combout\,
	datab => \B[1]~input_o\,
	datad => \ShiftLeft0~14_combout\,
	combout => \ShiftLeft0~29_combout\);

-- Location: LCCOMB_X51_Y38_N4
\ShiftLeft0~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~30_combout\ = (\B[1]~input_o\ & ((\A[5]~input_o\))) # (!\B[1]~input_o\ & (\A[7]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datac => \A[5]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~30_combout\);

-- Location: LCCOMB_X47_Y39_N22
\ShiftLeft0~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~31_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~26_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~30_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~30_combout\,
	datab => \B[0]~input_o\,
	datad => \ShiftLeft0~26_combout\,
	combout => \ShiftLeft0~31_combout\);

-- Location: LCCOMB_X47_Y40_N0
\ShiftLeft0~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~32_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & (\ShiftLeft0~29_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~31_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \ShiftLeft0~29_combout\,
	datad => \ShiftLeft0~31_combout\,
	combout => \ShiftLeft0~32_combout\);

-- Location: LCCOMB_X51_Y39_N18
\ShiftRight0~64\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~64_combout\ = ((\ShiftLeft0~16_combout\ & (\ShiftRight0~52_combout\ & !\B[2]~input_o\))) # (!\ShiftRight0~63_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~16_combout\,
	datab => \ShiftRight0~52_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight0~63_combout\,
	combout => \ShiftRight0~64_combout\);

-- Location: LCCOMB_X47_Y41_N30
\Mux24~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~5_combout\ = (\Mux24~4_combout\ & (((\ShiftRight0~64_combout\)) # (!\Mux25~2_combout\))) # (!\Mux24~4_combout\ & (\Mux25~2_combout\ & (\ShiftLeft0~32_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux24~4_combout\,
	datab => \Mux25~2_combout\,
	datac => \ShiftLeft0~32_combout\,
	datad => \ShiftRight0~64_combout\,
	combout => \Mux24~5_combout\);

-- Location: LCCOMB_X54_Y40_N16
\Mux24~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~6_combout\ = (\A[7]~input_o\ & ((\B[7]~input_o\) # (\ALUOP[0]~input_o\))) # (!\A[7]~input_o\ & (\B[7]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[7]~input_o\,
	datac => \ALUOP[0]~input_o\,
	combout => \Mux24~6_combout\);

-- Location: LCCOMB_X54_Y40_N30
\Mux24~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux24~7_combout\ = (\ALUOP[1]~input_o\ & (\Mux24~5_combout\)) # (!\ALUOP[1]~input_o\ & ((\ALUOP[2]~input_o\ & (\Mux24~5_combout\)) # (!\ALUOP[2]~input_o\ & ((\Mux24~6_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux24~5_combout\,
	datab => \Mux24~6_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux24~7_combout\);

-- Location: LCCOMB_X52_Y38_N18
\Add0~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~26_combout\ = \B[8]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[8]~input_o\,
	datac => \ALUOP[0]~input_o\,
	combout => \Add0~26_combout\);

-- Location: LCCOMB_X51_Y37_N2
\Add0~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~27_combout\ = (\Add0~26_combout\ & ((\A[8]~input_o\ & (\Add0~25\ & VCC)) # (!\A[8]~input_o\ & (!\Add0~25\)))) # (!\Add0~26_combout\ & ((\A[8]~input_o\ & (!\Add0~25\)) # (!\A[8]~input_o\ & ((\Add0~25\) # (GND)))))
-- \Add0~28\ = CARRY((\Add0~26_combout\ & (!\A[8]~input_o\ & !\Add0~25\)) # (!\Add0~26_combout\ & ((!\Add0~25\) # (!\A[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~26_combout\,
	datab => \A[8]~input_o\,
	datad => VCC,
	cin => \Add0~25\,
	combout => \Add0~27_combout\,
	cout => \Add0~28\);

-- Location: LCCOMB_X49_Y39_N26
\ShiftLeft0~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~34_combout\ = (\B[1]~input_o\ & (\A[6]~input_o\)) # (!\B[1]~input_o\ & ((\A[8]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[1]~input_o\,
	datac => \A[6]~input_o\,
	datad => \A[8]~input_o\,
	combout => \ShiftLeft0~34_combout\);

-- Location: LCCOMB_X47_Y39_N10
\ShiftLeft0~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~35_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~30_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~34_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~30_combout\,
	datab => \B[0]~input_o\,
	datad => \ShiftLeft0~34_combout\,
	combout => \ShiftLeft0~35_combout\);

-- Location: LCCOMB_X47_Y39_N0
\ShiftLeft0~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~33_combout\ = (\A[0]~input_o\ & (!\B[1]~input_o\ & (!\B[0]~input_o\ & !\B[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[0]~input_o\,
	datab => \B[1]~input_o\,
	datac => \B[0]~input_o\,
	datad => \B[2]~input_o\,
	combout => \ShiftLeft0~33_combout\);

-- Location: LCCOMB_X47_Y39_N12
\ShiftLeft0~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~36_combout\ = (\B[3]~input_o\ & (((\ShiftLeft0~33_combout\)))) # (!\B[3]~input_o\ & (\ShiftLeft0~35_combout\ & (!\B[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~35_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~33_combout\,
	combout => \ShiftLeft0~36_combout\);

-- Location: LCCOMB_X47_Y39_N14
\ShiftLeft0~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~37_combout\ = (\ShiftLeft0~36_combout\) # ((\B[2]~input_o\ & (!\B[3]~input_o\ & \ShiftLeft0~19_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~36_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~19_combout\,
	combout => \ShiftLeft0~37_combout\);

-- Location: LCCOMB_X52_Y40_N0
\ShiftRight0~66\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~66_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftRight0~28_combout\))) # (!\B[2]~input_o\ & (\ShiftRight0~31_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~31_combout\,
	datad => \ShiftRight0~28_combout\,
	combout => \ShiftRight0~66_combout\);

-- Location: LCCOMB_X52_Y38_N10
\Mux23~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~9_combout\ = (!\ALUOP[0]~input_o\ & ((\ShiftRight0~66_combout\) # ((\B[3]~input_o\ & \A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~66_combout\,
	datab => \B[3]~input_o\,
	datac => \ALUOP[0]~input_o\,
	datad => \A[31]~input_o\,
	combout => \Mux23~9_combout\);

-- Location: LCCOMB_X52_Y38_N28
\Mux23~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~4_combout\ = (\Mux28~3_combout\ & (((\ShiftRight0~20_combout\) # (!\Mux28~2_combout\)))) # (!\Mux28~3_combout\ & (\Mux23~9_combout\ & ((\Mux28~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux23~9_combout\,
	datab => \Mux28~3_combout\,
	datac => \ShiftRight0~20_combout\,
	datad => \Mux28~2_combout\,
	combout => \Mux23~4_combout\);

-- Location: LCCOMB_X52_Y38_N14
\Mux23~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~5_combout\ = (\Mux28~0_combout\ & ((\Mux23~4_combout\ & ((\ShiftRight0~66_combout\))) # (!\Mux23~4_combout\ & (\ShiftLeft0~37_combout\)))) # (!\Mux28~0_combout\ & (((\Mux23~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~37_combout\,
	datab => \Mux28~0_combout\,
	datac => \ShiftRight0~66_combout\,
	datad => \Mux23~4_combout\,
	combout => \Mux23~5_combout\);

-- Location: LCCOMB_X52_Y38_N16
\Mux23~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~6_combout\ = (\Mux28~5_combout\ & ((\Mux28~4_combout\) # ((\A[8]~input_o\) # (\B[8]~input_o\)))) # (!\Mux28~5_combout\ & (!\Mux28~4_combout\ & (\A[8]~input_o\ & \B[8]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \Mux28~4_combout\,
	datac => \A[8]~input_o\,
	datad => \B[8]~input_o\,
	combout => \Mux23~6_combout\);

-- Location: LCCOMB_X52_Y38_N2
\Mux23~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~7_combout\ = (\Mux28~4_combout\ & ((\Mux23~6_combout\ & ((\Mux23~5_combout\))) # (!\Mux23~6_combout\ & (\Add0~27_combout\)))) # (!\Mux28~4_combout\ & (((\Mux23~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~27_combout\,
	datab => \Mux23~5_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux23~6_combout\,
	combout => \Mux23~7_combout\);

-- Location: LCCOMB_X52_Y40_N12
\Mux23~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~2_combout\ = (\B[3]~input_o\ & (\ALUOP[2]~input_o\ & (!\B[4]~input_o\ & \Mux31~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \ALUOP[2]~input_o\,
	datac => \B[4]~input_o\,
	datad => \Mux31~6_combout\,
	combout => \Mux23~2_combout\);

-- Location: LCCOMB_X52_Y40_N14
\Mux23~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~3_combout\ = (\Mux23~2_combout\ & ((\B[2]~input_o\ & (\ShiftRight0~23_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~26_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~23_combout\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~26_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux23~3_combout\);

-- Location: LCCOMB_X52_Y40_N18
\Mux23~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux23~8_combout\ = (\Mux23~3_combout\) # ((\Mux23~7_combout\ & !\Mux23~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux23~7_combout\,
	datac => \Mux23~3_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux23~8_combout\);

-- Location: LCCOMB_X52_Y39_N24
\Add0~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~29_combout\ = \B[9]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[9]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~29_combout\);

-- Location: LCCOMB_X51_Y37_N4
\Add0~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~30_combout\ = ((\Add0~29_combout\ $ (\A[9]~input_o\ $ (!\Add0~28\)))) # (GND)
-- \Add0~31\ = CARRY((\Add0~29_combout\ & ((\A[9]~input_o\) # (!\Add0~28\))) # (!\Add0~29_combout\ & (\A[9]~input_o\ & !\Add0~28\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~29_combout\,
	datab => \A[9]~input_o\,
	datad => VCC,
	cin => \Add0~28\,
	combout => \Add0~30_combout\,
	cout => \Add0~31\);

-- Location: LCCOMB_X52_Y39_N2
\Mux22~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~4_combout\ = (\B[9]~input_o\ & ((\Mux28~5_combout\) # ((!\Mux28~4_combout\ & \A[9]~input_o\)))) # (!\B[9]~input_o\ & (\Mux28~5_combout\ & ((\Mux28~4_combout\) # (\A[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[9]~input_o\,
	datab => \Mux28~4_combout\,
	datac => \Mux28~5_combout\,
	datad => \A[9]~input_o\,
	combout => \Mux22~4_combout\);

-- Location: LCCOMB_X49_Y39_N12
\ShiftLeft0~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~38_combout\ = (\B[1]~input_o\ & (\A[7]~input_o\)) # (!\B[1]~input_o\ & ((\A[9]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[7]~input_o\,
	datab => \B[1]~input_o\,
	datad => \A[9]~input_o\,
	combout => \ShiftLeft0~38_combout\);

-- Location: LCCOMB_X49_Y39_N14
\ShiftLeft0~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~39_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~34_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~38_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~38_combout\,
	datab => \B[0]~input_o\,
	datac => \ShiftLeft0~34_combout\,
	combout => \ShiftLeft0~39_combout\);

-- Location: LCCOMB_X49_Y41_N18
\ShiftLeft0~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~40_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~24_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~39_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~39_combout\,
	datab => \B[2]~input_o\,
	datad => \ShiftLeft0~24_combout\,
	combout => \ShiftLeft0~40_combout\);

-- Location: LCCOMB_X49_Y41_N14
\ShiftLeft0~104\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~104_combout\ = (\B[3]~input_o\ & (\ShiftLeft0~22_combout\ & (!\B[2]~input_o\))) # (!\B[3]~input_o\ & (((\ShiftLeft0~40_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~22_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~40_combout\,
	combout => \ShiftLeft0~104_combout\);

-- Location: LCCOMB_X49_Y38_N22
\ShiftRight1~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~59_combout\ = (\B[3]~input_o\ & (((\A[31]~input_o\)))) # (!\B[3]~input_o\ & ((\ShiftRight0~38_combout\) # ((\ShiftRight1~23_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~38_combout\,
	datab => \A[31]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight1~23_combout\,
	combout => \ShiftRight1~59_combout\);

-- Location: LCCOMB_X47_Y38_N14
\Mux22~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~1_combout\ = (\ShiftRight1~59_combout\ & !\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~59_combout\,
	datac => \ALUOP[0]~input_o\,
	combout => \Mux22~1_combout\);

-- Location: LCCOMB_X47_Y38_N8
\Mux22~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~2_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & (\ShiftRight0~43_combout\)) # (!\Mux28~3_combout\ & ((\Mux22~1_combout\))))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~43_combout\,
	datab => \Mux22~1_combout\,
	datac => \Mux28~2_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux22~2_combout\);

-- Location: LCCOMB_X47_Y38_N12
\ShiftRight0~67\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~67_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & (\ShiftRight0~44_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~45_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~44_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~45_combout\,
	combout => \ShiftRight0~67_combout\);

-- Location: LCCOMB_X47_Y37_N8
\Mux22~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~3_combout\ = (\Mux22~2_combout\ & (((\ShiftRight0~67_combout\) # (!\Mux28~0_combout\)))) # (!\Mux22~2_combout\ & (\ShiftLeft0~104_combout\ & ((\Mux28~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~104_combout\,
	datab => \Mux22~2_combout\,
	datac => \ShiftRight0~67_combout\,
	datad => \Mux28~0_combout\,
	combout => \Mux22~3_combout\);

-- Location: LCCOMB_X52_Y39_N28
\Mux22~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~5_combout\ = (\Mux22~4_combout\ & (((\Mux22~3_combout\) # (!\Mux28~4_combout\)))) # (!\Mux22~4_combout\ & (\Add0~30_combout\ & (\Mux28~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~30_combout\,
	datab => \Mux22~4_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux22~3_combout\,
	combout => \Mux22~5_combout\);

-- Location: LCCOMB_X52_Y39_N22
\Mux22~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux22~6_combout\ = (\Mux23~2_combout\ & ((\Mux22~0_combout\))) # (!\Mux23~2_combout\ & (\Mux22~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux22~5_combout\,
	datac => \Mux22~0_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux22~6_combout\);

-- Location: LCCOMB_X50_Y37_N20
\Mux21~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~8_combout\ = (!\ALUOP[0]~input_o\ & ((\B[3]~input_o\ & ((\A[31]~input_o\))) # (!\B[3]~input_o\ & (\ShiftRight1~36_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~36_combout\,
	datab => \B[3]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux21~8_combout\);

-- Location: LCCOMB_X50_Y41_N24
\Mux21~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~3_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & ((\ShiftRight0~51_combout\))) # (!\Mux28~3_combout\ & (\Mux21~8_combout\)))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~2_combout\,
	datab => \Mux21~8_combout\,
	datac => \ShiftRight0~51_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux21~3_combout\);

-- Location: LCCOMB_X49_Y37_N14
\ShiftRight0~68\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~68_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftRight0~60_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~30_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~30_combout\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight0~60_combout\,
	combout => \ShiftRight0~68_combout\);

-- Location: LCCOMB_X46_Y39_N16
\ShiftLeft0~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~41_combout\ = (\B[1]~input_o\ & ((\A[8]~input_o\))) # (!\B[1]~input_o\ & (\A[10]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[10]~input_o\,
	datad => \A[8]~input_o\,
	combout => \ShiftLeft0~41_combout\);

-- Location: LCCOMB_X46_Y39_N10
\ShiftLeft0~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~42_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~38_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~41_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftLeft0~41_combout\,
	datad => \ShiftLeft0~38_combout\,
	combout => \ShiftLeft0~42_combout\);

-- Location: LCCOMB_X50_Y38_N2
\ShiftLeft0~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~43_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~27_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~42_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~42_combout\,
	datab => \ShiftLeft0~27_combout\,
	datac => \B[2]~input_o\,
	combout => \ShiftLeft0~43_combout\);

-- Location: LCCOMB_X50_Y38_N4
\ShiftLeft0~105\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~105_combout\ = (\B[3]~input_o\ & (!\B[2]~input_o\ & (\ShiftLeft0~13_combout\))) # (!\B[3]~input_o\ & (((\ShiftLeft0~43_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~13_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~43_combout\,
	combout => \ShiftLeft0~105_combout\);

-- Location: LCCOMB_X47_Y37_N10
\Mux21~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~4_combout\ = (\Mux21~3_combout\ & ((\ShiftRight0~68_combout\) # ((!\Mux28~0_combout\)))) # (!\Mux21~3_combout\ & (((\ShiftLeft0~105_combout\ & \Mux28~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux21~3_combout\,
	datab => \ShiftRight0~68_combout\,
	datac => \ShiftLeft0~105_combout\,
	datad => \Mux28~0_combout\,
	combout => \Mux21~4_combout\);

-- Location: LCCOMB_X50_Y37_N2
\Add0~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~32_combout\ = \B[10]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[10]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~32_combout\);

-- Location: LCCOMB_X51_Y37_N6
\Add0~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~33_combout\ = (\Add0~32_combout\ & ((\A[10]~input_o\ & (\Add0~31\ & VCC)) # (!\A[10]~input_o\ & (!\Add0~31\)))) # (!\Add0~32_combout\ & ((\A[10]~input_o\ & (!\Add0~31\)) # (!\A[10]~input_o\ & ((\Add0~31\) # (GND)))))
-- \Add0~34\ = CARRY((\Add0~32_combout\ & (!\A[10]~input_o\ & !\Add0~31\)) # (!\Add0~32_combout\ & ((!\Add0~31\) # (!\A[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~32_combout\,
	datab => \A[10]~input_o\,
	datad => VCC,
	cin => \Add0~31\,
	combout => \Add0~33_combout\,
	cout => \Add0~34\);

-- Location: LCCOMB_X52_Y39_N0
\Mux21~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~5_combout\ = (\A[10]~input_o\ & ((\Mux28~5_combout\) # ((!\Mux28~4_combout\ & \B[10]~input_o\)))) # (!\A[10]~input_o\ & (\Mux28~5_combout\ & ((\Mux28~4_combout\) # (\B[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[10]~input_o\,
	datab => \Mux28~5_combout\,
	datac => \Mux28~4_combout\,
	datad => \B[10]~input_o\,
	combout => \Mux21~5_combout\);

-- Location: LCCOMB_X52_Y39_N26
\Mux21~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~6_combout\ = (\Mux28~4_combout\ & ((\Mux21~5_combout\ & (\Mux21~4_combout\)) # (!\Mux21~5_combout\ & ((\Add0~33_combout\))))) # (!\Mux28~4_combout\ & (((\Mux21~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux21~4_combout\,
	datab => \Add0~33_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux21~5_combout\,
	combout => \Mux21~6_combout\);

-- Location: LCCOMB_X52_Y39_N20
\Mux21~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux21~7_combout\ = (\Mux23~2_combout\ & ((\Mux21~2_combout\))) # (!\Mux23~2_combout\ & (\Mux21~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux21~6_combout\,
	datac => \Mux21~2_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux21~7_combout\);

-- Location: LCCOMB_X46_Y39_N12
\ShiftLeft0~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~44_combout\ = (\B[1]~input_o\ & ((\A[9]~input_o\))) # (!\B[1]~input_o\ & (\A[11]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[11]~input_o\,
	datac => \A[9]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~44_combout\);

-- Location: LCCOMB_X46_Y39_N22
\ShiftLeft0~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~45_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~41_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~44_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftLeft0~41_combout\,
	datad => \ShiftLeft0~44_combout\,
	combout => \ShiftLeft0~45_combout\);

-- Location: LCCOMB_X47_Y40_N2
\ShiftLeft0~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~46_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~31_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~45_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~45_combout\,
	datad => \ShiftLeft0~31_combout\,
	combout => \ShiftLeft0~46_combout\);

-- Location: LCCOMB_X50_Y41_N18
\ShiftLeft0~106\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~106_combout\ = (\B[3]~input_o\ & (((!\B[2]~input_o\ & \ShiftLeft0~29_combout\)))) # (!\B[3]~input_o\ & (\ShiftLeft0~46_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \ShiftLeft0~46_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftLeft0~29_combout\,
	combout => \ShiftLeft0~106_combout\);

-- Location: LCCOMB_X50_Y39_N4
\Mux20~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~1_combout\ = (!\ALUOP[0]~input_o\ & ((\ShiftRight0~35_combout\ & ((\ShiftRight1~47_combout\))) # (!\ShiftRight0~35_combout\ & (\A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[0]~input_o\,
	datab => \A[31]~input_o\,
	datac => \ShiftRight1~47_combout\,
	datad => \ShiftRight0~35_combout\,
	combout => \Mux20~1_combout\);

-- Location: LCCOMB_X50_Y39_N14
\Mux20~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~2_combout\ = (\Mux28~3_combout\ & (((\ShiftRight0~55_combout\) # (!\Mux28~2_combout\)))) # (!\Mux28~3_combout\ & (\Mux20~1_combout\ & (\Mux28~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~3_combout\,
	datab => \Mux20~1_combout\,
	datac => \Mux28~2_combout\,
	datad => \ShiftRight0~55_combout\,
	combout => \Mux20~2_combout\);

-- Location: LCCOMB_X49_Y37_N16
\ShiftRight0~69\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~69_combout\ = (!\B[1]~input_o\ & (!\B[3]~input_o\ & (\B[2]~input_o\ & !\B[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \B[0]~input_o\,
	combout => \ShiftRight0~69_combout\);

-- Location: LCCOMB_X50_Y39_N2
\ShiftRight0~70\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~70_combout\ = (\ShiftRight0~69_combout\ & ((\A[31]~input_o\) # ((\ShiftRight1~47_combout\ & \ShiftRight0~35_combout\)))) # (!\ShiftRight0~69_combout\ & (((\ShiftRight1~47_combout\ & \ShiftRight0~35_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~69_combout\,
	datab => \A[31]~input_o\,
	datac => \ShiftRight1~47_combout\,
	datad => \ShiftRight0~35_combout\,
	combout => \ShiftRight0~70_combout\);

-- Location: LCCOMB_X50_Y39_N0
\Mux20~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~3_combout\ = (\Mux20~2_combout\ & (((\ShiftRight0~70_combout\) # (!\Mux28~0_combout\)))) # (!\Mux20~2_combout\ & (\ShiftLeft0~106_combout\ & (\Mux28~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~106_combout\,
	datab => \Mux20~2_combout\,
	datac => \Mux28~0_combout\,
	datad => \ShiftRight0~70_combout\,
	combout => \Mux20~3_combout\);

-- Location: LCCOMB_X52_Y39_N14
\Mux20~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~4_combout\ = (\A[11]~input_o\ & ((\Mux28~5_combout\) # ((!\Mux28~4_combout\ & \B[11]~input_o\)))) # (!\A[11]~input_o\ & (\Mux28~5_combout\ & ((\Mux28~4_combout\) # (\B[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[11]~input_o\,
	datab => \Mux28~5_combout\,
	datac => \Mux28~4_combout\,
	datad => \B[11]~input_o\,
	combout => \Mux20~4_combout\);

-- Location: LCCOMB_X50_Y37_N12
\Add0~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~35_combout\ = \B[11]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[11]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~35_combout\);

-- Location: LCCOMB_X51_Y37_N8
\Add0~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~36_combout\ = ((\Add0~35_combout\ $ (\A[11]~input_o\ $ (!\Add0~34\)))) # (GND)
-- \Add0~37\ = CARRY((\Add0~35_combout\ & ((\A[11]~input_o\) # (!\Add0~34\))) # (!\Add0~35_combout\ & (\A[11]~input_o\ & !\Add0~34\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~35_combout\,
	datab => \A[11]~input_o\,
	datad => VCC,
	cin => \Add0~34\,
	combout => \Add0~36_combout\,
	cout => \Add0~37\);

-- Location: LCCOMB_X52_Y39_N16
\Mux20~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~5_combout\ = (\Mux20~4_combout\ & ((\Mux20~3_combout\) # ((!\Mux28~4_combout\)))) # (!\Mux20~4_combout\ & (((\Mux28~4_combout\ & \Add0~36_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux20~3_combout\,
	datab => \Mux20~4_combout\,
	datac => \Mux28~4_combout\,
	datad => \Add0~36_combout\,
	combout => \Mux20~5_combout\);

-- Location: LCCOMB_X50_Y40_N4
\Mux20~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~0_combout\ = (\B[2]~input_o\ & ((\ShiftRight1~45_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~44_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftRight1~44_combout\,
	datac => \ShiftRight1~45_combout\,
	combout => \Mux20~0_combout\);

-- Location: LCCOMB_X52_Y39_N18
\Mux20~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux20~6_combout\ = (\Mux23~2_combout\ & ((\Mux20~0_combout\))) # (!\Mux23~2_combout\ & (\Mux20~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux20~5_combout\,
	datac => \Mux20~0_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux20~6_combout\);

-- Location: LCCOMB_X50_Y37_N22
\Add0~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~38_combout\ = \B[12]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[12]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~38_combout\);

-- Location: LCCOMB_X51_Y37_N10
\Add0~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~39_combout\ = (\Add0~38_combout\ & ((\A[12]~input_o\ & (\Add0~37\ & VCC)) # (!\A[12]~input_o\ & (!\Add0~37\)))) # (!\Add0~38_combout\ & ((\A[12]~input_o\ & (!\Add0~37\)) # (!\A[12]~input_o\ & ((\Add0~37\) # (GND)))))
-- \Add0~40\ = CARRY((\Add0~38_combout\ & (!\A[12]~input_o\ & !\Add0~37\)) # (!\Add0~38_combout\ & ((!\Add0~37\) # (!\A[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~38_combout\,
	datab => \A[12]~input_o\,
	datad => VCC,
	cin => \Add0~37\,
	combout => \Add0~39_combout\,
	cout => \Add0~40\);

-- Location: LCCOMB_X52_Y37_N0
\Mux19~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~4_combout\ = (\Mux28~4_combout\ & (((\Mux28~5_combout\)))) # (!\Mux28~4_combout\ & ((\A[12]~input_o\ & ((\Mux28~5_combout\) # (\B[12]~input_o\))) # (!\A[12]~input_o\ & (\Mux28~5_combout\ & \B[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~4_combout\,
	datab => \A[12]~input_o\,
	datac => \Mux28~5_combout\,
	datad => \B[12]~input_o\,
	combout => \Mux19~4_combout\);

-- Location: LCCOMB_X49_Y42_N4
\Mux19~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~1_combout\ = (!\ALUOP[0]~input_o\ & ((\ShiftRight0~35_combout\ & ((\ShiftRight0~28_combout\))) # (!\ShiftRight0~35_combout\ & (\A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ShiftRight0~35_combout\,
	datad => \ShiftRight0~28_combout\,
	combout => \Mux19~1_combout\);

-- Location: LCCOMB_X49_Y42_N30
\Mux19~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~2_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & ((\ShiftRight0~57_combout\))) # (!\Mux28~3_combout\ & (\Mux19~1_combout\)))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~2_combout\,
	datab => \Mux19~1_combout\,
	datac => \ShiftRight0~57_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux19~2_combout\);

-- Location: LCCOMB_X49_Y42_N2
\ShiftRight0~71\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~71_combout\ = (\ShiftRight0~35_combout\ & ((\ShiftRight0~27_combout\) # ((\ShiftRight1~18_combout\ & \B[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~27_combout\,
	datab => \ShiftRight0~35_combout\,
	datac => \ShiftRight1~18_combout\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight0~71_combout\);

-- Location: LCCOMB_X46_Y39_N0
\ShiftLeft0~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~47_combout\ = (\B[1]~input_o\ & (\A[10]~input_o\)) # (!\B[1]~input_o\ & ((\A[12]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[10]~input_o\,
	datac => \A[12]~input_o\,
	combout => \ShiftLeft0~47_combout\);

-- Location: LCCOMB_X46_Y39_N26
\ShiftLeft0~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~48_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~44_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~47_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftLeft0~47_combout\,
	datad => \ShiftLeft0~44_combout\,
	combout => \ShiftLeft0~48_combout\);

-- Location: LCCOMB_X47_Y39_N16
\ShiftLeft0~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~49_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~35_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~48_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~48_combout\,
	datad => \ShiftLeft0~35_combout\,
	combout => \ShiftLeft0~49_combout\);

-- Location: LCCOMB_X47_Y39_N26
\ShiftLeft0~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~50_combout\ = (\B[3]~input_o\ & (\ShiftLeft0~20_combout\)) # (!\B[3]~input_o\ & ((\ShiftLeft0~49_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \ShiftLeft0~20_combout\,
	datad => \ShiftLeft0~49_combout\,
	combout => \ShiftLeft0~50_combout\);

-- Location: LCCOMB_X49_Y42_N24
\Mux19~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~3_combout\ = (\Mux19~2_combout\ & ((\ShiftRight0~71_combout\) # ((!\Mux28~0_combout\)))) # (!\Mux19~2_combout\ & (((\ShiftLeft0~50_combout\ & \Mux28~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux19~2_combout\,
	datab => \ShiftRight0~71_combout\,
	datac => \ShiftLeft0~50_combout\,
	datad => \Mux28~0_combout\,
	combout => \Mux19~3_combout\);

-- Location: LCCOMB_X52_Y37_N26
\Mux19~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~5_combout\ = (\Mux19~4_combout\ & (((\Mux19~3_combout\) # (!\Mux28~4_combout\)))) # (!\Mux19~4_combout\ & (\Add0~39_combout\ & (\Mux28~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~39_combout\,
	datab => \Mux19~4_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux19~3_combout\,
	combout => \Mux19~5_combout\);

-- Location: LCCOMB_X52_Y40_N20
\Mux19~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~0_combout\ = (\Mux23~2_combout\ & ((\B[2]~input_o\ & ((\ShiftRight0~31_combout\))) # (!\B[2]~input_o\ & (\ShiftRight0~23_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~23_combout\,
	datab => \B[2]~input_o\,
	datac => \ShiftRight0~31_combout\,
	datad => \Mux23~2_combout\,
	combout => \Mux19~0_combout\);

-- Location: LCCOMB_X52_Y37_N28
\Mux19~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux19~6_combout\ = (\Mux19~0_combout\) # ((!\Mux23~2_combout\ & \Mux19~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux23~2_combout\,
	datac => \Mux19~5_combout\,
	datad => \Mux19~0_combout\,
	combout => \Mux19~6_combout\);

-- Location: LCCOMB_X52_Y37_N14
\Mux18~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~0_combout\ = (\Mux23~2_combout\ & ((\B[2]~input_o\ & (\ShiftRight0~45_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight0~36_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~45_combout\,
	datab => \Mux23~2_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight0~36_combout\,
	combout => \Mux18~0_combout\);

-- Location: LCCOMB_X50_Y37_N24
\Add0~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~41_combout\ = \B[13]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[13]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~41_combout\);

-- Location: LCCOMB_X51_Y37_N12
\Add0~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~42_combout\ = ((\A[13]~input_o\ $ (\Add0~41_combout\ $ (!\Add0~40\)))) # (GND)
-- \Add0~43\ = CARRY((\A[13]~input_o\ & ((\Add0~41_combout\) # (!\Add0~40\))) # (!\A[13]~input_o\ & (\Add0~41_combout\ & !\Add0~40\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[13]~input_o\,
	datab => \Add0~41_combout\,
	datad => VCC,
	cin => \Add0~40\,
	combout => \Add0~42_combout\,
	cout => \Add0~43\);

-- Location: LCCOMB_X49_Y42_N10
\ShiftRight1~55\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~55_combout\ = (\ShiftRight0~35_combout\ & ((\B[1]~input_o\ & ((\A[31]~input_o\))) # (!\B[1]~input_o\ & (\ShiftRight1~22_combout\)))) # (!\ShiftRight0~35_combout\ & (((\A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~22_combout\,
	datab => \A[31]~input_o\,
	datac => \ShiftRight0~35_combout\,
	datad => \B[1]~input_o\,
	combout => \ShiftRight1~55_combout\);

-- Location: LCCOMB_X49_Y42_N12
\Mux18~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~1_combout\ = (\ShiftRight1~55_combout\ & !\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~55_combout\,
	datac => \ALUOP[0]~input_o\,
	combout => \Mux18~1_combout\);

-- Location: LCCOMB_X50_Y41_N12
\Mux18~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~2_combout\ = (\Mux28~3_combout\ & ((\ShiftRight0~59_combout\) # ((!\Mux28~2_combout\)))) # (!\Mux28~3_combout\ & (((\Mux18~1_combout\ & \Mux28~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~59_combout\,
	datab => \Mux28~3_combout\,
	datac => \Mux18~1_combout\,
	datad => \Mux28~2_combout\,
	combout => \Mux18~2_combout\);

-- Location: LCCOMB_X50_Y41_N4
\ShiftRight0~77\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~77_combout\ = (\ShiftRight0~44_combout\ & (!\B[2]~input_o\ & !\B[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~44_combout\,
	datac => \B[2]~input_o\,
	datad => \B[3]~input_o\,
	combout => \ShiftRight0~77_combout\);

-- Location: LCCOMB_X46_Y39_N20
\ShiftLeft0~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~52_combout\ = (\B[1]~input_o\ & (\A[11]~input_o\)) # (!\B[1]~input_o\ & ((\A[13]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[11]~input_o\,
	datab => \A[13]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~52_combout\);

-- Location: LCCOMB_X46_Y39_N6
\ShiftLeft0~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~53_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~47_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~52_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftLeft0~47_combout\,
	datad => \ShiftLeft0~52_combout\,
	combout => \ShiftLeft0~53_combout\);

-- Location: LCCOMB_X46_Y40_N16
\ShiftLeft0~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~54_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~39_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~53_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~39_combout\,
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~53_combout\,
	combout => \ShiftLeft0~54_combout\);

-- Location: LCCOMB_X49_Y41_N4
\ShiftLeft0~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~51_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~11_combout\ & (!\B[1]~input_o\))) # (!\B[2]~input_o\ & (((\ShiftLeft0~24_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~11_combout\,
	datab => \B[2]~input_o\,
	datac => \B[1]~input_o\,
	datad => \ShiftLeft0~24_combout\,
	combout => \ShiftLeft0~51_combout\);

-- Location: LCCOMB_X50_Y41_N26
\ShiftLeft0~55\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~55_combout\ = (\B[3]~input_o\ & ((\ShiftLeft0~51_combout\))) # (!\B[3]~input_o\ & (\ShiftLeft0~54_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~54_combout\,
	datac => \ShiftLeft0~51_combout\,
	datad => \B[3]~input_o\,
	combout => \ShiftLeft0~55_combout\);

-- Location: LCCOMB_X50_Y41_N30
\Mux18~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~3_combout\ = (\Mux18~2_combout\ & ((\ShiftRight0~77_combout\) # ((!\Mux28~0_combout\)))) # (!\Mux18~2_combout\ & (((\ShiftLeft0~55_combout\ & \Mux28~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux18~2_combout\,
	datab => \ShiftRight0~77_combout\,
	datac => \ShiftLeft0~55_combout\,
	datad => \Mux28~0_combout\,
	combout => \Mux18~3_combout\);

-- Location: LCCOMB_X52_Y37_N16
\Mux18~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~4_combout\ = (\Mux28~4_combout\ & (((\Mux28~5_combout\)))) # (!\Mux28~4_combout\ & ((\A[13]~input_o\ & ((\Mux28~5_combout\) # (\B[13]~input_o\))) # (!\A[13]~input_o\ & (\Mux28~5_combout\ & \B[13]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~4_combout\,
	datab => \A[13]~input_o\,
	datac => \Mux28~5_combout\,
	datad => \B[13]~input_o\,
	combout => \Mux18~4_combout\);

-- Location: LCCOMB_X52_Y37_N18
\Mux18~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~5_combout\ = (\Mux28~4_combout\ & ((\Mux18~4_combout\ & ((\Mux18~3_combout\))) # (!\Mux18~4_combout\ & (\Add0~42_combout\)))) # (!\Mux28~4_combout\ & (((\Mux18~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~42_combout\,
	datab => \Mux18~3_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux18~4_combout\,
	combout => \Mux18~5_combout\);

-- Location: LCCOMB_X52_Y37_N4
\Mux18~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux18~6_combout\ = (\Mux18~0_combout\) # ((!\Mux23~2_combout\ & \Mux18~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux18~0_combout\,
	datac => \Mux23~2_combout\,
	datad => \Mux18~5_combout\,
	combout => \Mux18~6_combout\);

-- Location: LCCOMB_X52_Y37_N30
\Mux17~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~4_combout\ = (\Mux28~5_combout\ & ((\A[14]~input_o\) # ((\Mux28~4_combout\) # (\B[14]~input_o\)))) # (!\Mux28~5_combout\ & (\A[14]~input_o\ & (!\Mux28~4_combout\ & \B[14]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \A[14]~input_o\,
	datac => \Mux28~4_combout\,
	datad => \B[14]~input_o\,
	combout => \Mux17~4_combout\);

-- Location: LCCOMB_X50_Y38_N6
\ShiftRight0~78\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~78_combout\ = (!\B[1]~input_o\ & (!\B[3]~input_o\ & (!\B[2]~input_o\ & \ShiftRight1~18_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~18_combout\,
	combout => \ShiftRight0~78_combout\);

-- Location: LCCOMB_X52_Y36_N2
\Mux17~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~1_combout\ = (!\ALUOP[0]~input_o\ & ((\ShiftRight0~34_combout\ & ((\A[30]~input_o\))) # (!\ShiftRight0~34_combout\ & (\A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \A[30]~input_o\,
	datac => \ShiftRight0~34_combout\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux17~1_combout\);

-- Location: LCCOMB_X50_Y41_N8
\Mux17~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~2_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & ((\ShiftRight0~62_combout\))) # (!\Mux28~3_combout\ & (\Mux17~1_combout\)))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~2_combout\,
	datab => \Mux17~1_combout\,
	datac => \ShiftRight0~62_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux17~2_combout\);

-- Location: LCCOMB_X51_Y41_N20
\ShiftLeft0~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~57_combout\ = (\B[1]~input_o\ & ((\A[12]~input_o\))) # (!\B[1]~input_o\ & (\A[14]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[14]~input_o\,
	datad => \A[12]~input_o\,
	combout => \ShiftLeft0~57_combout\);

-- Location: LCCOMB_X51_Y41_N6
\ShiftLeft0~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~58_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~52_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~57_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~52_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~57_combout\,
	combout => \ShiftLeft0~58_combout\);

-- Location: LCCOMB_X50_Y38_N14
\ShiftLeft0~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~59_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~42_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~58_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~42_combout\,
	datad => \ShiftLeft0~58_combout\,
	combout => \ShiftLeft0~59_combout\);

-- Location: LCCOMB_X50_Y38_N20
\ShiftLeft0~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~56_combout\ = (\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftLeft0~13_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~27_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~27_combout\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~13_combout\,
	combout => \ShiftLeft0~56_combout\);

-- Location: LCCOMB_X50_Y38_N8
\ShiftLeft0~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~60_combout\ = (\ShiftLeft0~56_combout\) # ((!\B[3]~input_o\ & \ShiftLeft0~59_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \ShiftLeft0~59_combout\,
	datad => \ShiftLeft0~56_combout\,
	combout => \ShiftLeft0~60_combout\);

-- Location: LCCOMB_X50_Y38_N18
\Mux17~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~3_combout\ = (\Mux17~2_combout\ & ((\ShiftRight0~78_combout\) # ((!\Mux28~0_combout\)))) # (!\Mux17~2_combout\ & (((\ShiftLeft0~60_combout\ & \Mux28~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~78_combout\,
	datab => \Mux17~2_combout\,
	datac => \ShiftLeft0~60_combout\,
	datad => \Mux28~0_combout\,
	combout => \Mux17~3_combout\);

-- Location: LCCOMB_X50_Y37_N10
\Add0~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~44_combout\ = \B[14]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[14]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~44_combout\);

-- Location: LCCOMB_X51_Y37_N14
\Add0~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~45_combout\ = (\A[14]~input_o\ & ((\Add0~44_combout\ & (\Add0~43\ & VCC)) # (!\Add0~44_combout\ & (!\Add0~43\)))) # (!\A[14]~input_o\ & ((\Add0~44_combout\ & (!\Add0~43\)) # (!\Add0~44_combout\ & ((\Add0~43\) # (GND)))))
-- \Add0~46\ = CARRY((\A[14]~input_o\ & (!\Add0~44_combout\ & !\Add0~43\)) # (!\A[14]~input_o\ & ((!\Add0~43\) # (!\Add0~44_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[14]~input_o\,
	datab => \Add0~44_combout\,
	datad => VCC,
	cin => \Add0~43\,
	combout => \Add0~45_combout\,
	cout => \Add0~46\);

-- Location: LCCOMB_X52_Y37_N8
\Mux17~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~5_combout\ = (\Mux17~4_combout\ & ((\Mux17~3_combout\) # ((!\Mux28~4_combout\)))) # (!\Mux17~4_combout\ & (((\Mux28~4_combout\ & \Add0~45_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux17~4_combout\,
	datab => \Mux17~3_combout\,
	datac => \Mux28~4_combout\,
	datad => \Add0~45_combout\,
	combout => \Mux17~5_combout\);

-- Location: LCCOMB_X49_Y37_N26
\Mux17~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~0_combout\ = (\B[2]~input_o\ & (\ShiftRight1~30_combout\)) # (!\B[2]~input_o\ & ((\ShiftRight1~32_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~30_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~32_combout\,
	combout => \Mux17~0_combout\);

-- Location: LCCOMB_X52_Y37_N2
\Mux17~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux17~6_combout\ = (\Mux23~2_combout\ & ((\Mux17~0_combout\))) # (!\Mux23~2_combout\ & (\Mux17~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux17~5_combout\,
	datac => \Mux23~2_combout\,
	datad => \Mux17~0_combout\,
	combout => \Mux17~6_combout\);

-- Location: LCCOMB_X52_Y37_N22
\Mux16~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~4_combout\ = (\Mux28~5_combout\ & ((\B[15]~input_o\) # ((\Mux28~4_combout\) # (\A[15]~input_o\)))) # (!\Mux28~5_combout\ & (\B[15]~input_o\ & (!\Mux28~4_combout\ & \A[15]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \B[15]~input_o\,
	datac => \Mux28~4_combout\,
	datad => \A[15]~input_o\,
	combout => \Mux16~4_combout\);

-- Location: LCCOMB_X50_Y37_N4
\Add0~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~47_combout\ = \B[15]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[15]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~47_combout\);

-- Location: LCCOMB_X51_Y37_N16
\Add0~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~48_combout\ = ((\Add0~47_combout\ $ (\A[15]~input_o\ $ (!\Add0~46\)))) # (GND)
-- \Add0~49\ = CARRY((\Add0~47_combout\ & ((\A[15]~input_o\) # (!\Add0~46\))) # (!\Add0~47_combout\ & (\A[15]~input_o\ & !\Add0~46\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~47_combout\,
	datab => \A[15]~input_o\,
	datad => VCC,
	cin => \Add0~46\,
	combout => \Add0~48_combout\,
	cout => \Add0~49\);

-- Location: LCCOMB_X50_Y39_N10
\Mux16~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~1_combout\ = (!\ALUOP[0]~input_o\ & \A[31]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ALUOP[0]~input_o\,
	datad => \A[31]~input_o\,
	combout => \Mux16~1_combout\);

-- Location: LCCOMB_X50_Y39_N12
\Mux16~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~2_combout\ = (\Mux28~2_combout\ & ((\Mux28~3_combout\ & ((\ShiftRight0~65_combout\))) # (!\Mux28~3_combout\ & (\Mux16~1_combout\)))) # (!\Mux28~2_combout\ & (((\Mux28~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux16~1_combout\,
	datab => \ShiftRight0~65_combout\,
	datac => \Mux28~2_combout\,
	datad => \Mux28~3_combout\,
	combout => \Mux16~2_combout\);

-- Location: LCCOMB_X51_Y41_N0
\ShiftLeft0~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~62_combout\ = (\B[1]~input_o\ & ((\A[13]~input_o\))) # (!\B[1]~input_o\ & (\A[15]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[15]~input_o\,
	datad => \A[13]~input_o\,
	combout => \ShiftLeft0~62_combout\);

-- Location: LCCOMB_X51_Y41_N10
\ShiftLeft0~63\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~63_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~57_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~62_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~62_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~57_combout\,
	combout => \ShiftLeft0~63_combout\);

-- Location: LCCOMB_X47_Y40_N22
\ShiftLeft0~64\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~64_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~45_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~63_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~45_combout\,
	datac => \ShiftLeft0~63_combout\,
	combout => \ShiftLeft0~64_combout\);

-- Location: LCCOMB_X47_Y40_N20
\ShiftLeft0~61\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~61_combout\ = (\B[3]~input_o\ & ((\B[2]~input_o\ & (\ShiftLeft0~29_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~31_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \ShiftLeft0~29_combout\,
	datad => \ShiftLeft0~31_combout\,
	combout => \ShiftLeft0~61_combout\);

-- Location: LCCOMB_X47_Y40_N24
\ShiftLeft0~65\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~65_combout\ = (\ShiftLeft0~61_combout\) # ((!\B[3]~input_o\ & \ShiftLeft0~64_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \ShiftLeft0~64_combout\,
	datad => \ShiftLeft0~61_combout\,
	combout => \ShiftLeft0~65_combout\);

-- Location: LCCOMB_X52_Y36_N12
\ShiftRight0~72\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight0~72_combout\ = (\A[31]~input_o\ & \ShiftRight0~34_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datac => \ShiftRight0~34_combout\,
	combout => \ShiftRight0~72_combout\);

-- Location: LCCOMB_X52_Y36_N14
\Mux16~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~3_combout\ = (\Mux16~2_combout\ & (((\ShiftRight0~72_combout\) # (!\Mux28~0_combout\)))) # (!\Mux16~2_combout\ & (\ShiftLeft0~65_combout\ & (\Mux28~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux16~2_combout\,
	datab => \ShiftLeft0~65_combout\,
	datac => \Mux28~0_combout\,
	datad => \ShiftRight0~72_combout\,
	combout => \Mux16~3_combout\);

-- Location: LCCOMB_X52_Y37_N24
\Mux16~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~5_combout\ = (\Mux16~4_combout\ & (((\Mux16~3_combout\) # (!\Mux28~4_combout\)))) # (!\Mux16~4_combout\ & (\Add0~48_combout\ & (\Mux28~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux16~4_combout\,
	datab => \Add0~48_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux16~3_combout\,
	combout => \Mux16~5_combout\);

-- Location: LCCOMB_X52_Y37_N12
\Mux16~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~0_combout\ = (\Mux23~2_combout\ & ((\B[2]~input_o\ & ((\ShiftRight1~47_combout\))) # (!\B[2]~input_o\ & (\ShiftRight1~45_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftRight1~45_combout\,
	datac => \Mux23~2_combout\,
	datad => \ShiftRight1~47_combout\,
	combout => \Mux16~0_combout\);

-- Location: LCCOMB_X52_Y37_N10
\Mux16~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux16~6_combout\ = (\Mux16~0_combout\) # ((\Mux16~5_combout\ & !\Mux23~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Mux16~5_combout\,
	datac => \Mux23~2_combout\,
	datad => \Mux16~0_combout\,
	combout => \Mux16~6_combout\);

-- Location: LCCOMB_X50_Y37_N14
\Add0~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~50_combout\ = \B[16]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[16]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~50_combout\);

-- Location: LCCOMB_X51_Y37_N18
\Add0~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~51_combout\ = (\Add0~50_combout\ & ((\A[16]~input_o\ & (\Add0~49\ & VCC)) # (!\A[16]~input_o\ & (!\Add0~49\)))) # (!\Add0~50_combout\ & ((\A[16]~input_o\ & (!\Add0~49\)) # (!\A[16]~input_o\ & ((\Add0~49\) # (GND)))))
-- \Add0~52\ = CARRY((\Add0~50_combout\ & (!\A[16]~input_o\ & !\Add0~49\)) # (!\Add0~50_combout\ & ((!\Add0~49\) # (!\A[16]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~50_combout\,
	datab => \A[16]~input_o\,
	datad => VCC,
	cin => \Add0~49\,
	combout => \Add0~51_combout\,
	cout => \Add0~52\);

-- Location: LCCOMB_X50_Y36_N10
\Mux15~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~0_combout\ = (\ALUOP[1]~input_o\ & (\Add0~51_combout\ & !\ALUOP[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \Add0~51_combout\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux15~0_combout\);

-- Location: LCCOMB_X50_Y36_N30
\Mux1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (\ALUOP[2]~input_o\ & (!\B[4]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux1~0_combout\);

-- Location: LCCOMB_X50_Y36_N20
\Mux15~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~1_combout\ = (!\ALUOP[2]~input_o\ & ((\A[16]~input_o\ & ((\B[16]~input_o\) # (\ALUOP[0]~input_o\))) # (!\A[16]~input_o\ & (\B[16]~input_o\ & \ALUOP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \A[16]~input_o\,
	datac => \B[16]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux15~1_combout\);

-- Location: LCCOMB_X50_Y36_N16
\Mux15~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~2_combout\ = (!\ALUOP[1]~input_o\ & ((\Mux15~1_combout\) # ((\Mux1~0_combout\ & \ShiftRight0~33_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux1~0_combout\,
	datab => \Mux15~1_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ShiftRight0~33_combout\,
	combout => \Mux15~2_combout\);

-- Location: LCCOMB_X47_Y39_N20
\Mux15~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~4_combout\ = (\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftLeft0~19_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~35_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~35_combout\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftLeft0~19_combout\,
	combout => \Mux15~4_combout\);

-- Location: LCCOMB_X51_Y41_N28
\ShiftLeft0~66\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~66_combout\ = (\B[1]~input_o\ & (\A[14]~input_o\)) # (!\B[1]~input_o\ & ((\A[16]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[14]~input_o\,
	datad => \A[16]~input_o\,
	combout => \ShiftLeft0~66_combout\);

-- Location: LCCOMB_X51_Y41_N30
\ShiftLeft0~67\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~67_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~62_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~66_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~66_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~62_combout\,
	combout => \ShiftLeft0~67_combout\);

-- Location: LCCOMB_X46_Y40_N18
\ShiftLeft0~68\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~68_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~48_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~67_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~67_combout\,
	datad => \ShiftLeft0~48_combout\,
	combout => \ShiftLeft0~68_combout\);

-- Location: LCCOMB_X46_Y38_N22
\Mux15~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~5_combout\ = (\Mux15~4_combout\) # ((!\B[3]~input_o\ & \ShiftLeft0~68_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[3]~input_o\,
	datab => \Mux15~4_combout\,
	datac => \ShiftLeft0~68_combout\,
	combout => \Mux15~5_combout\);

-- Location: LCCOMB_X46_Y38_N4
\Mux15~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~3_combout\ = (\ALUOP[1]~input_o\ & (((\A[31]~input_o\)))) # (!\ALUOP[1]~input_o\ & (\A[0]~input_o\ & ((\ShiftRight0~34_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[0]~input_o\,
	datab => \A[31]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \ShiftRight0~34_combout\,
	combout => \Mux15~3_combout\);

-- Location: LCCOMB_X46_Y38_N0
\Mux15~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~6_combout\ = (\B[4]~input_o\ & (((\Mux15~3_combout\)))) # (!\B[4]~input_o\ & (\Mux15~5_combout\ & ((!\ALUOP[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux15~5_combout\,
	datab => \Mux15~3_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux15~6_combout\);

-- Location: LCCOMB_X50_Y36_N26
\Mux15~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~7_combout\ = (\Mux15~6_combout\) # ((\ALUOP[1]~input_o\ & (!\B[4]~input_o\ & \ShiftRight0~33_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \Mux15~6_combout\,
	datac => \B[4]~input_o\,
	datad => \ShiftRight0~33_combout\,
	combout => \Mux15~7_combout\);

-- Location: LCCOMB_X50_Y36_N12
\Mux15~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux15~8_combout\ = (\Mux15~0_combout\) # ((\Mux15~2_combout\) # ((\Mux15~7_combout\ & \Mux3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux15~0_combout\,
	datab => \Mux15~2_combout\,
	datac => \Mux15~7_combout\,
	datad => \Mux3~0_combout\,
	combout => \Mux15~8_combout\);

-- Location: LCCOMB_X51_Y40_N6
\ShiftLeft0~69\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~69_combout\ = (\B[1]~input_o\ & ((\A[15]~input_o\))) # (!\B[1]~input_o\ & (\A[17]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[17]~input_o\,
	datad => \A[15]~input_o\,
	combout => \ShiftLeft0~69_combout\);

-- Location: LCCOMB_X51_Y41_N16
\ShiftLeft0~70\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~70_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~66_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~69_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~69_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~66_combout\,
	combout => \ShiftLeft0~70_combout\);

-- Location: LCCOMB_X46_Y40_N20
\ShiftLeft0~71\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~71_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~53_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~70_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~53_combout\,
	datad => \ShiftLeft0~70_combout\,
	combout => \ShiftLeft0~71_combout\);

-- Location: LCCOMB_X46_Y41_N26
\Mux12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~0_combout\ = (\B[4]~input_o\) # (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux12~0_combout\);

-- Location: LCCOMB_X46_Y41_N4
\Mux12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~1_combout\ = \B[4]~input_o\ $ (!\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux12~1_combout\);

-- Location: LCCOMB_X47_Y41_N16
\Mux12~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~2_combout\ = (\ALUOP[0]~input_o\) # ((\B[3]~input_o\ & !\B[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[3]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux12~2_combout\);

-- Location: LCCOMB_X47_Y38_N18
\Mux14~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~0_combout\ = (\Mux12~1_combout\ & (!\Mux12~2_combout\)) # (!\Mux12~1_combout\ & ((\Mux12~2_combout\ & (\ShiftRight0~47_combout\)) # (!\Mux12~2_combout\ & ((\ShiftLeft0~102_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001101100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~1_combout\,
	datab => \Mux12~2_combout\,
	datac => \ShiftRight0~47_combout\,
	datad => \ShiftLeft0~102_combout\,
	combout => \Mux14~0_combout\);

-- Location: LCCOMB_X46_Y38_N10
\Mux14~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~1_combout\ = (\Mux12~0_combout\ & (((\Mux14~0_combout\)))) # (!\Mux12~0_combout\ & ((\Mux14~0_combout\ & (\ShiftLeft0~71_combout\)) # (!\Mux14~0_combout\ & ((\ShiftLeft0~40_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~71_combout\,
	datab => \Mux12~0_combout\,
	datac => \Mux14~0_combout\,
	datad => \ShiftLeft0~40_combout\,
	combout => \Mux14~1_combout\);

-- Location: LCCOMB_X46_Y38_N30
\Mux12~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~4_combout\ = (\ALUOP[1]~input_o\ & \ALUOP[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ALUOP[1]~input_o\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux12~4_combout\);

-- Location: LCCOMB_X46_Y38_N20
\Mux12~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~3_combout\ = (\ALUOP[2]~input_o\ & ((\B[4]~input_o\) # (!\ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[1]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux12~3_combout\);

-- Location: LCCOMB_X58_Y37_N8
\Add0~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~53_combout\ = \B[17]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[17]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~53_combout\);

-- Location: LCCOMB_X51_Y37_N20
\Add0~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~54_combout\ = ((\Add0~53_combout\ $ (\A[17]~input_o\ $ (!\Add0~52\)))) # (GND)
-- \Add0~55\ = CARRY((\Add0~53_combout\ & ((\A[17]~input_o\) # (!\Add0~52\))) # (!\Add0~53_combout\ & (\A[17]~input_o\ & !\Add0~52\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~53_combout\,
	datab => \A[17]~input_o\,
	datad => VCC,
	cin => \Add0~52\,
	combout => \Add0~54_combout\,
	cout => \Add0~55\);

-- Location: LCCOMB_X46_Y38_N8
\Mux14~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~2_combout\ = (\Mux12~4_combout\ & ((\Mux12~3_combout\) # ((\ShiftRight1~24_combout\)))) # (!\Mux12~4_combout\ & (!\Mux12~3_combout\ & (\Add0~54_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~3_combout\,
	datac => \Add0~54_combout\,
	datad => \ShiftRight1~24_combout\,
	combout => \Mux14~2_combout\);

-- Location: LCCOMB_X46_Y38_N2
\Mux14~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~3_combout\ = (\Mux14~2_combout\ & (((\A[31]~input_o\) # (!\Mux12~3_combout\)))) # (!\Mux14~2_combout\ & (\Mux14~1_combout\ & ((\Mux12~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~1_combout\,
	datab => \A[31]~input_o\,
	datac => \Mux14~2_combout\,
	datad => \Mux12~3_combout\,
	combout => \Mux14~3_combout\);

-- Location: LCCOMB_X54_Y39_N16
\Mux14~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~5_combout\ = (\B[17]~input_o\ & ((\A[17]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[17]~input_o\ & (\A[17]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[17]~input_o\,
	datac => \A[17]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux14~5_combout\);

-- Location: LCCOMB_X54_Y40_N10
\Mux14~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~4_combout\ = (\ALUOP[2]~input_o\ & ((!\ALUOP[1]~input_o\) # (!\ALUOP[0]~input_o\))) # (!\ALUOP[2]~input_o\ & ((\ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111101001111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	combout => \Mux14~4_combout\);

-- Location: LCCOMB_X54_Y39_N10
\Mux14~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux14~6_combout\ = (\Mux14~3_combout\ & ((\Mux14~4_combout\) # ((\Mux14~5_combout\ & !\Mux28~4_combout\)))) # (!\Mux14~3_combout\ & (\Mux14~5_combout\ & ((!\Mux28~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~3_combout\,
	datab => \Mux14~5_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux14~6_combout\);

-- Location: LCCOMB_X50_Y42_N20
\Mux13~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~4_combout\ = (\B[18]~input_o\ & ((\A[18]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[18]~input_o\ & (\A[18]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[18]~input_o\,
	datac => \A[18]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux13~4_combout\);

-- Location: LCCOMB_X52_Y38_N12
\Mux13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~0_combout\ = (\Mux12~2_combout\ & (((\ShiftRight0~50_combout\ & !\Mux12~1_combout\)))) # (!\Mux12~2_combout\ & ((\ShiftLeft0~103_combout\) # ((\Mux12~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~2_combout\,
	datab => \ShiftLeft0~103_combout\,
	datac => \ShiftRight0~50_combout\,
	datad => \Mux12~1_combout\,
	combout => \Mux13~0_combout\);

-- Location: LCCOMB_X51_Y40_N0
\ShiftLeft0~72\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~72_combout\ = (\B[1]~input_o\ & (\A[16]~input_o\)) # (!\B[1]~input_o\ & ((\A[18]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[16]~input_o\,
	datad => \A[18]~input_o\,
	combout => \ShiftLeft0~72_combout\);

-- Location: LCCOMB_X51_Y40_N26
\ShiftLeft0~73\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~73_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~69_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~72_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~72_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~69_combout\,
	combout => \ShiftLeft0~73_combout\);

-- Location: LCCOMB_X50_Y38_N12
\ShiftLeft0~74\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~74_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~58_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~73_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~73_combout\,
	datad => \ShiftLeft0~58_combout\,
	combout => \ShiftLeft0~74_combout\);

-- Location: LCCOMB_X50_Y38_N22
\Mux13~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~1_combout\ = (\Mux13~0_combout\ & (((\ShiftLeft0~74_combout\) # (\Mux12~0_combout\)))) # (!\Mux13~0_combout\ & (\ShiftLeft0~43_combout\ & ((!\Mux12~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux13~0_combout\,
	datab => \ShiftLeft0~43_combout\,
	datac => \ShiftLeft0~74_combout\,
	datad => \Mux12~0_combout\,
	combout => \Mux13~1_combout\);

-- Location: LCCOMB_X50_Y42_N2
\Add0~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~56_combout\ = \B[18]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[18]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~56_combout\);

-- Location: LCCOMB_X51_Y37_N22
\Add0~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~57_combout\ = (\Add0~56_combout\ & ((\A[18]~input_o\ & (\Add0~55\ & VCC)) # (!\A[18]~input_o\ & (!\Add0~55\)))) # (!\Add0~56_combout\ & ((\A[18]~input_o\ & (!\Add0~55\)) # (!\A[18]~input_o\ & ((\Add0~55\) # (GND)))))
-- \Add0~58\ = CARRY((\Add0~56_combout\ & (!\A[18]~input_o\ & !\Add0~55\)) # (!\Add0~56_combout\ & ((!\Add0~55\) # (!\A[18]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~56_combout\,
	datab => \A[18]~input_o\,
	datad => VCC,
	cin => \Add0~55\,
	combout => \Add0~57_combout\,
	cout => \Add0~58\);

-- Location: LCCOMB_X52_Y38_N30
\ShiftRight1~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~56_combout\ = (\B[3]~input_o\ & (\ShiftRight1~36_combout\)) # (!\B[3]~input_o\ & ((\Mux21~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftRight1~36_combout\,
	datac => \B[3]~input_o\,
	datad => \Mux21~2_combout\,
	combout => \ShiftRight1~56_combout\);

-- Location: LCCOMB_X51_Y39_N28
\Mux13~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~2_combout\ = (\Mux12~4_combout\ & ((\Mux12~3_combout\) # ((\ShiftRight1~56_combout\)))) # (!\Mux12~4_combout\ & (!\Mux12~3_combout\ & (\Add0~57_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~3_combout\,
	datac => \Add0~57_combout\,
	datad => \ShiftRight1~56_combout\,
	combout => \Mux13~2_combout\);

-- Location: LCCOMB_X54_Y39_N20
\Mux13~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~3_combout\ = (\Mux12~3_combout\ & ((\Mux13~2_combout\ & ((\A[31]~input_o\))) # (!\Mux13~2_combout\ & (\Mux13~1_combout\)))) # (!\Mux12~3_combout\ & (((\Mux13~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux13~1_combout\,
	datab => \Mux12~3_combout\,
	datac => \A[31]~input_o\,
	datad => \Mux13~2_combout\,
	combout => \Mux13~3_combout\);

-- Location: LCCOMB_X54_Y39_N14
\Mux13~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux13~5_combout\ = (\Mux13~4_combout\ & (((\Mux13~3_combout\ & \Mux14~4_combout\)) # (!\Mux28~4_combout\))) # (!\Mux13~4_combout\ & (\Mux13~3_combout\ & (\Mux14~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux13~4_combout\,
	datab => \Mux13~3_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux13~5_combout\);

-- Location: LCCOMB_X50_Y37_N26
\Mux12~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~9_combout\ = (\B[19]~input_o\ & ((\A[19]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[19]~input_o\ & (\A[19]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[19]~input_o\,
	datac => \A[19]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux12~9_combout\);

-- Location: LCCOMB_X51_Y40_N4
\ShiftLeft0~75\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~75_combout\ = (\B[1]~input_o\ & (\A[17]~input_o\)) # (!\B[1]~input_o\ & ((\A[19]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[17]~input_o\,
	datac => \A[19]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~75_combout\);

-- Location: LCCOMB_X51_Y40_N22
\ShiftLeft0~76\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~76_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~72_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~75_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~75_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~72_combout\,
	combout => \ShiftLeft0~76_combout\);

-- Location: LCCOMB_X47_Y40_N26
\ShiftLeft0~77\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~77_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~63_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~76_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~76_combout\,
	datac => \ShiftLeft0~63_combout\,
	datad => \B[2]~input_o\,
	combout => \ShiftLeft0~77_combout\);

-- Location: LCCOMB_X50_Y39_N6
\Mux12~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~5_combout\ = (\Mux12~2_combout\ & (\ShiftRight0~54_combout\ & (!\Mux12~1_combout\))) # (!\Mux12~2_combout\ & (((\Mux12~1_combout\) # (\ShiftLeft0~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~54_combout\,
	datab => \Mux12~2_combout\,
	datac => \Mux12~1_combout\,
	datad => \ShiftLeft0~15_combout\,
	combout => \Mux12~5_combout\);

-- Location: LCCOMB_X47_Y40_N4
\Mux12~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~6_combout\ = (\Mux12~0_combout\ & (((\Mux12~5_combout\)))) # (!\Mux12~0_combout\ & ((\Mux12~5_combout\ & (\ShiftLeft0~77_combout\)) # (!\Mux12~5_combout\ & ((\ShiftLeft0~46_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~77_combout\,
	datab => \ShiftLeft0~46_combout\,
	datac => \Mux12~0_combout\,
	datad => \Mux12~5_combout\,
	combout => \Mux12~6_combout\);

-- Location: LCCOMB_X50_Y37_N8
\Add0~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~59_combout\ = \B[19]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[19]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~59_combout\);

-- Location: LCCOMB_X51_Y37_N24
\Add0~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~60_combout\ = ((\Add0~59_combout\ $ (\A[19]~input_o\ $ (!\Add0~58\)))) # (GND)
-- \Add0~61\ = CARRY((\Add0~59_combout\ & ((\A[19]~input_o\) # (!\Add0~58\))) # (!\Add0~59_combout\ & (\A[19]~input_o\ & !\Add0~58\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~59_combout\,
	datab => \A[19]~input_o\,
	datad => VCC,
	cin => \Add0~58\,
	combout => \Add0~60_combout\,
	cout => \Add0~61\);

-- Location: LCCOMB_X51_Y39_N14
\Mux12~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~7_combout\ = (\Mux12~4_combout\ & (\Mux12~3_combout\)) # (!\Mux12~4_combout\ & ((\Mux12~3_combout\ & (\Mux12~6_combout\)) # (!\Mux12~3_combout\ & ((\Add0~60_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~3_combout\,
	datac => \Mux12~6_combout\,
	datad => \Add0~60_combout\,
	combout => \Mux12~7_combout\);

-- Location: LCCOMB_X51_Y39_N10
\ShiftRight1~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~60_combout\ = ((\A[31]~input_o\ & (\B[2]~input_o\ & \B[3]~input_o\))) # (!\ShiftRight0~73_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \B[2]~input_o\,
	datac => \B[3]~input_o\,
	datad => \ShiftRight0~73_combout\,
	combout => \ShiftRight1~60_combout\);

-- Location: LCCOMB_X51_Y39_N8
\Mux12~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~8_combout\ = (\Mux12~4_combout\ & ((\Mux12~7_combout\ & (\A[31]~input_o\)) # (!\Mux12~7_combout\ & ((\ShiftRight1~60_combout\))))) # (!\Mux12~4_combout\ & (\Mux12~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~7_combout\,
	datac => \A[31]~input_o\,
	datad => \ShiftRight1~60_combout\,
	combout => \Mux12~8_combout\);

-- Location: LCCOMB_X54_Y39_N8
\Mux12~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux12~10_combout\ = (\Mux12~9_combout\ & (((\Mux12~8_combout\ & \Mux14~4_combout\)) # (!\Mux28~4_combout\))) # (!\Mux12~9_combout\ & (\Mux12~8_combout\ & (\Mux14~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~9_combout\,
	datab => \Mux12~8_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux12~10_combout\);

-- Location: LCCOMB_X54_Y39_N26
\Mux11~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~4_combout\ = (\B[20]~input_o\ & ((\A[20]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[20]~input_o\ & (\A[20]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[20]~input_o\,
	datac => \A[20]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux11~4_combout\);

-- Location: LCCOMB_X50_Y37_N28
\Add0~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~62_combout\ = \B[20]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[20]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~62_combout\);

-- Location: LCCOMB_X51_Y37_N26
\Add0~63\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~63_combout\ = (\Add0~62_combout\ & ((\A[20]~input_o\ & (\Add0~61\ & VCC)) # (!\A[20]~input_o\ & (!\Add0~61\)))) # (!\Add0~62_combout\ & ((\A[20]~input_o\ & (!\Add0~61\)) # (!\A[20]~input_o\ & ((\Add0~61\) # (GND)))))
-- \Add0~64\ = CARRY((\Add0~62_combout\ & (!\A[20]~input_o\ & !\Add0~61\)) # (!\Add0~62_combout\ & ((!\Add0~61\) # (!\A[20]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~62_combout\,
	datab => \A[20]~input_o\,
	datad => VCC,
	cin => \Add0~61\,
	combout => \Add0~63_combout\,
	cout => \Add0~64\);

-- Location: LCCOMB_X47_Y39_N18
\Mux11~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~2_combout\ = (\Mux12~4_combout\ & ((\Mux12~3_combout\) # ((\ShiftRight1~57_combout\)))) # (!\Mux12~4_combout\ & (!\Mux12~3_combout\ & (\Add0~63_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~3_combout\,
	datac => \Add0~63_combout\,
	datad => \ShiftRight1~57_combout\,
	combout => \Mux11~2_combout\);

-- Location: LCCOMB_X49_Y40_N8
\ShiftLeft0~78\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~78_combout\ = (\B[1]~input_o\ & ((\A[18]~input_o\))) # (!\B[1]~input_o\ & (\A[20]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[20]~input_o\,
	datad => \A[18]~input_o\,
	combout => \ShiftLeft0~78_combout\);

-- Location: LCCOMB_X51_Y40_N16
\ShiftLeft0~79\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~79_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~75_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datab => \ShiftLeft0~75_combout\,
	datac => \ShiftLeft0~78_combout\,
	combout => \ShiftLeft0~79_combout\);

-- Location: LCCOMB_X46_Y40_N30
\ShiftLeft0~80\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~80_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~67_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~79_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[2]~input_o\,
	datac => \ShiftLeft0~67_combout\,
	datad => \ShiftLeft0~79_combout\,
	combout => \ShiftLeft0~80_combout\);

-- Location: LCCOMB_X47_Y39_N30
\Mux11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~0_combout\ = (\Mux12~1_combout\ & (((!\Mux12~2_combout\)))) # (!\Mux12~1_combout\ & ((\Mux12~2_combout\ & ((!\ShiftRight0~74_combout\))) # (!\Mux12~2_combout\ & (\ShiftLeft0~21_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111001011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~1_combout\,
	datab => \ShiftLeft0~21_combout\,
	datac => \Mux12~2_combout\,
	datad => \ShiftRight0~74_combout\,
	combout => \Mux11~0_combout\);

-- Location: LCCOMB_X47_Y39_N24
\Mux11~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~1_combout\ = (\Mux12~0_combout\ & (((\Mux11~0_combout\)))) # (!\Mux12~0_combout\ & ((\Mux11~0_combout\ & (\ShiftLeft0~80_combout\)) # (!\Mux11~0_combout\ & ((\ShiftLeft0~49_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~80_combout\,
	datab => \Mux12~0_combout\,
	datac => \Mux11~0_combout\,
	datad => \ShiftLeft0~49_combout\,
	combout => \Mux11~1_combout\);

-- Location: LCCOMB_X47_Y39_N4
\Mux11~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~3_combout\ = (\Mux11~2_combout\ & ((\A[31]~input_o\) # ((!\Mux12~3_combout\)))) # (!\Mux11~2_combout\ & (((\Mux12~3_combout\ & \Mux11~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux11~2_combout\,
	datac => \Mux12~3_combout\,
	datad => \Mux11~1_combout\,
	combout => \Mux11~3_combout\);

-- Location: LCCOMB_X54_Y39_N12
\Mux11~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux11~5_combout\ = (\Mux11~4_combout\ & (((\Mux11~3_combout\ & \Mux14~4_combout\)) # (!\Mux28~4_combout\))) # (!\Mux11~4_combout\ & (\Mux11~3_combout\ & (\Mux14~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux11~4_combout\,
	datab => \Mux11~3_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux11~5_combout\);

-- Location: LCCOMB_X54_Y39_N22
\Mux10~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~4_combout\ = (\A[21]~input_o\ & ((\B[21]~input_o\) # (\ALUOP[0]~input_o\))) # (!\A[21]~input_o\ & (\B[21]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[21]~input_o\,
	datac => \B[21]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux10~4_combout\);

-- Location: LCCOMB_X50_Y37_N30
\Add0~65\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~65_combout\ = \B[21]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[21]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~65_combout\);

-- Location: LCCOMB_X51_Y37_N28
\Add0~66\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~66_combout\ = ((\A[21]~input_o\ $ (\Add0~65_combout\ $ (!\Add0~64\)))) # (GND)
-- \Add0~67\ = CARRY((\A[21]~input_o\ & ((\Add0~65_combout\) # (!\Add0~64\))) # (!\A[21]~input_o\ & (\Add0~65_combout\ & !\Add0~64\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[21]~input_o\,
	datab => \Add0~65_combout\,
	datad => VCC,
	cin => \Add0~64\,
	combout => \Add0~66_combout\,
	cout => \Add0~67\);

-- Location: LCCOMB_X49_Y40_N26
\ShiftLeft0~81\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~81_combout\ = (\B[1]~input_o\ & ((\A[19]~input_o\))) # (!\B[1]~input_o\ & (\A[21]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[21]~input_o\,
	datac => \A[19]~input_o\,
	combout => \ShiftLeft0~81_combout\);

-- Location: LCCOMB_X49_Y40_N4
\ShiftLeft0~82\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~82_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~78_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~81_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~81_combout\,
	datab => \ShiftLeft0~78_combout\,
	datac => \B[0]~input_o\,
	combout => \ShiftLeft0~82_combout\);

-- Location: LCCOMB_X46_Y40_N0
\ShiftLeft0~83\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~83_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~70_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~82_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~82_combout\,
	datac => \B[2]~input_o\,
	datad => \ShiftLeft0~70_combout\,
	combout => \ShiftLeft0~83_combout\);

-- Location: LCCOMB_X47_Y41_N18
\Mux10~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~0_combout\ = (\Mux12~1_combout\ & (((!\Mux12~2_combout\)))) # (!\Mux12~1_combout\ & ((\Mux12~2_combout\ & (\ShiftRight0~75_combout\)) # (!\Mux12~2_combout\ & ((\ShiftLeft0~25_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~75_combout\,
	datab => \Mux12~1_combout\,
	datac => \ShiftLeft0~25_combout\,
	datad => \Mux12~2_combout\,
	combout => \Mux10~0_combout\);

-- Location: LCCOMB_X46_Y41_N6
\Mux10~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~1_combout\ = (\Mux12~0_combout\ & (((\Mux10~0_combout\)))) # (!\Mux12~0_combout\ & ((\Mux10~0_combout\ & (\ShiftLeft0~83_combout\)) # (!\Mux10~0_combout\ & ((\ShiftLeft0~54_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~0_combout\,
	datab => \ShiftLeft0~83_combout\,
	datac => \ShiftLeft0~54_combout\,
	datad => \Mux10~0_combout\,
	combout => \Mux10~1_combout\);

-- Location: LCCOMB_X46_Y41_N0
\Mux10~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~2_combout\ = (\Mux12~3_combout\ & ((\Mux12~4_combout\) # ((\Mux10~1_combout\)))) # (!\Mux12~3_combout\ & (!\Mux12~4_combout\ & (\Add0~66_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~3_combout\,
	datab => \Mux12~4_combout\,
	datac => \Add0~66_combout\,
	datad => \Mux10~1_combout\,
	combout => \Mux10~2_combout\);

-- Location: LCCOMB_X46_Y41_N10
\Mux10~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~3_combout\ = (\Mux10~2_combout\ & ((\A[31]~input_o\) # ((!\Mux12~4_combout\)))) # (!\Mux10~2_combout\ & (((\ShiftRight1~52_combout\ & \Mux12~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux10~2_combout\,
	datac => \ShiftRight1~52_combout\,
	datad => \Mux12~4_combout\,
	combout => \Mux10~3_combout\);

-- Location: LCCOMB_X54_Y39_N24
\Mux10~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux10~5_combout\ = (\Mux10~4_combout\ & (((\Mux10~3_combout\ & \Mux14~4_combout\)) # (!\Mux28~4_combout\))) # (!\Mux10~4_combout\ & (\Mux10~3_combout\ & (\Mux14~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux10~4_combout\,
	datab => \Mux10~3_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux10~5_combout\);

-- Location: LCCOMB_X54_Y39_N18
\Add0~68\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~68_combout\ = \B[22]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[22]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~68_combout\);

-- Location: LCCOMB_X51_Y37_N30
\Add0~69\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~69_combout\ = (\Add0~68_combout\ & ((\A[22]~input_o\ & (\Add0~67\ & VCC)) # (!\A[22]~input_o\ & (!\Add0~67\)))) # (!\Add0~68_combout\ & ((\A[22]~input_o\ & (!\Add0~67\)) # (!\A[22]~input_o\ & ((\Add0~67\) # (GND)))))
-- \Add0~70\ = CARRY((\Add0~68_combout\ & (!\A[22]~input_o\ & !\Add0~67\)) # (!\Add0~68_combout\ & ((!\Add0~67\) # (!\A[22]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~68_combout\,
	datab => \A[22]~input_o\,
	datad => VCC,
	cin => \Add0~67\,
	combout => \Add0~69_combout\,
	cout => \Add0~70\);

-- Location: LCCOMB_X46_Y38_N28
\Mux9~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~2_combout\ = (\Mux12~4_combout\ & ((\ShiftRight1~54_combout\) # ((\Mux12~3_combout\)))) # (!\Mux12~4_combout\ & (((\Add0~69_combout\ & !\Mux12~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \ShiftRight1~54_combout\,
	datac => \Add0~69_combout\,
	datad => \Mux12~3_combout\,
	combout => \Mux9~2_combout\);

-- Location: LCCOMB_X50_Y38_N26
\Mux9~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~0_combout\ = (\Mux12~1_combout\ & (!\Mux12~2_combout\)) # (!\Mux12~1_combout\ & ((\Mux12~2_combout\ & (\ShiftRight0~76_combout\)) # (!\Mux12~2_combout\ & ((\ShiftLeft0~28_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001101100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~1_combout\,
	datab => \Mux12~2_combout\,
	datac => \ShiftRight0~76_combout\,
	datad => \ShiftLeft0~28_combout\,
	combout => \Mux9~0_combout\);

-- Location: LCCOMB_X49_Y40_N6
\ShiftLeft0~84\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~84_combout\ = (\B[1]~input_o\ & ((\A[20]~input_o\))) # (!\B[1]~input_o\ & (\A[22]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A[22]~input_o\,
	datac => \A[20]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~84_combout\);

-- Location: LCCOMB_X49_Y40_N24
\ShiftLeft0~85\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~85_combout\ = (\B[0]~input_o\ & (\ShiftLeft0~81_combout\)) # (!\B[0]~input_o\ & ((\ShiftLeft0~84_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[0]~input_o\,
	datac => \ShiftLeft0~81_combout\,
	datad => \ShiftLeft0~84_combout\,
	combout => \ShiftLeft0~85_combout\);

-- Location: LCCOMB_X50_Y38_N24
\ShiftLeft0~86\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~86_combout\ = (\B[2]~input_o\ & (\ShiftLeft0~73_combout\)) # (!\B[2]~input_o\ & ((\ShiftLeft0~85_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \ShiftLeft0~73_combout\,
	datad => \ShiftLeft0~85_combout\,
	combout => \ShiftLeft0~86_combout\);

-- Location: LCCOMB_X50_Y38_N28
\Mux9~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~1_combout\ = (\Mux9~0_combout\ & ((\Mux12~0_combout\) # ((\ShiftLeft0~86_combout\)))) # (!\Mux9~0_combout\ & (!\Mux12~0_combout\ & (\ShiftLeft0~59_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux9~0_combout\,
	datab => \Mux12~0_combout\,
	datac => \ShiftLeft0~59_combout\,
	datad => \ShiftLeft0~86_combout\,
	combout => \Mux9~1_combout\);

-- Location: LCCOMB_X46_Y38_N6
\Mux9~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~3_combout\ = (\Mux9~2_combout\ & ((\A[31]~input_o\) # ((!\Mux12~3_combout\)))) # (!\Mux9~2_combout\ & (((\Mux9~1_combout\ & \Mux12~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux9~2_combout\,
	datac => \Mux9~1_combout\,
	datad => \Mux12~3_combout\,
	combout => \Mux9~3_combout\);

-- Location: LCCOMB_X54_Y39_N4
\Mux9~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~4_combout\ = (\B[22]~input_o\ & ((\A[22]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[22]~input_o\ & (\A[22]~input_o\ & \ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[22]~input_o\,
	datac => \A[22]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux9~4_combout\);

-- Location: LCCOMB_X54_Y39_N6
\Mux9~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux9~5_combout\ = (\Mux14~4_combout\ & ((\Mux9~3_combout\) # ((\Mux9~4_combout\ & !\Mux28~4_combout\)))) # (!\Mux14~4_combout\ & (((\Mux9~4_combout\ & !\Mux28~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~4_combout\,
	datab => \Mux9~3_combout\,
	datac => \Mux9~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux9~5_combout\);

-- Location: LCCOMB_X54_Y40_N14
\Mux8~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~4_combout\ = (\B[23]~input_o\ & ((\ALUOP[0]~input_o\) # (\A[23]~input_o\))) # (!\B[23]~input_o\ & (\ALUOP[0]~input_o\ & \A[23]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[23]~input_o\,
	datac => \ALUOP[0]~input_o\,
	datad => \A[23]~input_o\,
	combout => \Mux8~4_combout\);

-- Location: LCCOMB_X54_Y40_N4
\Add0~71\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~71_combout\ = \B[23]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[23]~input_o\,
	datac => \ALUOP[0]~input_o\,
	combout => \Add0~71_combout\);

-- Location: LCCOMB_X51_Y36_N0
\Add0~72\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~72_combout\ = ((\Add0~71_combout\ $ (\A[23]~input_o\ $ (!\Add0~70\)))) # (GND)
-- \Add0~73\ = CARRY((\Add0~71_combout\ & ((\A[23]~input_o\) # (!\Add0~70\))) # (!\Add0~71_combout\ & (\A[23]~input_o\ & !\Add0~70\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~71_combout\,
	datab => \A[23]~input_o\,
	datad => VCC,
	cin => \Add0~70\,
	combout => \Add0~72_combout\,
	cout => \Add0~73\);

-- Location: LCCOMB_X49_Y40_N18
\ShiftLeft0~87\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~87_combout\ = (\B[1]~input_o\ & (\A[21]~input_o\)) # (!\B[1]~input_o\ & ((\A[23]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \A[21]~input_o\,
	datad => \A[23]~input_o\,
	combout => \ShiftLeft0~87_combout\);

-- Location: LCCOMB_X49_Y40_N20
\ShiftLeft0~88\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~88_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~84_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~87_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ShiftLeft0~87_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~84_combout\,
	combout => \ShiftLeft0~88_combout\);

-- Location: LCCOMB_X47_Y40_N30
\ShiftLeft0~89\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~89_combout\ = (\B[2]~input_o\ & ((\ShiftLeft0~76_combout\))) # (!\B[2]~input_o\ & (\ShiftLeft0~88_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~88_combout\,
	datac => \ShiftLeft0~76_combout\,
	combout => \ShiftLeft0~89_combout\);

-- Location: LCCOMB_X47_Y41_N20
\Mux8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~0_combout\ = (\Mux12~2_combout\ & (((!\Mux12~1_combout\ & \ShiftRight0~64_combout\)))) # (!\Mux12~2_combout\ & ((\ShiftLeft0~32_combout\) # ((\Mux12~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~32_combout\,
	datab => \Mux12~2_combout\,
	datac => \Mux12~1_combout\,
	datad => \ShiftRight0~64_combout\,
	combout => \Mux8~0_combout\);

-- Location: LCCOMB_X47_Y40_N8
\Mux8~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~1_combout\ = (\Mux12~0_combout\ & (((\Mux8~0_combout\)))) # (!\Mux12~0_combout\ & ((\Mux8~0_combout\ & (\ShiftLeft0~89_combout\)) # (!\Mux8~0_combout\ & ((\ShiftLeft0~64_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~89_combout\,
	datab => \Mux12~0_combout\,
	datac => \ShiftLeft0~64_combout\,
	datad => \Mux8~0_combout\,
	combout => \Mux8~1_combout\);

-- Location: LCCOMB_X51_Y39_N2
\Mux8~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~2_combout\ = (\Mux12~4_combout\ & (\Mux12~3_combout\)) # (!\Mux12~4_combout\ & ((\Mux12~3_combout\ & ((\Mux8~1_combout\))) # (!\Mux12~3_combout\ & (\Add0~72_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux12~3_combout\,
	datac => \Add0~72_combout\,
	datad => \Mux8~1_combout\,
	combout => \Mux8~2_combout\);

-- Location: LCCOMB_X51_Y39_N4
\Mux8~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~3_combout\ = (\Mux12~4_combout\ & ((\Mux8~2_combout\ & (\A[31]~input_o\)) # (!\Mux8~2_combout\ & ((\ShiftRight1~58_combout\))))) # (!\Mux12~4_combout\ & (\Mux8~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux12~4_combout\,
	datab => \Mux8~2_combout\,
	datac => \A[31]~input_o\,
	datad => \ShiftRight1~58_combout\,
	combout => \Mux8~3_combout\);

-- Location: LCCOMB_X54_Y40_N24
\Mux8~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux8~5_combout\ = (\Mux14~4_combout\ & ((\Mux8~3_combout\) # ((\Mux8~4_combout\ & !\Mux28~4_combout\)))) # (!\Mux14~4_combout\ & (\Mux8~4_combout\ & (!\Mux28~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~4_combout\,
	datab => \Mux8~4_combout\,
	datac => \Mux28~4_combout\,
	datad => \Mux8~3_combout\,
	combout => \Mux8~5_combout\);

-- Location: LCCOMB_X51_Y36_N28
\Add0~74\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~74_combout\ = \B[24]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[24]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~74_combout\);

-- Location: LCCOMB_X51_Y36_N2
\Add0~75\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~75_combout\ = (\A[24]~input_o\ & ((\Add0~74_combout\ & (\Add0~73\ & VCC)) # (!\Add0~74_combout\ & (!\Add0~73\)))) # (!\A[24]~input_o\ & ((\Add0~74_combout\ & (!\Add0~73\)) # (!\Add0~74_combout\ & ((\Add0~73\) # (GND)))))
-- \Add0~76\ = CARRY((\A[24]~input_o\ & (!\Add0~74_combout\ & !\Add0~73\)) # (!\A[24]~input_o\ & ((!\Add0~73\) # (!\Add0~74_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[24]~input_o\,
	datab => \Add0~74_combout\,
	datad => VCC,
	cin => \Add0~73\,
	combout => \Add0~75_combout\,
	cout => \Add0~76\);

-- Location: LCCOMB_X47_Y37_N6
\Mux7~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~5_combout\ = (\ALUOP[1]~input_o\ & ((\B[4]~input_o\))) # (!\ALUOP[1]~input_o\ & (\ALUOP[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux7~5_combout\);

-- Location: LCCOMB_X49_Y40_N30
\ShiftLeft0~90\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~90_combout\ = (\B[1]~input_o\ & (\A[22]~input_o\)) # (!\B[1]~input_o\ & ((\A[24]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[22]~input_o\,
	datad => \A[24]~input_o\,
	combout => \ShiftLeft0~90_combout\);

-- Location: LCCOMB_X49_Y40_N16
\ShiftLeft0~91\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~91_combout\ = (\B[0]~input_o\ & ((\ShiftLeft0~87_combout\))) # (!\B[0]~input_o\ & (\ShiftLeft0~90_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~90_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~87_combout\,
	combout => \ShiftLeft0~91_combout\);

-- Location: LCCOMB_X47_Y40_N12
\Mux7~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~1_combout\ = (\B[4]~input_o\) # ((\B[2]~input_o\ & !\B[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \B[4]~input_o\,
	datad => \B[3]~input_o\,
	combout => \Mux7~1_combout\);

-- Location: LCCOMB_X47_Y40_N18
\Mux7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = (\B[4]~input_o\) # (\B[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[4]~input_o\,
	datad => \B[3]~input_o\,
	combout => \Mux7~0_combout\);

-- Location: LCCOMB_X46_Y40_N26
\Mux7~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~2_combout\ = (\Mux7~1_combout\ & ((\ShiftLeft0~79_combout\) # ((\Mux7~0_combout\)))) # (!\Mux7~1_combout\ & (((\ShiftLeft0~91_combout\ & !\Mux7~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~79_combout\,
	datab => \ShiftLeft0~91_combout\,
	datac => \Mux7~1_combout\,
	datad => \Mux7~0_combout\,
	combout => \Mux7~2_combout\);

-- Location: LCCOMB_X46_Y40_N4
\Mux7~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~3_combout\ = (\Mux7~2_combout\ & (((\ShiftLeft0~37_combout\) # (!\Mux7~0_combout\)))) # (!\Mux7~2_combout\ & (\ShiftLeft0~68_combout\ & ((\Mux7~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~2_combout\,
	datab => \ShiftLeft0~68_combout\,
	datac => \ShiftLeft0~37_combout\,
	datad => \Mux7~0_combout\,
	combout => \Mux7~3_combout\);

-- Location: LCCOMB_X47_Y37_N20
\Mux7~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~4_combout\ = (!\ALUOP[1]~input_o\ & ((!\B[4]~input_o\) # (!\ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux7~4_combout\);

-- Location: LCCOMB_X47_Y37_N24
\Mux7~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~6_combout\ = (\Mux7~5_combout\ & (\ShiftRight0~66_combout\ & ((\Mux7~4_combout\)))) # (!\Mux7~5_combout\ & (((\Mux7~3_combout\) # (!\Mux7~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~5_combout\,
	datab => \ShiftRight0~66_combout\,
	datac => \Mux7~3_combout\,
	datad => \Mux7~4_combout\,
	combout => \Mux7~6_combout\);

-- Location: LCCOMB_X47_Y37_N18
\ShiftRight1~61\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~61_combout\ = (\ShiftRight0~66_combout\) # ((\A[31]~input_o\ & \B[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \ShiftRight0~66_combout\,
	datac => \B[3]~input_o\,
	combout => \ShiftRight1~61_combout\);

-- Location: LCCOMB_X47_Y37_N26
\Mux7~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~7_combout\ = (\Mux7~6_combout\ & (((\ShiftRight1~61_combout\) # (!\ALUOP[1]~input_o\)))) # (!\Mux7~6_combout\ & (\A[31]~input_o\ & (\ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux7~6_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ShiftRight1~61_combout\,
	combout => \Mux7~7_combout\);

-- Location: LCCOMB_X52_Y37_N20
\Mux7~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~8_combout\ = (\Mux28~5_combout\ & (((\Mux14~4_combout\ & \Mux7~7_combout\)))) # (!\Mux28~5_combout\ & ((\Add0~75_combout\) # ((!\Mux14~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010101000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \Add0~75_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux7~7_combout\,
	combout => \Mux7~8_combout\);

-- Location: LCCOMB_X51_Y36_N22
Mux7 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~combout\ = (\Mux28~4_combout\ & (((\Mux7~8_combout\)))) # (!\Mux28~4_combout\ & ((\A[24]~input_o\ & ((\B[24]~input_o\) # (!\Mux7~8_combout\))) # (!\A[24]~input_o\ & (\B[24]~input_o\ & !\Mux7~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[24]~input_o\,
	datab => \Mux28~4_combout\,
	datac => \B[24]~input_o\,
	datad => \Mux7~8_combout\,
	combout => \Mux7~combout\);

-- Location: LCCOMB_X49_Y40_N10
\ShiftLeft0~92\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~92_combout\ = (!\B[0]~input_o\ & ((\B[1]~input_o\ & ((\A[23]~input_o\))) # (!\B[1]~input_o\ & (\A[25]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[25]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[23]~input_o\,
	combout => \ShiftLeft0~92_combout\);

-- Location: LCCOMB_X49_Y40_N28
\ShiftLeft0~93\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~93_combout\ = (\ShiftLeft0~92_combout\) # ((\ShiftLeft0~90_combout\ & \B[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~90_combout\,
	datac => \B[0]~input_o\,
	datad => \ShiftLeft0~92_combout\,
	combout => \ShiftLeft0~93_combout\);

-- Location: LCCOMB_X46_Y40_N6
\Mux6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (\Mux7~0_combout\ & (((\Mux7~1_combout\) # (\ShiftLeft0~71_combout\)))) # (!\Mux7~0_combout\ & (\ShiftLeft0~93_combout\ & (!\Mux7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~93_combout\,
	datab => \Mux7~0_combout\,
	datac => \Mux7~1_combout\,
	datad => \ShiftLeft0~71_combout\,
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X46_Y40_N8
\Mux6~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~1_combout\ = (\Mux6~0_combout\ & (((\ShiftLeft0~104_combout\)) # (!\Mux7~1_combout\))) # (!\Mux6~0_combout\ & (\Mux7~1_combout\ & (\ShiftLeft0~82_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux6~0_combout\,
	datab => \Mux7~1_combout\,
	datac => \ShiftLeft0~82_combout\,
	datad => \ShiftLeft0~104_combout\,
	combout => \Mux6~1_combout\);

-- Location: LCCOMB_X47_Y37_N12
\Mux6~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~2_combout\ = (\Mux7~5_combout\ & (\Mux7~4_combout\ & (\ShiftRight0~67_combout\))) # (!\Mux7~5_combout\ & (((\Mux6~1_combout\)) # (!\Mux7~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~5_combout\,
	datab => \Mux7~4_combout\,
	datac => \ShiftRight0~67_combout\,
	datad => \Mux6~1_combout\,
	combout => \Mux6~2_combout\);

-- Location: LCCOMB_X47_Y38_N28
\Mux6~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~3_combout\ = (\Mux6~2_combout\ & (((\ShiftRight1~59_combout\)) # (!\ALUOP[1]~input_o\))) # (!\Mux6~2_combout\ & (\ALUOP[1]~input_o\ & ((\A[31]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux6~2_combout\,
	datab => \ALUOP[1]~input_o\,
	datac => \ShiftRight1~59_combout\,
	datad => \A[31]~input_o\,
	combout => \Mux6~3_combout\);

-- Location: LCCOMB_X51_Y36_N24
\Add0~77\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~77_combout\ = \ALUOP[0]~input_o\ $ (\B[25]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datad => \B[25]~input_o\,
	combout => \Add0~77_combout\);

-- Location: LCCOMB_X51_Y36_N4
\Add0~78\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~78_combout\ = ((\A[25]~input_o\ $ (\Add0~77_combout\ $ (!\Add0~76\)))) # (GND)
-- \Add0~79\ = CARRY((\A[25]~input_o\ & ((\Add0~77_combout\) # (!\Add0~76\))) # (!\A[25]~input_o\ & (\Add0~77_combout\ & !\Add0~76\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[25]~input_o\,
	datab => \Add0~77_combout\,
	datad => VCC,
	cin => \Add0~76\,
	combout => \Add0~78_combout\,
	cout => \Add0~79\);

-- Location: LCCOMB_X49_Y38_N18
\Mux6~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~4_combout\ = (\Mux14~4_combout\ & ((\Mux28~5_combout\ & (\Mux6~3_combout\)) # (!\Mux28~5_combout\ & ((\Add0~78_combout\))))) # (!\Mux14~4_combout\ & (((!\Mux28~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~4_combout\,
	datab => \Mux6~3_combout\,
	datac => \Add0~78_combout\,
	datad => \Mux28~5_combout\,
	combout => \Mux6~4_combout\);

-- Location: LCCOMB_X49_Y38_N12
Mux6 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~combout\ = (\Mux28~4_combout\ & (\Mux6~4_combout\)) # (!\Mux28~4_combout\ & ((\Mux6~4_combout\ & (\A[25]~input_o\ & \B[25]~input_o\)) # (!\Mux6~4_combout\ & ((\A[25]~input_o\) # (\B[25]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100110011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~4_combout\,
	datab => \Mux6~4_combout\,
	datac => \A[25]~input_o\,
	datad => \B[25]~input_o\,
	combout => \Mux6~combout\);

-- Location: LCCOMB_X49_Y38_N30
\ShiftLeft0~95\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~95_combout\ = (\B[0]~input_o\ & (\A[25]~input_o\)) # (!\B[0]~input_o\ & ((\A[26]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[25]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[26]~input_o\,
	combout => \ShiftLeft0~95_combout\);

-- Location: LCCOMB_X49_Y40_N22
\ShiftLeft0~94\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~94_combout\ = (\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[23]~input_o\))) # (!\B[0]~input_o\ & (\A[24]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \A[24]~input_o\,
	datac => \B[0]~input_o\,
	datad => \A[23]~input_o\,
	combout => \ShiftLeft0~94_combout\);

-- Location: LCCOMB_X46_Y40_N10
\ShiftLeft0~96\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~96_combout\ = (\ShiftLeft0~94_combout\) # ((!\B[1]~input_o\ & \ShiftLeft0~95_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \ShiftLeft0~95_combout\,
	datad => \ShiftLeft0~94_combout\,
	combout => \ShiftLeft0~96_combout\);

-- Location: LCCOMB_X46_Y40_N28
\Mux5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (\Mux7~0_combout\ & (((\Mux7~1_combout\)))) # (!\Mux7~0_combout\ & ((\Mux7~1_combout\ & ((\ShiftLeft0~85_combout\))) # (!\Mux7~1_combout\ & (\ShiftLeft0~96_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~96_combout\,
	datab => \Mux7~0_combout\,
	datac => \Mux7~1_combout\,
	datad => \ShiftLeft0~85_combout\,
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X46_Y40_N22
\Mux5~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~1_combout\ = (\Mux7~0_combout\ & ((\Mux5~0_combout\ & (\ShiftLeft0~105_combout\)) # (!\Mux5~0_combout\ & ((\ShiftLeft0~74_combout\))))) # (!\Mux7~0_combout\ & (((\Mux5~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~105_combout\,
	datab => \Mux7~0_combout\,
	datac => \ShiftLeft0~74_combout\,
	datad => \Mux5~0_combout\,
	combout => \Mux5~1_combout\);

-- Location: LCCOMB_X47_Y37_N14
\Mux5~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~2_combout\ = (\Mux7~5_combout\ & (\Mux7~4_combout\ & (\ShiftRight0~68_combout\))) # (!\Mux7~5_combout\ & (((\Mux5~1_combout\)) # (!\Mux7~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~5_combout\,
	datab => \Mux7~4_combout\,
	datac => \ShiftRight0~68_combout\,
	datad => \Mux5~1_combout\,
	combout => \Mux5~2_combout\);

-- Location: LCCOMB_X50_Y37_N6
\ShiftRight1~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~62_combout\ = (\B[3]~input_o\ & ((\A[31]~input_o\))) # (!\B[3]~input_o\ & (\ShiftRight1~36_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~36_combout\,
	datac => \A[31]~input_o\,
	datad => \B[3]~input_o\,
	combout => \ShiftRight1~62_combout\);

-- Location: LCCOMB_X50_Y37_N0
\Mux5~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~3_combout\ = (\Mux5~2_combout\ & (((\ShiftRight1~62_combout\)) # (!\ALUOP[1]~input_o\))) # (!\Mux5~2_combout\ & (\ALUOP[1]~input_o\ & (\A[31]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux5~2_combout\,
	datab => \ALUOP[1]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ShiftRight1~62_combout\,
	combout => \Mux5~3_combout\);

-- Location: LCCOMB_X51_Y36_N18
\Add0~80\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~80_combout\ = \ALUOP[0]~input_o\ $ (\B[26]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datad => \B[26]~input_o\,
	combout => \Add0~80_combout\);

-- Location: LCCOMB_X51_Y36_N6
\Add0~81\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~81_combout\ = (\A[26]~input_o\ & ((\Add0~80_combout\ & (\Add0~79\ & VCC)) # (!\Add0~80_combout\ & (!\Add0~79\)))) # (!\A[26]~input_o\ & ((\Add0~80_combout\ & (!\Add0~79\)) # (!\Add0~80_combout\ & ((\Add0~79\) # (GND)))))
-- \Add0~82\ = CARRY((\A[26]~input_o\ & (!\Add0~80_combout\ & !\Add0~79\)) # (!\A[26]~input_o\ & ((!\Add0~79\) # (!\Add0~80_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[26]~input_o\,
	datab => \Add0~80_combout\,
	datad => VCC,
	cin => \Add0~79\,
	combout => \Add0~81_combout\,
	cout => \Add0~82\);

-- Location: LCCOMB_X49_Y38_N8
\Mux5~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~4_combout\ = (\Mux14~4_combout\ & ((\Mux28~5_combout\ & (\Mux5~3_combout\)) # (!\Mux28~5_combout\ & ((\Add0~81_combout\))))) # (!\Mux14~4_combout\ & (((!\Mux28~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux14~4_combout\,
	datab => \Mux5~3_combout\,
	datac => \Add0~81_combout\,
	datad => \Mux28~5_combout\,
	combout => \Mux5~4_combout\);

-- Location: LCCOMB_X49_Y38_N10
Mux5 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~combout\ = (\Mux5~4_combout\ & ((\Mux28~4_combout\) # ((\B[26]~input_o\ & \A[26]~input_o\)))) # (!\Mux5~4_combout\ & (!\Mux28~4_combout\ & ((\B[26]~input_o\) # (\A[26]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[26]~input_o\,
	datab => \Mux5~4_combout\,
	datac => \A[26]~input_o\,
	datad => \Mux28~4_combout\,
	combout => \Mux5~combout\);

-- Location: LCCOMB_X51_Y36_N20
\Add0~83\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~83_combout\ = \B[27]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[27]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~83_combout\);

-- Location: LCCOMB_X51_Y36_N8
\Add0~84\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~84_combout\ = ((\Add0~83_combout\ $ (\A[27]~input_o\ $ (!\Add0~82\)))) # (GND)
-- \Add0~85\ = CARRY((\Add0~83_combout\ & ((\A[27]~input_o\) # (!\Add0~82\))) # (!\Add0~83_combout\ & (\A[27]~input_o\ & !\Add0~82\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~83_combout\,
	datab => \A[27]~input_o\,
	datad => VCC,
	cin => \Add0~82\,
	combout => \Add0~84_combout\,
	cout => \Add0~85\);

-- Location: LCCOMB_X49_Y38_N4
\ShiftLeft0~97\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~97_combout\ = (\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[24]~input_o\))) # (!\B[0]~input_o\ & (\A[25]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[25]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[24]~input_o\,
	datad => \B[1]~input_o\,
	combout => \ShiftLeft0~97_combout\);

-- Location: LCCOMB_X49_Y38_N14
\ShiftLeft0~98\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~98_combout\ = (\B[0]~input_o\ & (\A[26]~input_o\)) # (!\B[0]~input_o\ & ((\A[27]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datac => \A[26]~input_o\,
	datad => \A[27]~input_o\,
	combout => \ShiftLeft0~98_combout\);

-- Location: LCCOMB_X51_Y38_N14
\ShiftLeft0~99\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~99_combout\ = (\ShiftLeft0~97_combout\) # ((!\B[1]~input_o\ & \ShiftLeft0~98_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datac => \ShiftLeft0~97_combout\,
	datad => \ShiftLeft0~98_combout\,
	combout => \ShiftLeft0~99_combout\);

-- Location: LCCOMB_X47_Y40_N6
\Mux4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (\Mux7~1_combout\ & (\Mux7~0_combout\)) # (!\Mux7~1_combout\ & ((\Mux7~0_combout\ & (\ShiftLeft0~77_combout\)) # (!\Mux7~0_combout\ & ((\ShiftLeft0~99_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~1_combout\,
	datab => \Mux7~0_combout\,
	datac => \ShiftLeft0~77_combout\,
	datad => \ShiftLeft0~99_combout\,
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X47_Y40_N16
\Mux4~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~1_combout\ = (\Mux7~1_combout\ & ((\Mux4~0_combout\ & ((\ShiftLeft0~106_combout\))) # (!\Mux4~0_combout\ & (\ShiftLeft0~88_combout\)))) # (!\Mux7~1_combout\ & (((\Mux4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~1_combout\,
	datab => \ShiftLeft0~88_combout\,
	datac => \Mux4~0_combout\,
	datad => \ShiftLeft0~106_combout\,
	combout => \Mux4~1_combout\);

-- Location: LCCOMB_X47_Y37_N0
\Mux4~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~2_combout\ = (\Mux7~5_combout\ & (((\ShiftRight0~70_combout\ & \Mux7~4_combout\)))) # (!\Mux7~5_combout\ & ((\Mux4~1_combout\) # ((!\Mux7~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux7~5_combout\,
	datab => \Mux4~1_combout\,
	datac => \ShiftRight0~70_combout\,
	datad => \Mux7~4_combout\,
	combout => \Mux4~2_combout\);

-- Location: LCCOMB_X51_Y39_N12
\ShiftRight1~63\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~63_combout\ = (\B[3]~input_o\ & (\A[31]~input_o\)) # (!\B[3]~input_o\ & ((\B[2]~input_o\ & (\A[31]~input_o\)) # (!\B[2]~input_o\ & ((\ShiftRight1~47_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \B[3]~input_o\,
	datac => \B[2]~input_o\,
	datad => \ShiftRight1~47_combout\,
	combout => \ShiftRight1~63_combout\);

-- Location: LCCOMB_X49_Y38_N24
\Mux4~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~3_combout\ = (\Mux4~2_combout\ & (((\ShiftRight1~63_combout\) # (!\ALUOP[1]~input_o\)))) # (!\Mux4~2_combout\ & (\A[31]~input_o\ & (\ALUOP[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux4~2_combout\,
	datab => \A[31]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \ShiftRight1~63_combout\,
	combout => \Mux4~3_combout\);

-- Location: LCCOMB_X49_Y38_N26
\Mux4~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~4_combout\ = (\Mux14~4_combout\ & ((\Mux28~5_combout\ & ((\Mux4~3_combout\))) # (!\Mux28~5_combout\ & (\Add0~84_combout\)))) # (!\Mux14~4_combout\ & (((!\Mux28~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000010101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~84_combout\,
	datab => \Mux4~3_combout\,
	datac => \Mux14~4_combout\,
	datad => \Mux28~5_combout\,
	combout => \Mux4~4_combout\);

-- Location: LCCOMB_X49_Y38_N20
Mux4 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~combout\ = (\Mux4~4_combout\ & ((\Mux28~4_combout\) # ((\A[27]~input_o\ & \B[27]~input_o\)))) # (!\Mux4~4_combout\ & (!\Mux28~4_combout\ & ((\A[27]~input_o\) # (\B[27]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[27]~input_o\,
	datab => \B[27]~input_o\,
	datac => \Mux4~4_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux4~combout\);

-- Location: LCCOMB_X51_Y36_N30
\Add0~86\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~86_combout\ = \ALUOP[0]~input_o\ $ (\B[28]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datad => \B[28]~input_o\,
	combout => \Add0~86_combout\);

-- Location: LCCOMB_X51_Y36_N10
\Add0~87\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~87_combout\ = (\Add0~86_combout\ & ((\A[28]~input_o\ & (\Add0~85\ & VCC)) # (!\A[28]~input_o\ & (!\Add0~85\)))) # (!\Add0~86_combout\ & ((\A[28]~input_o\ & (!\Add0~85\)) # (!\A[28]~input_o\ & ((\Add0~85\) # (GND)))))
-- \Add0~88\ = CARRY((\Add0~86_combout\ & (!\A[28]~input_o\ & !\Add0~85\)) # (!\Add0~86_combout\ & ((!\Add0~85\) # (!\A[28]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~86_combout\,
	datab => \A[28]~input_o\,
	datad => VCC,
	cin => \Add0~85\,
	combout => \Add0~87_combout\,
	cout => \Add0~88\);

-- Location: LCCOMB_X50_Y42_N18
\Mux3~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~10_combout\ = (\Mux28~5_combout\ & ((\Mux28~4_combout\) # ((\A[28]~input_o\) # (\B[28]~input_o\)))) # (!\Mux28~5_combout\ & (!\Mux28~4_combout\ & (\A[28]~input_o\ & \B[28]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \Mux28~4_combout\,
	datac => \A[28]~input_o\,
	datad => \B[28]~input_o\,
	combout => \Mux3~10_combout\);

-- Location: LCCOMB_X45_Y40_N12
\ShiftLeft0~100\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~100_combout\ = (\B[0]~input_o\ & ((\A[27]~input_o\))) # (!\B[0]~input_o\ & (\A[28]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[28]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[27]~input_o\,
	combout => \ShiftLeft0~100_combout\);

-- Location: LCCOMB_X46_Y40_N24
\Mux3~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~2_combout\ = (\ShiftRight0~35_combout\ & (\ShiftLeft0~100_combout\ & (!\Mux28~1_combout\))) # (!\ShiftRight0~35_combout\ & (((\Mux28~1_combout\) # (\ShiftLeft0~91_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~100_combout\,
	datab => \ShiftRight0~35_combout\,
	datac => \Mux28~1_combout\,
	datad => \ShiftLeft0~91_combout\,
	combout => \Mux3~2_combout\);

-- Location: LCCOMB_X46_Y40_N2
\Mux3~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~3_combout\ = (\Mux28~1_combout\ & ((\Mux3~2_combout\ & ((\ShiftLeft0~80_combout\))) # (!\Mux3~2_combout\ & (\ShiftLeft0~95_combout\)))) # (!\Mux28~1_combout\ & (\Mux3~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~1_combout\,
	datab => \Mux3~2_combout\,
	datac => \ShiftLeft0~95_combout\,
	datad => \ShiftLeft0~80_combout\,
	combout => \Mux3~3_combout\);

-- Location: LCCOMB_X50_Y42_N30
\Mux3~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~4_combout\ = (\ALUOP[1]~input_o\) # (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[1]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux3~4_combout\);

-- Location: LCCOMB_X49_Y42_N20
\ShiftRight1~64\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftRight1~64_combout\ = (\B[2]~input_o\ & (((\A[31]~input_o\)))) # (!\B[2]~input_o\ & ((\B[3]~input_o\ & (\A[31]~input_o\)) # (!\B[3]~input_o\ & ((\ShiftRight0~28_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ShiftRight0~28_combout\,
	combout => \ShiftRight1~64_combout\);

-- Location: LCCOMB_X49_Y42_N28
\Mux3~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~7_combout\ = (\ALUOP[1]~input_o\) # ((!\ALUOP[0]~input_o\ & \B[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \ALUOP[0]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux3~7_combout\);

-- Location: LCCOMB_X49_Y42_N26
\Mux3~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~6_combout\ = \ALUOP[0]~input_o\ $ (!\ALUOP[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ALUOP[0]~input_o\,
	datac => \ALUOP[1]~input_o\,
	combout => \Mux3~6_combout\);

-- Location: LCCOMB_X49_Y42_N6
\Mux0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (!\B[2]~input_o\ & (!\B[3]~input_o\ & !\B[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datad => \B[4]~input_o\,
	combout => \Mux0~0_combout\);

-- Location: LCCOMB_X49_Y42_N0
\Mux3~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~5_combout\ = (\Mux0~0_combout\ & ((\ShiftRight0~27_combout\) # ((\B[1]~input_o\ & \ShiftRight1~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight0~27_combout\,
	datab => \B[1]~input_o\,
	datac => \ShiftRight1~18_combout\,
	datad => \Mux0~0_combout\,
	combout => \Mux3~5_combout\);

-- Location: LCCOMB_X49_Y42_N14
\Mux3~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~8_combout\ = (\Mux3~7_combout\ & (\ShiftRight1~64_combout\ & (!\Mux3~6_combout\))) # (!\Mux3~7_combout\ & (((\Mux3~6_combout\) # (\Mux3~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftRight1~64_combout\,
	datab => \Mux3~7_combout\,
	datac => \Mux3~6_combout\,
	datad => \Mux3~5_combout\,
	combout => \Mux3~8_combout\);

-- Location: LCCOMB_X50_Y42_N8
\Mux3~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~9_combout\ = (\Mux3~4_combout\ & (((\Mux3~8_combout\)))) # (!\Mux3~4_combout\ & ((\Mux3~8_combout\ & ((\Mux3~3_combout\))) # (!\Mux3~8_combout\ & (\ShiftLeft0~50_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~50_combout\,
	datab => \Mux3~3_combout\,
	datac => \Mux3~4_combout\,
	datad => \Mux3~8_combout\,
	combout => \Mux3~9_combout\);

-- Location: LCCOMB_X50_Y42_N12
\Mux3~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~11_combout\ = (\Mux3~10_combout\ & (((\Mux3~9_combout\) # (!\Mux28~4_combout\)))) # (!\Mux3~10_combout\ & (\Add0~87_combout\ & ((\Mux28~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~87_combout\,
	datab => \Mux3~10_combout\,
	datac => \Mux3~9_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux3~11_combout\);

-- Location: LCCOMB_X50_Y42_N22
\Mux3~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~12_combout\ = (\Mux3~1_combout\ & (\A[31]~input_o\)) # (!\Mux3~1_combout\ & ((\Mux3~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux3~1_combout\,
	datad => \Mux3~11_combout\,
	combout => \Mux3~12_combout\);

-- Location: LCCOMB_X45_Y40_N14
\ShiftLeft0~101\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ShiftLeft0~101_combout\ = (\B[0]~input_o\ & (\A[28]~input_o\)) # (!\B[0]~input_o\ & ((\A[29]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datac => \A[28]~input_o\,
	datad => \A[29]~input_o\,
	combout => \ShiftLeft0~101_combout\);

-- Location: LCCOMB_X46_Y40_N12
\Mux2~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~3_combout\ = (\Mux28~1_combout\ & (!\ShiftRight0~35_combout\)) # (!\Mux28~1_combout\ & ((\ShiftRight0~35_combout\ & ((\ShiftLeft0~101_combout\))) # (!\ShiftRight0~35_combout\ & (\ShiftLeft0~93_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~1_combout\,
	datab => \ShiftRight0~35_combout\,
	datac => \ShiftLeft0~93_combout\,
	datad => \ShiftLeft0~101_combout\,
	combout => \Mux2~3_combout\);

-- Location: LCCOMB_X46_Y40_N14
\Mux2~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~4_combout\ = (\Mux2~3_combout\ & ((\ShiftLeft0~83_combout\) # ((!\Mux28~1_combout\)))) # (!\Mux2~3_combout\ & (((\Mux28~1_combout\ & \ShiftLeft0~98_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux2~3_combout\,
	datab => \ShiftLeft0~83_combout\,
	datac => \Mux28~1_combout\,
	datad => \ShiftLeft0~98_combout\,
	combout => \Mux2~4_combout\);

-- Location: LCCOMB_X49_Y42_N22
\Mux2~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~9_combout\ = (!\B[2]~input_o\ & (!\B[3]~input_o\ & (\ShiftRight0~44_combout\ & !\B[4]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \ShiftRight0~44_combout\,
	datad => \B[4]~input_o\,
	combout => \Mux2~9_combout\);

-- Location: LCCOMB_X49_Y42_N8
\Mux2~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~5_combout\ = (\Mux3~7_combout\ & (((!\Mux3~6_combout\ & \ShiftRight1~55_combout\)))) # (!\Mux3~7_combout\ & ((\Mux2~9_combout\) # ((\Mux3~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux2~9_combout\,
	datab => \Mux3~7_combout\,
	datac => \Mux3~6_combout\,
	datad => \ShiftRight1~55_combout\,
	combout => \Mux2~5_combout\);

-- Location: LCCOMB_X50_Y42_N26
\Mux2~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~6_combout\ = (\Mux3~4_combout\ & (((\Mux2~5_combout\)))) # (!\Mux3~4_combout\ & ((\Mux2~5_combout\ & (\Mux2~4_combout\)) # (!\Mux2~5_combout\ & ((\ShiftLeft0~55_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux2~4_combout\,
	datab => \ShiftLeft0~55_combout\,
	datac => \Mux3~4_combout\,
	datad => \Mux2~5_combout\,
	combout => \Mux2~6_combout\);

-- Location: LCCOMB_X50_Y42_N16
\Mux2~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~2_combout\ = (\Mux28~5_combout\ & ((\Mux28~4_combout\) # ((\A[29]~input_o\) # (\B[29]~input_o\)))) # (!\Mux28~5_combout\ & (!\Mux28~4_combout\ & (\A[29]~input_o\ & \B[29]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~5_combout\,
	datab => \Mux28~4_combout\,
	datac => \A[29]~input_o\,
	datad => \B[29]~input_o\,
	combout => \Mux2~2_combout\);

-- Location: LCCOMB_X50_Y37_N18
\Add0~89\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~89_combout\ = \B[29]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[29]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~89_combout\);

-- Location: LCCOMB_X51_Y36_N12
\Add0~90\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~90_combout\ = ((\Add0~89_combout\ $ (\A[29]~input_o\ $ (!\Add0~88\)))) # (GND)
-- \Add0~91\ = CARRY((\Add0~89_combout\ & ((\A[29]~input_o\) # (!\Add0~88\))) # (!\Add0~89_combout\ & (\A[29]~input_o\ & !\Add0~88\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~89_combout\,
	datab => \A[29]~input_o\,
	datad => VCC,
	cin => \Add0~88\,
	combout => \Add0~90_combout\,
	cout => \Add0~91\);

-- Location: LCCOMB_X50_Y42_N28
\Mux2~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~7_combout\ = (\Mux2~2_combout\ & ((\Mux2~6_combout\) # ((!\Mux28~4_combout\)))) # (!\Mux2~2_combout\ & (((\Add0~90_combout\ & \Mux28~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux2~6_combout\,
	datab => \Mux2~2_combout\,
	datac => \Add0~90_combout\,
	datad => \Mux28~4_combout\,
	combout => \Mux2~7_combout\);

-- Location: LCCOMB_X50_Y42_N14
\Mux2~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~8_combout\ = (\Mux3~1_combout\ & (\A[31]~input_o\)) # (!\Mux3~1_combout\ & ((\Mux2~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[31]~input_o\,
	datab => \Mux3~1_combout\,
	datad => \Mux2~7_combout\,
	combout => \Mux2~8_combout\);

-- Location: LCCOMB_X50_Y36_N6
\Mux1~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~1_combout\ = (!\ALUOP[2]~input_o\ & ((\A[30]~input_o\ & ((\B[30]~input_o\) # (\ALUOP[0]~input_o\))) # (!\A[30]~input_o\ & (\B[30]~input_o\ & \ALUOP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[2]~input_o\,
	datab => \A[30]~input_o\,
	datac => \B[30]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux1~1_combout\);

-- Location: LCCOMB_X50_Y36_N0
\Mux1~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~2_combout\ = (!\ALUOP[1]~input_o\ & ((\Mux1~1_combout\) # ((\Mux1~0_combout\ & \ShiftRight0~78_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux1~0_combout\,
	datab => \Mux1~1_combout\,
	datac => \ALUOP[1]~input_o\,
	datad => \ShiftRight0~78_combout\,
	combout => \Mux1~2_combout\);

-- Location: LCCOMB_X50_Y36_N18
\Add0~92\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~92_combout\ = \B[30]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \B[30]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~92_combout\);

-- Location: LCCOMB_X51_Y36_N14
\Add0~93\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~93_combout\ = (\A[30]~input_o\ & ((\Add0~92_combout\ & (\Add0~91\ & VCC)) # (!\Add0~92_combout\ & (!\Add0~91\)))) # (!\A[30]~input_o\ & ((\Add0~92_combout\ & (!\Add0~91\)) # (!\Add0~92_combout\ & ((\Add0~91\) # (GND)))))
-- \Add0~94\ = CARRY((\A[30]~input_o\ & (!\Add0~92_combout\ & !\Add0~91\)) # (!\A[30]~input_o\ & ((!\Add0~91\) # (!\Add0~92_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \Add0~92_combout\,
	datad => VCC,
	cin => \Add0~91\,
	combout => \Add0~93_combout\,
	cout => \Add0~94\);

-- Location: LCCOMB_X50_Y36_N28
\Mux1~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~3_combout\ = (\Mux1~2_combout\) # ((\ALUOP[1]~input_o\ & (\Add0~93_combout\ & !\ALUOP[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \Mux1~2_combout\,
	datac => \Add0~93_combout\,
	datad => \ALUOP[2]~input_o\,
	combout => \Mux1~3_combout\);

-- Location: LCCOMB_X50_Y36_N22
\Mux1~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~4_combout\ = (\ALUOP[1]~input_o\ & ((\ShiftLeft0~10_combout\ & ((\A[31]~input_o\))) # (!\ShiftLeft0~10_combout\ & (\A[30]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \A[30]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ShiftLeft0~10_combout\,
	combout => \Mux1~4_combout\);

-- Location: LCCOMB_X45_Y40_N16
\Mux1~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~5_combout\ = (!\B[1]~input_o\ & ((\B[0]~input_o\ & ((\A[29]~input_o\))) # (!\B[0]~input_o\ & (\A[30]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \B[0]~input_o\,
	datac => \B[1]~input_o\,
	datad => \A[29]~input_o\,
	combout => \Mux1~5_combout\);

-- Location: LCCOMB_X45_Y40_N26
\Mux1~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~6_combout\ = (!\B[2]~input_o\ & ((\Mux1~5_combout\) # ((\ShiftLeft0~100_combout\ & \B[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~100_combout\,
	datab => \B[1]~input_o\,
	datac => \B[2]~input_o\,
	datad => \Mux1~5_combout\,
	combout => \Mux1~6_combout\);

-- Location: LCCOMB_X50_Y38_N30
\Mux1~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~7_combout\ = (!\B[3]~input_o\ & ((\Mux1~6_combout\) # ((\B[2]~input_o\ & \ShiftLeft0~96_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \ShiftLeft0~96_combout\,
	datac => \B[3]~input_o\,
	datad => \Mux1~6_combout\,
	combout => \Mux1~7_combout\);

-- Location: LCCOMB_X50_Y38_N16
\Mux1~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~8_combout\ = (!\B[4]~input_o\ & ((\Mux1~7_combout\) # ((\B[3]~input_o\ & \ShiftLeft0~86_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux1~7_combout\,
	datab => \B[3]~input_o\,
	datac => \B[4]~input_o\,
	datad => \ShiftLeft0~86_combout\,
	combout => \Mux1~8_combout\);

-- Location: LCCOMB_X50_Y38_N10
\Mux1~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~9_combout\ = (!\ALUOP[1]~input_o\ & ((\Mux1~8_combout\) # ((\B[4]~input_o\ & \ShiftLeft0~60_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[4]~input_o\,
	datab => \ALUOP[1]~input_o\,
	datac => \ShiftLeft0~60_combout\,
	datad => \Mux1~8_combout\,
	combout => \Mux1~9_combout\);

-- Location: LCCOMB_X50_Y36_N24
\Mux1~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~10_combout\ = (\Mux1~3_combout\) # ((\Mux3~0_combout\ & ((\Mux1~4_combout\) # (\Mux1~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux3~0_combout\,
	datab => \Mux1~3_combout\,
	datac => \Mux1~4_combout\,
	datad => \Mux1~9_combout\,
	combout => \Mux1~10_combout\);

-- Location: LCCOMB_X45_Y40_N4
\Mux0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~4_combout\ = (\B[1]~input_o\ & (((\ShiftLeft0~101_combout\)))) # (!\B[1]~input_o\ & (\A[30]~input_o\ & ((\B[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A[30]~input_o\,
	datab => \B[1]~input_o\,
	datac => \ShiftLeft0~101_combout\,
	datad => \B[0]~input_o\,
	combout => \Mux0~4_combout\);

-- Location: LCCOMB_X47_Y40_N10
\Mux0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~5_combout\ = (!\B[3]~input_o\ & ((\B[2]~input_o\ & ((\ShiftLeft0~99_combout\))) # (!\B[2]~input_o\ & (\Mux0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datab => \B[3]~input_o\,
	datac => \Mux0~4_combout\,
	datad => \ShiftLeft0~99_combout\,
	combout => \Mux0~5_combout\);

-- Location: LCCOMB_X47_Y40_N28
\Mux0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~6_combout\ = (!\B[4]~input_o\ & ((\Mux0~5_combout\) # ((\ShiftLeft0~89_combout\ & \B[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~89_combout\,
	datab => \B[3]~input_o\,
	datac => \B[4]~input_o\,
	datad => \Mux0~5_combout\,
	combout => \Mux0~6_combout\);

-- Location: LCCOMB_X52_Y36_N8
\Mux0~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~7_combout\ = (!\ALUOP[1]~input_o\ & ((\Mux0~6_combout\) # ((\B[4]~input_o\ & \ShiftLeft0~65_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ALUOP[1]~input_o\,
	datab => \Mux0~6_combout\,
	datac => \B[4]~input_o\,
	datad => \ShiftLeft0~65_combout\,
	combout => \Mux0~7_combout\);

-- Location: LCCOMB_X49_Y42_N18
\Mux0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~8_combout\ = (\A[31]~input_o\ & ((\ALUOP[1]~input_o\) # ((\ShiftLeft0~16_combout\ & \Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~16_combout\,
	datab => \A[31]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \Mux0~0_combout\,
	combout => \Mux0~8_combout\);

-- Location: LCCOMB_X52_Y36_N4
\Add0~95\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~95_combout\ = \B[31]~input_o\ $ (\ALUOP[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[31]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Add0~95_combout\);

-- Location: LCCOMB_X51_Y36_N16
\Add0~96\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Add0~96_combout\ = \A[31]~input_o\ $ (\Add0~94\ $ (!\Add0~95_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \A[31]~input_o\,
	datad => \Add0~95_combout\,
	cin => \Add0~94\,
	combout => \Add0~96_combout\);

-- Location: LCCOMB_X52_Y36_N24
\Mux0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~1_combout\ = (!\ALUOP[2]~input_o\ & ((\B[31]~input_o\ & ((\A[31]~input_o\) # (\ALUOP[0]~input_o\))) # (!\B[31]~input_o\ & (\A[31]~input_o\ & \ALUOP[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[31]~input_o\,
	datab => \ALUOP[2]~input_o\,
	datac => \A[31]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux0~1_combout\);

-- Location: LCCOMB_X52_Y36_N18
\Mux0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~2_combout\ = (\Mux0~1_combout\) # ((!\ShiftLeft0~10_combout\ & (\A[31]~input_o\ & \ALUOP[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ShiftLeft0~10_combout\,
	datab => \Mux0~1_combout\,
	datac => \A[31]~input_o\,
	datad => \ALUOP[0]~input_o\,
	combout => \Mux0~2_combout\);

-- Location: LCCOMB_X52_Y36_N6
\Mux0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~3_combout\ = (\ALUOP[1]~input_o\ & (\Add0~96_combout\ & (!\ALUOP[2]~input_o\))) # (!\ALUOP[1]~input_o\ & (((\Mux0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~96_combout\,
	datab => \ALUOP[2]~input_o\,
	datac => \ALUOP[1]~input_o\,
	datad => \Mux0~2_combout\,
	combout => \Mux0~3_combout\);

-- Location: LCCOMB_X52_Y36_N26
\Mux0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~9_combout\ = (\Mux0~3_combout\) # ((\Mux3~0_combout\ & ((\Mux0~7_combout\) # (\Mux0~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux3~0_combout\,
	datab => \Mux0~7_combout\,
	datac => \Mux0~8_combout\,
	datad => \Mux0~3_combout\,
	combout => \Mux0~9_combout\);

-- Location: LCCOMB_X52_Y39_N12
\Equal0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (!\Mux22~6_combout\ & (!\Mux20~6_combout\ & (!\Mux23~8_combout\ & !\Mux21~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux22~6_combout\,
	datab => \Mux20~6_combout\,
	datac => \Mux23~8_combout\,
	datad => \Mux21~7_combout\,
	combout => \Equal0~0_combout\);

-- Location: LCCOMB_X52_Y39_N30
\Equal0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (!\Mux30~10_combout\ & (!\Mux1~10_combout\ & \Equal0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux30~10_combout\,
	datac => \Mux1~10_combout\,
	datad => \Equal0~0_combout\,
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X52_Y37_N6
\Equal0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = (!\Mux16~6_combout\ & (!\Mux17~6_combout\ & (!\Mux18~6_combout\ & !\Mux19~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux16~6_combout\,
	datab => \Mux17~6_combout\,
	datac => \Mux18~6_combout\,
	datad => \Mux19~6_combout\,
	combout => \Equal0~2_combout\);

-- Location: LCCOMB_X50_Y42_N0
\Equal0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = (!\Mux5~combout\ & (!\Mux4~combout\ & (!\Mux7~combout\ & !\Mux6~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux5~combout\,
	datab => \Mux4~combout\,
	datac => \Mux7~combout\,
	datad => \Mux6~combout\,
	combout => \Equal0~3_combout\);

-- Location: LCCOMB_X50_Y42_N10
\Equal0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = (!\Mux3~12_combout\ & (!\Mux27~7_combout\ & (!\Mux2~8_combout\ & \Equal0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux3~12_combout\,
	datab => \Mux27~7_combout\,
	datac => \Mux2~8_combout\,
	datad => \Equal0~3_combout\,
	combout => \Equal0~4_combout\);

-- Location: LCCOMB_X54_Y39_N28
\Equal0~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~7_combout\ = (!\Mux9~5_combout\ & (!\Mux10~5_combout\ & (!\Mux8~5_combout\ & !\Mux11~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux9~5_combout\,
	datab => \Mux10~5_combout\,
	datac => \Mux8~5_combout\,
	datad => \Mux11~5_combout\,
	combout => \Equal0~7_combout\);

-- Location: LCCOMB_X54_Y39_N2
\Equal0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = (!\Mux24~7_combout\ & (!\Mux12~10_combout\ & (!\Mux13~5_combout\ & !\Mux14~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux24~7_combout\,
	datab => \Mux12~10_combout\,
	datac => \Mux13~5_combout\,
	datad => \Mux14~6_combout\,
	combout => \Equal0~6_combout\);

-- Location: LCCOMB_X54_Y39_N0
\Equal0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = (!\Mux28~12_combout\ & (!\Mux29~6_combout\ & (!\Mux25~13_combout\ & !\Mux26~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux28~12_combout\,
	datab => \Mux29~6_combout\,
	datac => \Mux25~13_combout\,
	datad => \Mux26~7_combout\,
	combout => \Equal0~5_combout\);

-- Location: LCCOMB_X54_Y39_N30
\Equal0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~8_combout\ = (\Equal0~4_combout\ & (\Equal0~7_combout\ & (\Equal0~6_combout\ & \Equal0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~4_combout\,
	datab => \Equal0~7_combout\,
	datac => \Equal0~6_combout\,
	datad => \Equal0~5_combout\,
	combout => \Equal0~8_combout\);

-- Location: LCCOMB_X52_Y39_N8
\Equal0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~9_combout\ = (\Equal0~2_combout\ & (!\Mux0~9_combout\ & \Equal0~8_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~2_combout\,
	datab => \Mux0~9_combout\,
	datad => \Equal0~8_combout\,
	combout => \Equal0~9_combout\);

-- Location: LCCOMB_X52_Y39_N10
\Equal0~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Equal0~10_combout\ = (!\Mux15~8_combout\ & (!\Mux31~12_combout\ & (\Equal0~1_combout\ & \Equal0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Mux15~8_combout\,
	datab => \Mux31~12_combout\,
	datac => \Equal0~1_combout\,
	datad => \Equal0~9_combout\,
	combout => \Equal0~10_combout\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_Result(0) <= \Result[0]~output_o\;

ww_Result(1) <= \Result[1]~output_o\;

ww_Result(2) <= \Result[2]~output_o\;

ww_Result(3) <= \Result[3]~output_o\;

ww_Result(4) <= \Result[4]~output_o\;

ww_Result(5) <= \Result[5]~output_o\;

ww_Result(6) <= \Result[6]~output_o\;

ww_Result(7) <= \Result[7]~output_o\;

ww_Result(8) <= \Result[8]~output_o\;

ww_Result(9) <= \Result[9]~output_o\;

ww_Result(10) <= \Result[10]~output_o\;

ww_Result(11) <= \Result[11]~output_o\;

ww_Result(12) <= \Result[12]~output_o\;

ww_Result(13) <= \Result[13]~output_o\;

ww_Result(14) <= \Result[14]~output_o\;

ww_Result(15) <= \Result[15]~output_o\;

ww_Result(16) <= \Result[16]~output_o\;

ww_Result(17) <= \Result[17]~output_o\;

ww_Result(18) <= \Result[18]~output_o\;

ww_Result(19) <= \Result[19]~output_o\;

ww_Result(20) <= \Result[20]~output_o\;

ww_Result(21) <= \Result[21]~output_o\;

ww_Result(22) <= \Result[22]~output_o\;

ww_Result(23) <= \Result[23]~output_o\;

ww_Result(24) <= \Result[24]~output_o\;

ww_Result(25) <= \Result[25]~output_o\;

ww_Result(26) <= \Result[26]~output_o\;

ww_Result(27) <= \Result[27]~output_o\;

ww_Result(28) <= \Result[28]~output_o\;

ww_Result(29) <= \Result[29]~output_o\;

ww_Result(30) <= \Result[30]~output_o\;

ww_Result(31) <= \Result[31]~output_o\;

ww_Zero <= \Zero~output_o\;
END structure;


