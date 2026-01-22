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

-- DATE "01/08/2026 14:51:03"

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


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	week5_top IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	PC_debug : OUT std_logic_vector(31 DOWNTO 0);
	instr_debug : OUT std_logic_vector(31 DOWNTO 0);
	ALU_debug : OUT std_logic_vector(31 DOWNTO 0)
	);
END week5_top;

-- Design Ports Information
-- PC_debug[0]	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[1]	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[2]	=>  Location: PIN_R9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[3]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[4]	=>  Location: PIN_AB2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[5]	=>  Location: PIN_R7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[6]	=>  Location: PIN_T6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[7]	=>  Location: PIN_AA5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[8]	=>  Location: PIN_AB11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[9]	=>  Location: PIN_AA8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[10]	=>  Location: PIN_AB14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[11]	=>  Location: PIN_U4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[12]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[13]	=>  Location: PIN_W11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[14]	=>  Location: PIN_AA9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[15]	=>  Location: PIN_V10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[16]	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[17]	=>  Location: PIN_AA3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[18]	=>  Location: PIN_AB5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[19]	=>  Location: PIN_AB4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[20]	=>  Location: PIN_C4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[21]	=>  Location: PIN_W7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[22]	=>  Location: PIN_V9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[23]	=>  Location: PIN_Y4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[24]	=>  Location: PIN_W8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[25]	=>  Location: PIN_AB8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[26]	=>  Location: PIN_AB6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[27]	=>  Location: PIN_R10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[28]	=>  Location: PIN_AB7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[29]	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[30]	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PC_debug[31]	=>  Location: PIN_R11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[0]	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[1]	=>  Location: PIN_W6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[2]	=>  Location: PIN_C5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[3]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[4]	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[5]	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[6]	=>  Location: PIN_U6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[7]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[8]	=>  Location: PIN_W2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[9]	=>  Location: PIN_W12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[10]	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[11]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[12]	=>  Location: PIN_Y8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[13]	=>  Location: PIN_W13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[14]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[15]	=>  Location: PIN_U1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[16]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[17]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[18]	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[19]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[20]	=>  Location: PIN_Y11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[21]	=>  Location: PIN_V7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[22]	=>  Location: PIN_AB9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[23]	=>  Location: PIN_Y6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[24]	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[25]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[26]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[27]	=>  Location: PIN_J12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[28]	=>  Location: PIN_Y20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[29]	=>  Location: PIN_V22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[30]	=>  Location: PIN_W1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instr_debug[31]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[0]	=>  Location: PIN_AB3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[1]	=>  Location: PIN_AA7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[2]	=>  Location: PIN_AB10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[3]	=>  Location: PIN_P10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[4]	=>  Location: PIN_W9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[5]	=>  Location: PIN_W10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[6]	=>  Location: PIN_V5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[7]	=>  Location: PIN_Y7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[8]	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[9]	=>  Location: PIN_W4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[10]	=>  Location: PIN_Y3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[11]	=>  Location: PIN_V4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[12]	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[13]	=>  Location: PIN_AA6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[14]	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[15]	=>  Location: PIN_W5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[16]	=>  Location: PIN_V8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[17]	=>  Location: PIN_R2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[18]	=>  Location: PIN_W3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[19]	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[20]	=>  Location: PIN_Y10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[21]	=>  Location: PIN_R12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[22]	=>  Location: PIN_AA10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[23]	=>  Location: PIN_AA11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[24]	=>  Location: PIN_V11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[25]	=>  Location: PIN_P12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[26]	=>  Location: PIN_V12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[27]	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[28]	=>  Location: PIN_V1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[29]	=>  Location: PIN_AA1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[30]	=>  Location: PIN_E6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU_debug[31]	=>  Location: PIN_Y5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF week5_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_PC_debug : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_instr_debug : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_ALU_debug : std_logic_vector(31 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \PC_debug[0]~output_o\ : std_logic;
SIGNAL \PC_debug[1]~output_o\ : std_logic;
SIGNAL \PC_debug[2]~output_o\ : std_logic;
SIGNAL \PC_debug[3]~output_o\ : std_logic;
SIGNAL \PC_debug[4]~output_o\ : std_logic;
SIGNAL \PC_debug[5]~output_o\ : std_logic;
SIGNAL \PC_debug[6]~output_o\ : std_logic;
SIGNAL \PC_debug[7]~output_o\ : std_logic;
SIGNAL \PC_debug[8]~output_o\ : std_logic;
SIGNAL \PC_debug[9]~output_o\ : std_logic;
SIGNAL \PC_debug[10]~output_o\ : std_logic;
SIGNAL \PC_debug[11]~output_o\ : std_logic;
SIGNAL \PC_debug[12]~output_o\ : std_logic;
SIGNAL \PC_debug[13]~output_o\ : std_logic;
SIGNAL \PC_debug[14]~output_o\ : std_logic;
SIGNAL \PC_debug[15]~output_o\ : std_logic;
SIGNAL \PC_debug[16]~output_o\ : std_logic;
SIGNAL \PC_debug[17]~output_o\ : std_logic;
SIGNAL \PC_debug[18]~output_o\ : std_logic;
SIGNAL \PC_debug[19]~output_o\ : std_logic;
SIGNAL \PC_debug[20]~output_o\ : std_logic;
SIGNAL \PC_debug[21]~output_o\ : std_logic;
SIGNAL \PC_debug[22]~output_o\ : std_logic;
SIGNAL \PC_debug[23]~output_o\ : std_logic;
SIGNAL \PC_debug[24]~output_o\ : std_logic;
SIGNAL \PC_debug[25]~output_o\ : std_logic;
SIGNAL \PC_debug[26]~output_o\ : std_logic;
SIGNAL \PC_debug[27]~output_o\ : std_logic;
SIGNAL \PC_debug[28]~output_o\ : std_logic;
SIGNAL \PC_debug[29]~output_o\ : std_logic;
SIGNAL \PC_debug[30]~output_o\ : std_logic;
SIGNAL \PC_debug[31]~output_o\ : std_logic;
SIGNAL \instr_debug[0]~output_o\ : std_logic;
SIGNAL \instr_debug[1]~output_o\ : std_logic;
SIGNAL \instr_debug[2]~output_o\ : std_logic;
SIGNAL \instr_debug[3]~output_o\ : std_logic;
SIGNAL \instr_debug[4]~output_o\ : std_logic;
SIGNAL \instr_debug[5]~output_o\ : std_logic;
SIGNAL \instr_debug[6]~output_o\ : std_logic;
SIGNAL \instr_debug[7]~output_o\ : std_logic;
SIGNAL \instr_debug[8]~output_o\ : std_logic;
SIGNAL \instr_debug[9]~output_o\ : std_logic;
SIGNAL \instr_debug[10]~output_o\ : std_logic;
SIGNAL \instr_debug[11]~output_o\ : std_logic;
SIGNAL \instr_debug[12]~output_o\ : std_logic;
SIGNAL \instr_debug[13]~output_o\ : std_logic;
SIGNAL \instr_debug[14]~output_o\ : std_logic;
SIGNAL \instr_debug[15]~output_o\ : std_logic;
SIGNAL \instr_debug[16]~output_o\ : std_logic;
SIGNAL \instr_debug[17]~output_o\ : std_logic;
SIGNAL \instr_debug[18]~output_o\ : std_logic;
SIGNAL \instr_debug[19]~output_o\ : std_logic;
SIGNAL \instr_debug[20]~output_o\ : std_logic;
SIGNAL \instr_debug[21]~output_o\ : std_logic;
SIGNAL \instr_debug[22]~output_o\ : std_logic;
SIGNAL \instr_debug[23]~output_o\ : std_logic;
SIGNAL \instr_debug[24]~output_o\ : std_logic;
SIGNAL \instr_debug[25]~output_o\ : std_logic;
SIGNAL \instr_debug[26]~output_o\ : std_logic;
SIGNAL \instr_debug[27]~output_o\ : std_logic;
SIGNAL \instr_debug[28]~output_o\ : std_logic;
SIGNAL \instr_debug[29]~output_o\ : std_logic;
SIGNAL \instr_debug[30]~output_o\ : std_logic;
SIGNAL \instr_debug[31]~output_o\ : std_logic;
SIGNAL \ALU_debug[0]~output_o\ : std_logic;
SIGNAL \ALU_debug[1]~output_o\ : std_logic;
SIGNAL \ALU_debug[2]~output_o\ : std_logic;
SIGNAL \ALU_debug[3]~output_o\ : std_logic;
SIGNAL \ALU_debug[4]~output_o\ : std_logic;
SIGNAL \ALU_debug[5]~output_o\ : std_logic;
SIGNAL \ALU_debug[6]~output_o\ : std_logic;
SIGNAL \ALU_debug[7]~output_o\ : std_logic;
SIGNAL \ALU_debug[8]~output_o\ : std_logic;
SIGNAL \ALU_debug[9]~output_o\ : std_logic;
SIGNAL \ALU_debug[10]~output_o\ : std_logic;
SIGNAL \ALU_debug[11]~output_o\ : std_logic;
SIGNAL \ALU_debug[12]~output_o\ : std_logic;
SIGNAL \ALU_debug[13]~output_o\ : std_logic;
SIGNAL \ALU_debug[14]~output_o\ : std_logic;
SIGNAL \ALU_debug[15]~output_o\ : std_logic;
SIGNAL \ALU_debug[16]~output_o\ : std_logic;
SIGNAL \ALU_debug[17]~output_o\ : std_logic;
SIGNAL \ALU_debug[18]~output_o\ : std_logic;
SIGNAL \ALU_debug[19]~output_o\ : std_logic;
SIGNAL \ALU_debug[20]~output_o\ : std_logic;
SIGNAL \ALU_debug[21]~output_o\ : std_logic;
SIGNAL \ALU_debug[22]~output_o\ : std_logic;
SIGNAL \ALU_debug[23]~output_o\ : std_logic;
SIGNAL \ALU_debug[24]~output_o\ : std_logic;
SIGNAL \ALU_debug[25]~output_o\ : std_logic;
SIGNAL \ALU_debug[26]~output_o\ : std_logic;
SIGNAL \ALU_debug[27]~output_o\ : std_logic;
SIGNAL \ALU_debug[28]~output_o\ : std_logic;
SIGNAL \ALU_debug[29]~output_o\ : std_logic;
SIGNAL \ALU_debug[30]~output_o\ : std_logic;
SIGNAL \ALU_debug[31]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \PC_Reg|PC_out[2]~30_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[4]~35\ : std_logic;
SIGNAL \PC_Reg|PC_out[5]~36_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[5]~37\ : std_logic;
SIGNAL \PC_Reg|PC_out[6]~38_combout\ : std_logic;
SIGNAL \BranchTarget[5]~11\ : std_logic;
SIGNAL \BranchTarget[6]~12_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \PC_Reg|PC_out[6]~39\ : std_logic;
SIGNAL \PC_Reg|PC_out[7]~40_combout\ : std_logic;
SIGNAL \BranchTarget[6]~13\ : std_logic;
SIGNAL \BranchTarget[7]~14_combout\ : std_logic;
SIGNAL \InstMem|Mux15~0_combout\ : std_logic;
SIGNAL \InstMem|Mux15~1_combout\ : std_logic;
SIGNAL \InstMem|Mux17~2_combout\ : std_logic;
SIGNAL \InstMem|Mux17~3_combout\ : std_logic;
SIGNAL \InstMem|Mux14~2_combout\ : std_logic;
SIGNAL \InstMem|Mux14~3_combout\ : std_logic;
SIGNAL \PCSrc~0_combout\ : std_logic;
SIGNAL \InstMem|Mux13~0_combout\ : std_logic;
SIGNAL \InstMem|Mux8~0_combout\ : std_logic;
SIGNAL \InstMem|Mux10~0_combout\ : std_logic;
SIGNAL \Control|Mux4~1_combout\ : std_logic;
SIGNAL \Control|Mux4~0_combout\ : std_logic;
SIGNAL \Control|Mux4~2_combout\ : std_logic;
SIGNAL \InstMem|Mux0~0_combout\ : std_logic;
SIGNAL \Control|Mux3~3_combout\ : std_logic;
SIGNAL \Control|Mux3~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux31~0_combout\ : std_logic;
SIGNAL \InstMem|Mux3~0_combout\ : std_logic;
SIGNAL \InstMem|Mux3~1_combout\ : std_logic;
SIGNAL \InstMem|Mux4~0_combout\ : std_logic;
SIGNAL \InstMem|Mux1~0_combout\ : std_logic;
SIGNAL \InstMem|Mux11~2_combout\ : std_logic;
SIGNAL \InstMem|Mux11~3_combout\ : std_logic;
SIGNAL \RegFile|mem~1129_combout\ : std_logic;
SIGNAL \InstMem|Mux12~2_combout\ : std_logic;
SIGNAL \InstMem|Mux12~3_combout\ : std_logic;
SIGNAL \RegFile|mem~1131_combout\ : std_logic;
SIGNAL \RegFile|mem~102_q\ : std_logic;
SIGNAL \RegFile|mem~262feeder_combout\ : std_logic;
SIGNAL \Control|Mux5~0_combout\ : std_logic;
SIGNAL \RegFile|mem~1133_combout\ : std_logic;
SIGNAL \RegFile|mem~262_q\ : std_logic;
SIGNAL \RegFile|mem~1132_combout\ : std_logic;
SIGNAL \RegFile|mem~198_q\ : std_logic;
SIGNAL \SrcB[0]~4_combout\ : std_logic;
SIGNAL \SrcB[0]~5_combout\ : std_logic;
SIGNAL \SrcB[0]~6_combout\ : std_logic;
SIGNAL \Control|Mux5~1_combout\ : std_logic;
SIGNAL \RegFile|mem~1130_combout\ : std_logic;
SIGNAL \RegFile|mem~70_q\ : std_logic;
SIGNAL \RegFile|rd1[0]~64_combout\ : std_logic;
SIGNAL \CoreALU|Mux31~1_combout\ : std_logic;
SIGNAL \CoreALU|Add0~0_combout\ : std_logic;
SIGNAL \CoreALU|Add1~0_combout\ : std_logic;
SIGNAL \CoreALU|Mux31~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux31~3_combout\ : std_logic;
SIGNAL \RegFile|mem~132_q\ : std_logic;
SIGNAL \RegFile|mem~1134_combout\ : std_logic;
SIGNAL \RegFile|mem~68_q\ : std_logic;
SIGNAL \RegFile|mem~1126_combout\ : std_logic;
SIGNAL \RegFile|mem~228feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~228_q\ : std_logic;
SIGNAL \RegFile|mem~292_q\ : std_logic;
SIGNAL \RegFile|mem~1125_combout\ : std_logic;
SIGNAL \SrcB[30]~7_combout\ : std_logic;
SIGNAL \SrcB[30]~46_combout\ : std_logic;
SIGNAL \RegFile|mem~100_q\ : std_logic;
SIGNAL \RegFile|rd1[30]~94_combout\ : std_logic;
SIGNAL \CoreALU|Mux20~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux20~2_combout\ : std_logic;
SIGNAL \RegFile|mem~227feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~227_q\ : std_logic;
SIGNAL \RegFile|mem~291_q\ : std_logic;
SIGNAL \RegFile|mem~1123_combout\ : std_logic;
SIGNAL \RegFile|mem~131_q\ : std_logic;
SIGNAL \RegFile|mem~67_q\ : std_logic;
SIGNAL \RegFile|mem~1124_combout\ : std_logic;
SIGNAL \SrcB[29]~45_combout\ : std_logic;
SIGNAL \RegFile|mem~98_q\ : std_logic;
SIGNAL \RegFile|rd1[28]~92_combout\ : std_logic;
SIGNAL \RegFile|mem~97_q\ : std_logic;
SIGNAL \RegFile|rd1[27]~91_combout\ : std_logic;
SIGNAL \RegFile|mem~128_q\ : std_logic;
SIGNAL \RegFile|mem~64_q\ : std_logic;
SIGNAL \RegFile|mem~1118_combout\ : std_logic;
SIGNAL \RegFile|mem~224feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~224_q\ : std_logic;
SIGNAL \RegFile|mem~288_q\ : std_logic;
SIGNAL \RegFile|mem~1117_combout\ : std_logic;
SIGNAL \SrcB[26]~42_combout\ : std_logic;
SIGNAL \RegFile|mem~223feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~223_q\ : std_logic;
SIGNAL \RegFile|mem~287_q\ : std_logic;
SIGNAL \RegFile|mem~1115_combout\ : std_logic;
SIGNAL \RegFile|mem~127_q\ : std_logic;
SIGNAL \RegFile|mem~63_q\ : std_logic;
SIGNAL \RegFile|mem~1116_combout\ : std_logic;
SIGNAL \SrcB[25]~41_combout\ : std_logic;
SIGNAL \RegFile|mem~94_q\ : std_logic;
SIGNAL \RegFile|rd1[24]~88_combout\ : std_logic;
SIGNAL \RegFile|mem~93_q\ : std_logic;
SIGNAL \RegFile|rd1[23]~87_combout\ : std_logic;
SIGNAL \RegFile|mem~220_q\ : std_logic;
SIGNAL \RegFile|mem~284_q\ : std_logic;
SIGNAL \RegFile|mem~1109_combout\ : std_logic;
SIGNAL \RegFile|mem~124_q\ : std_logic;
SIGNAL \RegFile|mem~60_q\ : std_logic;
SIGNAL \RegFile|mem~1110_combout\ : std_logic;
SIGNAL \SrcB[22]~38_combout\ : std_logic;
SIGNAL \RegFile|mem~91_q\ : std_logic;
SIGNAL \RegFile|rd1[21]~85_combout\ : std_logic;
SIGNAL \RegFile|mem~90_q\ : std_logic;
SIGNAL \RegFile|rd1[20]~84_combout\ : std_logic;
SIGNAL \RegFile|mem~89_q\ : std_logic;
SIGNAL \RegFile|rd1[19]~83_combout\ : std_logic;
SIGNAL \RegFile|mem~88_q\ : std_logic;
SIGNAL \RegFile|rd1[18]~82_combout\ : std_logic;
SIGNAL \RegFile|mem~119_q\ : std_logic;
SIGNAL \RegFile|mem~55_q\ : std_logic;
SIGNAL \RegFile|mem~1100_combout\ : std_logic;
SIGNAL \RegFile|mem~215feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~215_q\ : std_logic;
SIGNAL \RegFile|mem~279_q\ : std_logic;
SIGNAL \RegFile|mem~1099_combout\ : std_logic;
SIGNAL \SrcB[17]~33_combout\ : std_logic;
SIGNAL \RegFile|mem~54_q\ : std_logic;
SIGNAL \RegFile|mem~118_q\ : std_logic;
SIGNAL \RegFile|mem~1098_combout\ : std_logic;
SIGNAL \RegFile|mem~278_q\ : std_logic;
SIGNAL \RegFile|mem~214feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~214_q\ : std_logic;
SIGNAL \RegFile|mem~1097_combout\ : std_logic;
SIGNAL \SrcB[16]~32_combout\ : std_logic;
SIGNAL \RegFile|mem~85_q\ : std_logic;
SIGNAL \RegFile|rd1[15]~79_combout\ : std_logic;
SIGNAL \RegFile|mem~84_q\ : std_logic;
SIGNAL \RegFile|rd1[14]~78_combout\ : std_logic;
SIGNAL \RegFile|mem~83_q\ : std_logic;
SIGNAL \RegFile|rd1[13]~77_combout\ : std_logic;
SIGNAL \RegFile|mem~114feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~114_q\ : std_logic;
SIGNAL \RegFile|mem~50_q\ : std_logic;
SIGNAL \RegFile|mem~1088_combout\ : std_logic;
SIGNAL \RegFile|mem~1089_combout\ : std_logic;
SIGNAL \RegFile|mem~210feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~210_q\ : std_logic;
SIGNAL \RegFile|mem~274_q\ : std_logic;
SIGNAL \RegFile|mem~1090_combout\ : std_logic;
SIGNAL \RegFile|mem~1091_combout\ : std_logic;
SIGNAL \SrcB[12]~26_combout\ : std_logic;
SIGNAL \RegFile|mem~81feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~81_q\ : std_logic;
SIGNAL \RegFile|rd1[11]~75_combout\ : std_logic;
SIGNAL \InstMem|Mux15~2_combout\ : std_logic;
SIGNAL \SrcB[10]~48_combout\ : std_logic;
SIGNAL \SrcB[10]~9_combout\ : std_logic;
SIGNAL \RegFile|mem~80_q\ : std_logic;
SIGNAL \RegFile|rd1[10]~74_combout\ : std_logic;
SIGNAL \RegFile|mem~79_q\ : std_logic;
SIGNAL \RegFile|rd1[9]~73_combout\ : std_logic;
SIGNAL \RegFile|mem~78_q\ : std_logic;
SIGNAL \RegFile|rd1[8]~72_combout\ : std_logic;
SIGNAL \RegFile|mem~77_q\ : std_logic;
SIGNAL \RegFile|rd1[7]~71_combout\ : std_logic;
SIGNAL \RegFile|mem~108_q\ : std_logic;
SIGNAL \RegFile|mem~44_q\ : std_logic;
SIGNAL \RegFile|mem~1080_combout\ : std_logic;
SIGNAL \RegFile|mem~204feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~204_q\ : std_logic;
SIGNAL \RegFile|mem~268_q\ : std_logic;
SIGNAL \RegFile|mem~1079_combout\ : std_logic;
SIGNAL \SrcB[6]~16_combout\ : std_logic;
SIGNAL \RegFile|mem~107_q\ : std_logic;
SIGNAL \RegFile|mem~43_q\ : std_logic;
SIGNAL \RegFile|mem~1078_combout\ : std_logic;
SIGNAL \RegFile|mem~203feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~203_q\ : std_logic;
SIGNAL \RegFile|mem~267_q\ : std_logic;
SIGNAL \RegFile|mem~1077_combout\ : std_logic;
SIGNAL \SrcB[5]~15_combout\ : std_logic;
SIGNAL \RegFile|mem~74_q\ : std_logic;
SIGNAL \RegFile|rd1[4]~68_combout\ : std_logic;
SIGNAL \RegFile|mem~73_q\ : std_logic;
SIGNAL \RegFile|rd1[3]~67_combout\ : std_logic;
SIGNAL \SrcB[2]~10_combout\ : std_logic;
SIGNAL \RegFile|mem~72_q\ : std_logic;
SIGNAL \RegFile|rd1[2]~66_combout\ : std_logic;
SIGNAL \ExtUnit|Mux30~3_combout\ : std_logic;
SIGNAL \ExtUnit|Mux30~12_combout\ : std_logic;
SIGNAL \RegFile|mem~263feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~263_q\ : std_logic;
SIGNAL \RegFile|mem~199_q\ : std_logic;
SIGNAL \RegFile|mem~1066_combout\ : std_logic;
SIGNAL \RegFile|mem~39_q\ : std_logic;
SIGNAL \RegFile|mem~103_q\ : std_logic;
SIGNAL \RegFile|mem~1067_combout\ : std_logic;
SIGNAL \RegFile|mem~1068_combout\ : std_logic;
SIGNAL \SrcB[1]~8_combout\ : std_logic;
SIGNAL \CoreALU|Add0~1\ : std_logic;
SIGNAL \CoreALU|Add0~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux30~3_combout\ : std_logic;
SIGNAL \CoreALU|Add1~1\ : std_logic;
SIGNAL \CoreALU|Add1~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux30~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux30~combout\ : std_logic;
SIGNAL \RegFile|mem~71_q\ : std_logic;
SIGNAL \RegFile|rd1[1]~65_combout\ : std_logic;
SIGNAL \CoreALU|Add1~3\ : std_logic;
SIGNAL \CoreALU|Add1~4_combout\ : std_logic;
SIGNAL \CoreALU|Add0~3\ : std_logic;
SIGNAL \CoreALU|Add0~4_combout\ : std_logic;
SIGNAL \CoreALU|Mux29~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux29~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux29~combout\ : std_logic;
SIGNAL \RegFile|mem~200feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~200_q\ : std_logic;
SIGNAL \RegFile|mem~264_q\ : std_logic;
SIGNAL \RegFile|mem~1069_combout\ : std_logic;
SIGNAL \RegFile|mem~104_q\ : std_logic;
SIGNAL \RegFile|mem~40_q\ : std_logic;
SIGNAL \RegFile|mem~1070_combout\ : std_logic;
SIGNAL \SrcB[2]~11_combout\ : std_logic;
SIGNAL \SrcB[2]~12_combout\ : std_logic;
SIGNAL \CoreALU|Add1~5\ : std_logic;
SIGNAL \CoreALU|Add1~6_combout\ : std_logic;
SIGNAL \CoreALU|Add0~5\ : std_logic;
SIGNAL \CoreALU|Add0~6_combout\ : std_logic;
SIGNAL \CoreALU|Mux28~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux28~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux28~combout\ : std_logic;
SIGNAL \RegFile|mem~105feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~105_q\ : std_logic;
SIGNAL \RegFile|mem~41_q\ : std_logic;
SIGNAL \RegFile|mem~1071_combout\ : std_logic;
SIGNAL \RegFile|mem~1072_combout\ : std_logic;
SIGNAL \RegFile|mem~201feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~201_q\ : std_logic;
SIGNAL \RegFile|mem~265_q\ : std_logic;
SIGNAL \RegFile|mem~1073_combout\ : std_logic;
SIGNAL \RegFile|mem~1074_combout\ : std_logic;
SIGNAL \SrcB[3]~13_combout\ : std_logic;
SIGNAL \CoreALU|Add1~7\ : std_logic;
SIGNAL \CoreALU|Add1~8_combout\ : std_logic;
SIGNAL \CoreALU|Add0~7\ : std_logic;
SIGNAL \CoreALU|Add0~8_combout\ : std_logic;
SIGNAL \CoreALU|Mux27~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux27~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux27~combout\ : std_logic;
SIGNAL \RegFile|mem~202_q\ : std_logic;
SIGNAL \RegFile|mem~266_q\ : std_logic;
SIGNAL \RegFile|mem~1075_combout\ : std_logic;
SIGNAL \RegFile|mem~106_q\ : std_logic;
SIGNAL \RegFile|mem~42_q\ : std_logic;
SIGNAL \RegFile|mem~1076_combout\ : std_logic;
SIGNAL \SrcB[4]~14_combout\ : std_logic;
SIGNAL \CoreALU|Add1~9\ : std_logic;
SIGNAL \CoreALU|Add1~10_combout\ : std_logic;
SIGNAL \CoreALU|Add0~9\ : std_logic;
SIGNAL \CoreALU|Add0~10_combout\ : std_logic;
SIGNAL \CoreALU|Mux26~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux26~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux26~combout\ : std_logic;
SIGNAL \RegFile|mem~75_q\ : std_logic;
SIGNAL \RegFile|rd1[5]~69_combout\ : std_logic;
SIGNAL \CoreALU|Add1~11\ : std_logic;
SIGNAL \CoreALU|Add1~12_combout\ : std_logic;
SIGNAL \CoreALU|Add0~11\ : std_logic;
SIGNAL \CoreALU|Add0~12_combout\ : std_logic;
SIGNAL \CoreALU|Mux25~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux25~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux25~combout\ : std_logic;
SIGNAL \RegFile|mem~76_q\ : std_logic;
SIGNAL \RegFile|rd1[6]~70_combout\ : std_logic;
SIGNAL \CoreALU|Add1~13\ : std_logic;
SIGNAL \CoreALU|Add1~14_combout\ : std_logic;
SIGNAL \CoreALU|Add0~13\ : std_logic;
SIGNAL \CoreALU|Add0~14_combout\ : std_logic;
SIGNAL \CoreALU|Mux24~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux24~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux24~combout\ : std_logic;
SIGNAL \RegFile|mem~205_q\ : std_logic;
SIGNAL \RegFile|mem~45_q\ : std_logic;
SIGNAL \RegFile|mem~109_q\ : std_logic;
SIGNAL \RegFile|mem~269_q\ : std_logic;
SIGNAL \SrcB[7]~17_combout\ : std_logic;
SIGNAL \SrcB[7]~18_combout\ : std_logic;
SIGNAL \SrcB[7]~19_combout\ : std_logic;
SIGNAL \CoreALU|Add1~15\ : std_logic;
SIGNAL \CoreALU|Add1~16_combout\ : std_logic;
SIGNAL \CoreALU|Add0~15\ : std_logic;
SIGNAL \CoreALU|Add0~16_combout\ : std_logic;
SIGNAL \CoreALU|Mux23~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux23~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux23~combout\ : std_logic;
SIGNAL \RegFile|mem~206feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~206_q\ : std_logic;
SIGNAL \RegFile|mem~270_q\ : std_logic;
SIGNAL \RegFile|mem~1081_combout\ : std_logic;
SIGNAL \RegFile|mem~110_q\ : std_logic;
SIGNAL \RegFile|mem~46_q\ : std_logic;
SIGNAL \RegFile|mem~1082_combout\ : std_logic;
SIGNAL \SrcB[8]~20_combout\ : std_logic;
SIGNAL \CoreALU|Add1~17\ : std_logic;
SIGNAL \CoreALU|Add1~18_combout\ : std_logic;
SIGNAL \CoreALU|Add0~17\ : std_logic;
SIGNAL \CoreALU|Add0~18_combout\ : std_logic;
SIGNAL \CoreALU|Mux22~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux22~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux22~combout\ : std_logic;
SIGNAL \RegFile|mem~111_q\ : std_logic;
SIGNAL \RegFile|mem~47_q\ : std_logic;
SIGNAL \RegFile|mem~1084_combout\ : std_logic;
SIGNAL \RegFile|mem~271_q\ : std_logic;
SIGNAL \RegFile|mem~207feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~207_q\ : std_logic;
SIGNAL \RegFile|mem~1083_combout\ : std_logic;
SIGNAL \SrcB[9]~21_combout\ : std_logic;
SIGNAL \CoreALU|Add1~19\ : std_logic;
SIGNAL \CoreALU|Add1~20_combout\ : std_logic;
SIGNAL \CoreALU|Add0~19\ : std_logic;
SIGNAL \CoreALU|Add0~20_combout\ : std_logic;
SIGNAL \CoreALU|Mux21~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux21~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux21~combout\ : std_logic;
SIGNAL \RegFile|mem~112feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~112_q\ : std_logic;
SIGNAL \RegFile|mem~48_q\ : std_logic;
SIGNAL \RegFile|mem~1085_combout\ : std_logic;
SIGNAL \SrcB[10]~49_combout\ : std_logic;
SIGNAL \RegFile|mem~272feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~272_q\ : std_logic;
SIGNAL \RegFile|mem~208_q\ : std_logic;
SIGNAL \RegFile|mem~1135_combout\ : std_logic;
SIGNAL \SrcB[10]~22_combout\ : std_logic;
SIGNAL \SrcB[10]~23_combout\ : std_logic;
SIGNAL \SrcB[10]~24_combout\ : std_logic;
SIGNAL \CoreALU|Add1~21\ : std_logic;
SIGNAL \CoreALU|Add1~22_combout\ : std_logic;
SIGNAL \CoreALU|Add0~21\ : std_logic;
SIGNAL \CoreALU|Add0~22_combout\ : std_logic;
SIGNAL \CoreALU|Mux20~5_combout\ : std_logic;
SIGNAL \CoreALU|Mux20~4_combout\ : std_logic;
SIGNAL \CoreALU|Mux20~combout\ : std_logic;
SIGNAL \RegFile|mem~113_q\ : std_logic;
SIGNAL \RegFile|mem~49_q\ : std_logic;
SIGNAL \RegFile|mem~1087_combout\ : std_logic;
SIGNAL \RegFile|mem~209feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~209_q\ : std_logic;
SIGNAL \RegFile|mem~273_q\ : std_logic;
SIGNAL \RegFile|mem~1086_combout\ : std_logic;
SIGNAL \SrcB[11]~25_combout\ : std_logic;
SIGNAL \CoreALU|Add1~23\ : std_logic;
SIGNAL \CoreALU|Add1~24_combout\ : std_logic;
SIGNAL \CoreALU|Add0~23\ : std_logic;
SIGNAL \CoreALU|Add0~24_combout\ : std_logic;
SIGNAL \CoreALU|Mux19~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux19~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux19~combout\ : std_logic;
SIGNAL \RegFile|mem~82_q\ : std_logic;
SIGNAL \RegFile|rd1[12]~76_combout\ : std_logic;
SIGNAL \CoreALU|Add1~25\ : std_logic;
SIGNAL \CoreALU|Add1~26_combout\ : std_logic;
SIGNAL \CoreALU|Add0~25\ : std_logic;
SIGNAL \CoreALU|Add0~26_combout\ : std_logic;
SIGNAL \CoreALU|Mux18~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux18~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux18~combout\ : std_logic;
SIGNAL \RegFile|mem~275_q\ : std_logic;
SIGNAL \RegFile|mem~211_q\ : std_logic;
SIGNAL \RegFile|mem~1092_combout\ : std_logic;
SIGNAL \RegFile|mem~115_q\ : std_logic;
SIGNAL \RegFile|mem~51_q\ : std_logic;
SIGNAL \RegFile|mem~1093_combout\ : std_logic;
SIGNAL \SrcB[13]~27_combout\ : std_logic;
SIGNAL \CoreALU|Add1~27\ : std_logic;
SIGNAL \CoreALU|Add1~28_combout\ : std_logic;
SIGNAL \CoreALU|Add0~27\ : std_logic;
SIGNAL \CoreALU|Add0~28_combout\ : std_logic;
SIGNAL \CoreALU|Mux17~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux17~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux17~combout\ : std_logic;
SIGNAL \RegFile|mem~276_q\ : std_logic;
SIGNAL \RegFile|mem~212_q\ : std_logic;
SIGNAL \SrcB[14]~28_combout\ : std_logic;
SIGNAL \RegFile|mem~116feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~116_q\ : std_logic;
SIGNAL \RegFile|mem~52_q\ : std_logic;
SIGNAL \RegFile|mem~1094_combout\ : std_logic;
SIGNAL \SrcB[14]~29_combout\ : std_logic;
SIGNAL \SrcB[14]~30_combout\ : std_logic;
SIGNAL \CoreALU|Add1~29\ : std_logic;
SIGNAL \CoreALU|Add1~30_combout\ : std_logic;
SIGNAL \CoreALU|Add0~29\ : std_logic;
SIGNAL \CoreALU|Add0~30_combout\ : std_logic;
SIGNAL \CoreALU|Mux16~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux16~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux16~combout\ : std_logic;
SIGNAL \RegFile|mem~213_q\ : std_logic;
SIGNAL \RegFile|mem~277_q\ : std_logic;
SIGNAL \RegFile|mem~1095_combout\ : std_logic;
SIGNAL \RegFile|mem~117_q\ : std_logic;
SIGNAL \RegFile|mem~53_q\ : std_logic;
SIGNAL \RegFile|mem~1096_combout\ : std_logic;
SIGNAL \SrcB[15]~31_combout\ : std_logic;
SIGNAL \CoreALU|Add1~31\ : std_logic;
SIGNAL \CoreALU|Add1~32_combout\ : std_logic;
SIGNAL \CoreALU|Add0~31\ : std_logic;
SIGNAL \CoreALU|Add0~32_combout\ : std_logic;
SIGNAL \CoreALU|Mux15~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux15~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux15~combout\ : std_logic;
SIGNAL \RegFile|mem~86_q\ : std_logic;
SIGNAL \RegFile|rd1[16]~80_combout\ : std_logic;
SIGNAL \CoreALU|Add1~33\ : std_logic;
SIGNAL \CoreALU|Add1~34_combout\ : std_logic;
SIGNAL \CoreALU|Add0~33\ : std_logic;
SIGNAL \CoreALU|Add0~34_combout\ : std_logic;
SIGNAL \CoreALU|Mux14~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux14~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux14~combout\ : std_logic;
SIGNAL \RegFile|mem~87_q\ : std_logic;
SIGNAL \RegFile|rd1[17]~81_combout\ : std_logic;
SIGNAL \CoreALU|Add1~35\ : std_logic;
SIGNAL \CoreALU|Add1~36_combout\ : std_logic;
SIGNAL \CoreALU|Add0~35\ : std_logic;
SIGNAL \CoreALU|Add0~36_combout\ : std_logic;
SIGNAL \CoreALU|Mux13~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux13~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux13~combout\ : std_logic;
SIGNAL \RegFile|mem~120_q\ : std_logic;
SIGNAL \RegFile|mem~56_q\ : std_logic;
SIGNAL \RegFile|mem~1102_combout\ : std_logic;
SIGNAL \RegFile|mem~216feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~216_q\ : std_logic;
SIGNAL \RegFile|mem~280_q\ : std_logic;
SIGNAL \RegFile|mem~1101_combout\ : std_logic;
SIGNAL \SrcB[18]~34_combout\ : std_logic;
SIGNAL \CoreALU|Add1~37\ : std_logic;
SIGNAL \CoreALU|Add1~38_combout\ : std_logic;
SIGNAL \CoreALU|Add0~37\ : std_logic;
SIGNAL \CoreALU|Add0~38_combout\ : std_logic;
SIGNAL \CoreALU|Mux12~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux12~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux12~combout\ : std_logic;
SIGNAL \RegFile|mem~121_q\ : std_logic;
SIGNAL \RegFile|mem~57_q\ : std_logic;
SIGNAL \RegFile|mem~1104_combout\ : std_logic;
SIGNAL \RegFile|mem~217feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~217_q\ : std_logic;
SIGNAL \RegFile|mem~281_q\ : std_logic;
SIGNAL \RegFile|mem~1103_combout\ : std_logic;
SIGNAL \SrcB[19]~35_combout\ : std_logic;
SIGNAL \CoreALU|Add1~39\ : std_logic;
SIGNAL \CoreALU|Add1~40_combout\ : std_logic;
SIGNAL \CoreALU|Add0~39\ : std_logic;
SIGNAL \CoreALU|Add0~40_combout\ : std_logic;
SIGNAL \CoreALU|Mux11~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux11~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux11~combout\ : std_logic;
SIGNAL \RegFile|mem~218feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~218_q\ : std_logic;
SIGNAL \RegFile|mem~282_q\ : std_logic;
SIGNAL \RegFile|mem~1105_combout\ : std_logic;
SIGNAL \RegFile|mem~58_q\ : std_logic;
SIGNAL \RegFile|mem~122_q\ : std_logic;
SIGNAL \RegFile|mem~1106_combout\ : std_logic;
SIGNAL \SrcB[20]~36_combout\ : std_logic;
SIGNAL \CoreALU|Add1~41\ : std_logic;
SIGNAL \CoreALU|Add1~42_combout\ : std_logic;
SIGNAL \CoreALU|Add0~41\ : std_logic;
SIGNAL \CoreALU|Add0~42_combout\ : std_logic;
SIGNAL \CoreALU|Mux10~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux10~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux10~combout\ : std_logic;
SIGNAL \RegFile|mem~123_q\ : std_logic;
SIGNAL \RegFile|mem~59_q\ : std_logic;
SIGNAL \RegFile|mem~1108_combout\ : std_logic;
SIGNAL \RegFile|mem~219feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~219_q\ : std_logic;
SIGNAL \RegFile|mem~283_q\ : std_logic;
SIGNAL \RegFile|mem~1107_combout\ : std_logic;
SIGNAL \SrcB[21]~37_combout\ : std_logic;
SIGNAL \CoreALU|Add1~43\ : std_logic;
SIGNAL \CoreALU|Add1~44_combout\ : std_logic;
SIGNAL \CoreALU|Add0~43\ : std_logic;
SIGNAL \CoreALU|Add0~44_combout\ : std_logic;
SIGNAL \CoreALU|Mux9~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux9~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux9~combout\ : std_logic;
SIGNAL \RegFile|mem~92_q\ : std_logic;
SIGNAL \RegFile|rd1[22]~86_combout\ : std_logic;
SIGNAL \CoreALU|Add1~45\ : std_logic;
SIGNAL \CoreALU|Add1~46_combout\ : std_logic;
SIGNAL \CoreALU|Add0~45\ : std_logic;
SIGNAL \CoreALU|Add0~46_combout\ : std_logic;
SIGNAL \CoreALU|Mux8~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux8~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux8~combout\ : std_logic;
SIGNAL \RegFile|mem~125_q\ : std_logic;
SIGNAL \RegFile|mem~61_q\ : std_logic;
SIGNAL \RegFile|mem~1112_combout\ : std_logic;
SIGNAL \RegFile|mem~221feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~221_q\ : std_logic;
SIGNAL \RegFile|mem~285_q\ : std_logic;
SIGNAL \RegFile|mem~1111_combout\ : std_logic;
SIGNAL \SrcB[23]~39_combout\ : std_logic;
SIGNAL \CoreALU|Add1~47\ : std_logic;
SIGNAL \CoreALU|Add1~48_combout\ : std_logic;
SIGNAL \CoreALU|Add0~47\ : std_logic;
SIGNAL \CoreALU|Add0~48_combout\ : std_logic;
SIGNAL \CoreALU|Mux7~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux7~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux7~combout\ : std_logic;
SIGNAL \RegFile|mem~126_q\ : std_logic;
SIGNAL \RegFile|mem~62_q\ : std_logic;
SIGNAL \RegFile|mem~1114_combout\ : std_logic;
SIGNAL \RegFile|mem~222feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~222_q\ : std_logic;
SIGNAL \RegFile|mem~286_q\ : std_logic;
SIGNAL \RegFile|mem~1113_combout\ : std_logic;
SIGNAL \SrcB[24]~40_combout\ : std_logic;
SIGNAL \CoreALU|Add1~49\ : std_logic;
SIGNAL \CoreALU|Add1~50_combout\ : std_logic;
SIGNAL \CoreALU|Add0~49\ : std_logic;
SIGNAL \CoreALU|Add0~50_combout\ : std_logic;
SIGNAL \CoreALU|Mux6~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux6~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux6~combout\ : std_logic;
SIGNAL \RegFile|mem~95_q\ : std_logic;
SIGNAL \RegFile|rd1[25]~89_combout\ : std_logic;
SIGNAL \CoreALU|Add1~51\ : std_logic;
SIGNAL \CoreALU|Add1~52_combout\ : std_logic;
SIGNAL \CoreALU|Add0~51\ : std_logic;
SIGNAL \CoreALU|Add0~52_combout\ : std_logic;
SIGNAL \CoreALU|Mux5~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux5~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux5~combout\ : std_logic;
SIGNAL \RegFile|mem~96_q\ : std_logic;
SIGNAL \RegFile|rd1[26]~90_combout\ : std_logic;
SIGNAL \CoreALU|Add1~53\ : std_logic;
SIGNAL \CoreALU|Add1~54_combout\ : std_logic;
SIGNAL \CoreALU|Add0~53\ : std_logic;
SIGNAL \CoreALU|Add0~54_combout\ : std_logic;
SIGNAL \CoreALU|Mux4~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux4~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux4~combout\ : std_logic;
SIGNAL \RegFile|mem~225feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~225_q\ : std_logic;
SIGNAL \RegFile|mem~289_q\ : std_logic;
SIGNAL \RegFile|mem~1119_combout\ : std_logic;
SIGNAL \RegFile|mem~129_q\ : std_logic;
SIGNAL \RegFile|mem~65_q\ : std_logic;
SIGNAL \RegFile|mem~1120_combout\ : std_logic;
SIGNAL \SrcB[27]~43_combout\ : std_logic;
SIGNAL \CoreALU|Add1~55\ : std_logic;
SIGNAL \CoreALU|Add1~56_combout\ : std_logic;
SIGNAL \CoreALU|Add0~55\ : std_logic;
SIGNAL \CoreALU|Add0~56_combout\ : std_logic;
SIGNAL \CoreALU|Mux3~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux3~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux3~combout\ : std_logic;
SIGNAL \RegFile|mem~130_q\ : std_logic;
SIGNAL \RegFile|mem~66_q\ : std_logic;
SIGNAL \RegFile|mem~1122_combout\ : std_logic;
SIGNAL \RegFile|mem~226_q\ : std_logic;
SIGNAL \RegFile|mem~290_q\ : std_logic;
SIGNAL \RegFile|mem~1121_combout\ : std_logic;
SIGNAL \SrcB[28]~44_combout\ : std_logic;
SIGNAL \CoreALU|Add1~57\ : std_logic;
SIGNAL \CoreALU|Add1~58_combout\ : std_logic;
SIGNAL \CoreALU|Add0~57\ : std_logic;
SIGNAL \CoreALU|Add0~58_combout\ : std_logic;
SIGNAL \CoreALU|Mux2~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux2~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux2~combout\ : std_logic;
SIGNAL \RegFile|mem~99_q\ : std_logic;
SIGNAL \RegFile|rd1[29]~93_combout\ : std_logic;
SIGNAL \CoreALU|Add1~59\ : std_logic;
SIGNAL \CoreALU|Add1~60_combout\ : std_logic;
SIGNAL \CoreALU|Add0~59\ : std_logic;
SIGNAL \CoreALU|Add0~60_combout\ : std_logic;
SIGNAL \CoreALU|Mux1~3_combout\ : std_logic;
SIGNAL \CoreALU|Mux1~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux1~combout\ : std_logic;
SIGNAL \RegFile|mem~101_q\ : std_logic;
SIGNAL \RegFile|rd1[31]~95_combout\ : std_logic;
SIGNAL \RegFile|mem~293feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~293_q\ : std_logic;
SIGNAL \RegFile|mem~229feeder_combout\ : std_logic;
SIGNAL \RegFile|mem~229_q\ : std_logic;
SIGNAL \RegFile|mem~1127_combout\ : std_logic;
SIGNAL \RegFile|mem~133_q\ : std_logic;
SIGNAL \RegFile|mem~69_q\ : std_logic;
SIGNAL \RegFile|mem~1128_combout\ : std_logic;
SIGNAL \SrcB[31]~47_combout\ : std_logic;
SIGNAL \CoreALU|Add1~61\ : std_logic;
SIGNAL \CoreALU|Add1~62_combout\ : std_logic;
SIGNAL \CoreALU|Add0~61\ : std_logic;
SIGNAL \CoreALU|Add0~62_combout\ : std_logic;
SIGNAL \CoreALU|Mux0~4_combout\ : std_logic;
SIGNAL \CoreALU|Mux0~2_combout\ : std_logic;
SIGNAL \CoreALU|Mux0~3_combout\ : std_logic;
SIGNAL \PCSrc~2_combout\ : std_logic;
SIGNAL \PCSrc~3_combout\ : std_logic;
SIGNAL \PCSrc~1_combout\ : std_logic;
SIGNAL \PCSrc~4_combout\ : std_logic;
SIGNAL \PCSrc~5_combout\ : std_logic;
SIGNAL \PCSrc~8_combout\ : std_logic;
SIGNAL \PCSrc~7_combout\ : std_logic;
SIGNAL \PCSrc~9_combout\ : std_logic;
SIGNAL \PCSrc~6_combout\ : std_logic;
SIGNAL \PCSrc~10_combout\ : std_logic;
SIGNAL \PCSrc~11_combout\ : std_logic;
SIGNAL \ExtUnit|Mux28~2_combout\ : std_logic;
SIGNAL \ExtUnit|Mux28~3_combout\ : std_logic;
SIGNAL \BranchTarget[0]~1\ : std_logic;
SIGNAL \BranchTarget[1]~2_combout\ : std_logic;
SIGNAL \BranchTarget[1]~3\ : std_logic;
SIGNAL \BranchTarget[2]~5\ : std_logic;
SIGNAL \BranchTarget[3]~7\ : std_logic;
SIGNAL \BranchTarget[4]~9\ : std_logic;
SIGNAL \BranchTarget[5]~10_combout\ : std_logic;
SIGNAL \ExtUnit|Mux29~3_combout\ : std_logic;
SIGNAL \ExtUnit|Mux29~12_combout\ : std_logic;
SIGNAL \BranchTarget[2]~4_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[2]~31\ : std_logic;
SIGNAL \PC_Reg|PC_out[3]~32_combout\ : std_logic;
SIGNAL \BranchTarget[3]~6_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[3]~33\ : std_logic;
SIGNAL \PC_Reg|PC_out[4]~34_combout\ : std_logic;
SIGNAL \BranchTarget[4]~8_combout\ : std_logic;
SIGNAL \InstMem|Mux13~1_combout\ : std_logic;
SIGNAL \ExtUnit|Mux31~0_combout\ : std_logic;
SIGNAL \ExtUnit|Mux31~1_combout\ : std_logic;
SIGNAL \BranchTarget[0]~0_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[7]~41\ : std_logic;
SIGNAL \PC_Reg|PC_out[8]~42_combout\ : std_logic;
SIGNAL \BranchTarget[7]~15\ : std_logic;
SIGNAL \BranchTarget[8]~16_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[8]~43\ : std_logic;
SIGNAL \PC_Reg|PC_out[9]~44_combout\ : std_logic;
SIGNAL \BranchTarget[8]~17\ : std_logic;
SIGNAL \BranchTarget[9]~18_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[9]~45\ : std_logic;
SIGNAL \PC_Reg|PC_out[10]~46_combout\ : std_logic;
SIGNAL \ExtUnit|Mux21~3_combout\ : std_logic;
SIGNAL \ExtUnit|Mux21~2_combout\ : std_logic;
SIGNAL \BranchTarget[9]~19\ : std_logic;
SIGNAL \BranchTarget[10]~20_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[10]~47\ : std_logic;
SIGNAL \PC_Reg|PC_out[11]~48_combout\ : std_logic;
SIGNAL \ExtUnit|Mux20~2_combout\ : std_logic;
SIGNAL \BranchTarget[10]~21\ : std_logic;
SIGNAL \BranchTarget[11]~22_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[11]~49\ : std_logic;
SIGNAL \PC_Reg|PC_out[12]~50_combout\ : std_logic;
SIGNAL \BranchTarget[11]~23\ : std_logic;
SIGNAL \BranchTarget[12]~24_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[12]~51\ : std_logic;
SIGNAL \PC_Reg|PC_out[13]~52_combout\ : std_logic;
SIGNAL \BranchTarget[12]~25\ : std_logic;
SIGNAL \BranchTarget[13]~26_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[13]~53\ : std_logic;
SIGNAL \PC_Reg|PC_out[14]~54_combout\ : std_logic;
SIGNAL \BranchTarget[13]~27\ : std_logic;
SIGNAL \BranchTarget[14]~28_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[14]~55\ : std_logic;
SIGNAL \PC_Reg|PC_out[15]~56_combout\ : std_logic;
SIGNAL \BranchTarget[14]~29\ : std_logic;
SIGNAL \BranchTarget[15]~30_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[15]~57\ : std_logic;
SIGNAL \PC_Reg|PC_out[16]~58_combout\ : std_logic;
SIGNAL \BranchTarget[15]~31\ : std_logic;
SIGNAL \BranchTarget[16]~32_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[16]~59\ : std_logic;
SIGNAL \PC_Reg|PC_out[17]~60_combout\ : std_logic;
SIGNAL \BranchTarget[16]~33\ : std_logic;
SIGNAL \BranchTarget[17]~34_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[17]~61\ : std_logic;
SIGNAL \PC_Reg|PC_out[18]~62_combout\ : std_logic;
SIGNAL \BranchTarget[17]~35\ : std_logic;
SIGNAL \BranchTarget[18]~36_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[18]~63\ : std_logic;
SIGNAL \PC_Reg|PC_out[19]~64_combout\ : std_logic;
SIGNAL \BranchTarget[18]~37\ : std_logic;
SIGNAL \BranchTarget[19]~38_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[19]~65\ : std_logic;
SIGNAL \PC_Reg|PC_out[20]~66_combout\ : std_logic;
SIGNAL \BranchTarget[19]~39\ : std_logic;
SIGNAL \BranchTarget[20]~40_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[20]~67\ : std_logic;
SIGNAL \PC_Reg|PC_out[21]~68_combout\ : std_logic;
SIGNAL \BranchTarget[20]~41\ : std_logic;
SIGNAL \BranchTarget[21]~42_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[21]~69\ : std_logic;
SIGNAL \PC_Reg|PC_out[22]~70_combout\ : std_logic;
SIGNAL \BranchTarget[21]~43\ : std_logic;
SIGNAL \BranchTarget[22]~44_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[22]~71\ : std_logic;
SIGNAL \PC_Reg|PC_out[23]~72_combout\ : std_logic;
SIGNAL \BranchTarget[22]~45\ : std_logic;
SIGNAL \BranchTarget[23]~46_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[23]~73\ : std_logic;
SIGNAL \PC_Reg|PC_out[24]~74_combout\ : std_logic;
SIGNAL \BranchTarget[23]~47\ : std_logic;
SIGNAL \BranchTarget[24]~48_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[24]~75\ : std_logic;
SIGNAL \PC_Reg|PC_out[25]~76_combout\ : std_logic;
SIGNAL \BranchTarget[24]~49\ : std_logic;
SIGNAL \BranchTarget[25]~50_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[25]~77\ : std_logic;
SIGNAL \PC_Reg|PC_out[26]~78_combout\ : std_logic;
SIGNAL \BranchTarget[25]~51\ : std_logic;
SIGNAL \BranchTarget[26]~52_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[26]~79\ : std_logic;
SIGNAL \PC_Reg|PC_out[27]~80_combout\ : std_logic;
SIGNAL \BranchTarget[26]~53\ : std_logic;
SIGNAL \BranchTarget[27]~54_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[27]~81\ : std_logic;
SIGNAL \PC_Reg|PC_out[28]~82_combout\ : std_logic;
SIGNAL \BranchTarget[27]~55\ : std_logic;
SIGNAL \BranchTarget[28]~56_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[28]~83\ : std_logic;
SIGNAL \PC_Reg|PC_out[29]~84_combout\ : std_logic;
SIGNAL \BranchTarget[28]~57\ : std_logic;
SIGNAL \BranchTarget[29]~58_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[29]~85\ : std_logic;
SIGNAL \PC_Reg|PC_out[30]~86_combout\ : std_logic;
SIGNAL \BranchTarget[29]~59\ : std_logic;
SIGNAL \BranchTarget[30]~60_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out[30]~87\ : std_logic;
SIGNAL \PC_Reg|PC_out[31]~88_combout\ : std_logic;
SIGNAL \BranchTarget[30]~61\ : std_logic;
SIGNAL \BranchTarget[31]~62_combout\ : std_logic;
SIGNAL \PC_Reg|PC_out\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \InstMem|ALT_INV_Mux15~1_combout\ : std_logic;
SIGNAL \InstMem|ALT_INV_Mux12~3_combout\ : std_logic;
SIGNAL \InstMem|ALT_INV_Mux17~3_combout\ : std_logic;
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
PC_debug <= ww_PC_debug;
instr_debug <= ww_instr_debug;
ALU_debug <= ww_ALU_debug;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\InstMem|ALT_INV_Mux15~1_combout\ <= NOT \InstMem|Mux15~1_combout\;
\InstMem|ALT_INV_Mux12~3_combout\ <= NOT \InstMem|Mux12~3_combout\;
\InstMem|ALT_INV_Mux17~3_combout\ <= NOT \InstMem|Mux17~3_combout\;
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;
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

-- Location: IOOBUF_X26_Y39_N16
\PC_debug[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(0),
	devoe => ww_devoe,
	o => \PC_debug[0]~output_o\);

-- Location: IOOBUF_X26_Y39_N23
\PC_debug[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(1),
	devoe => ww_devoe,
	o => \PC_debug[1]~output_o\);

-- Location: IOOBUF_X22_Y0_N30
\PC_debug[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(2),
	devoe => ww_devoe,
	o => \PC_debug[2]~output_o\);

-- Location: IOOBUF_X22_Y0_N23
\PC_debug[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(3),
	devoe => ww_devoe,
	o => \PC_debug[3]~output_o\);

-- Location: IOOBUF_X22_Y0_N16
\PC_debug[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(4),
	devoe => ww_devoe,
	o => \PC_debug[4]~output_o\);

-- Location: IOOBUF_X0_Y9_N23
\PC_debug[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(5),
	devoe => ww_devoe,
	o => \PC_debug[5]~output_o\);

-- Location: IOOBUF_X0_Y3_N23
\PC_debug[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(6),
	devoe => ww_devoe,
	o => \PC_debug[6]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\PC_debug[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(7),
	devoe => ww_devoe,
	o => \PC_debug[7]~output_o\);

-- Location: IOOBUF_X38_Y0_N9
\PC_debug[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(8),
	devoe => ww_devoe,
	o => \PC_debug[8]~output_o\);

-- Location: IOOBUF_X31_Y0_N16
\PC_debug[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(9),
	devoe => ww_devoe,
	o => \PC_debug[9]~output_o\);

-- Location: IOOBUF_X49_Y0_N9
\PC_debug[10]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(10),
	devoe => ww_devoe,
	o => \PC_debug[10]~output_o\);

-- Location: IOOBUF_X0_Y10_N16
\PC_debug[11]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(11),
	devoe => ww_devoe,
	o => \PC_debug[11]~output_o\);

-- Location: IOOBUF_X24_Y39_N16
\PC_debug[12]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(12),
	devoe => ww_devoe,
	o => \PC_debug[12]~output_o\);

-- Location: IOOBUF_X36_Y0_N9
\PC_debug[13]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(13),
	devoe => ww_devoe,
	o => \PC_debug[13]~output_o\);

-- Location: IOOBUF_X34_Y0_N23
\PC_debug[14]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(14),
	devoe => ww_devoe,
	o => \PC_debug[14]~output_o\);

-- Location: IOOBUF_X31_Y0_N23
\PC_debug[15]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(15),
	devoe => ww_devoe,
	o => \PC_debug[15]~output_o\);

-- Location: IOOBUF_X0_Y9_N16
\PC_debug[16]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(16),
	devoe => ww_devoe,
	o => \PC_debug[16]~output_o\);

-- Location: IOOBUF_X26_Y0_N30
\PC_debug[17]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(17),
	devoe => ww_devoe,
	o => \PC_debug[17]~output_o\);

-- Location: IOOBUF_X29_Y0_N30
\PC_debug[18]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(18),
	devoe => ww_devoe,
	o => \PC_debug[18]~output_o\);

-- Location: IOOBUF_X26_Y0_N23
\PC_debug[19]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(19),
	devoe => ww_devoe,
	o => \PC_debug[19]~output_o\);

-- Location: IOOBUF_X24_Y39_N2
\PC_debug[20]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(20),
	devoe => ww_devoe,
	o => \PC_debug[20]~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\PC_debug[21]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(21),
	devoe => ww_devoe,
	o => \PC_debug[21]~output_o\);

-- Location: IOOBUF_X31_Y0_N30
\PC_debug[22]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(22),
	devoe => ww_devoe,
	o => \PC_debug[22]~output_o\);

-- Location: IOOBUF_X24_Y0_N16
\PC_debug[23]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(23),
	devoe => ww_devoe,
	o => \PC_debug[23]~output_o\);

-- Location: IOOBUF_X24_Y0_N2
\PC_debug[24]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(24),
	devoe => ww_devoe,
	o => \PC_debug[24]~output_o\);

-- Location: IOOBUF_X31_Y0_N9
\PC_debug[25]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(25),
	devoe => ww_devoe,
	o => \PC_debug[25]~output_o\);

-- Location: IOOBUF_X29_Y0_N9
\PC_debug[26]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(26),
	devoe => ww_devoe,
	o => \PC_debug[26]~output_o\);

-- Location: IOOBUF_X26_Y0_N16
\PC_debug[27]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(27),
	devoe => ww_devoe,
	o => \PC_debug[27]~output_o\);

-- Location: IOOBUF_X29_Y0_N2
\PC_debug[28]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(28),
	devoe => ww_devoe,
	o => \PC_debug[28]~output_o\);

-- Location: IOOBUF_X26_Y39_N30
\PC_debug[29]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(29),
	devoe => ww_devoe,
	o => \PC_debug[29]~output_o\);

-- Location: IOOBUF_X24_Y39_N9
\PC_debug[30]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(30),
	devoe => ww_devoe,
	o => \PC_debug[30]~output_o\);

-- Location: IOOBUF_X31_Y0_N2
\PC_debug[31]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_Reg|PC_out\(31),
	devoe => ww_devoe,
	o => \PC_debug[31]~output_o\);

-- Location: IOOBUF_X16_Y0_N23
\instr_debug[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|ALT_INV_Mux17~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[0]~output_o\);

-- Location: IOOBUF_X16_Y0_N30
\instr_debug[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|ALT_INV_Mux17~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[1]~output_o\);

-- Location: IOOBUF_X24_Y39_N23
\instr_debug[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[2]~output_o\);

-- Location: IOOBUF_X60_Y54_N30
\instr_debug[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[3]~output_o\);

-- Location: IOOBUF_X18_Y0_N23
\instr_debug[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|ALT_INV_Mux15~1_combout\,
	devoe => ww_devoe,
	o => \instr_debug[4]~output_o\);

-- Location: IOOBUF_X0_Y12_N16
\instr_debug[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux14~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[5]~output_o\);

-- Location: IOOBUF_X16_Y0_N9
\instr_debug[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux13~1_combout\,
	devoe => ww_devoe,
	o => \instr_debug[6]~output_o\);

-- Location: IOOBUF_X20_Y39_N9
\instr_debug[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|ALT_INV_Mux12~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[7]~output_o\);

-- Location: IOOBUF_X0_Y9_N9
\instr_debug[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux11~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[8]~output_o\);

-- Location: IOOBUF_X46_Y0_N9
\instr_debug[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux10~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[9]~output_o\);

-- Location: IOOBUF_X16_Y0_N16
\instr_debug[10]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux13~1_combout\,
	devoe => ww_devoe,
	o => \instr_debug[10]~output_o\);

-- Location: IOOBUF_X46_Y54_N16
\instr_debug[11]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[11]~output_o\);

-- Location: IOOBUF_X20_Y0_N2
\instr_debug[12]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux8~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[12]~output_o\);

-- Location: IOOBUF_X46_Y0_N2
\instr_debug[13]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux10~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[13]~output_o\);

-- Location: IOOBUF_X40_Y0_N2
\instr_debug[14]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux10~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[14]~output_o\);

-- Location: IOOBUF_X0_Y12_N2
\instr_debug[15]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux14~3_combout\,
	devoe => ww_devoe,
	o => \instr_debug[15]~output_o\);

-- Location: IOOBUF_X34_Y39_N9
\instr_debug[16]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[16]~output_o\);

-- Location: IOOBUF_X54_Y54_N2
\instr_debug[17]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[17]~output_o\);

-- Location: IOOBUF_X0_Y13_N9
\instr_debug[18]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[18]~output_o\);

-- Location: IOOBUF_X0_Y29_N9
\instr_debug[19]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[19]~output_o\);

-- Location: IOOBUF_X36_Y0_N2
\instr_debug[20]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux4~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[20]~output_o\);

-- Location: IOOBUF_X20_Y0_N23
\instr_debug[21]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux3~1_combout\,
	devoe => ww_devoe,
	o => \instr_debug[21]~output_o\);

-- Location: IOOBUF_X34_Y0_N16
\instr_debug[22]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux4~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[22]~output_o\);

-- Location: IOOBUF_X20_Y0_N30
\instr_debug[23]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux1~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[23]~output_o\);

-- Location: IOOBUF_X0_Y36_N9
\instr_debug[24]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[24]~output_o\);

-- Location: IOOBUF_X78_Y24_N16
\instr_debug[25]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[25]~output_o\);

-- Location: IOOBUF_X58_Y0_N23
\instr_debug[26]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[26]~output_o\);

-- Location: IOOBUF_X54_Y54_N9
\instr_debug[27]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[27]~output_o\);

-- Location: IOOBUF_X78_Y16_N9
\instr_debug[28]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[28]~output_o\);

-- Location: IOOBUF_X78_Y17_N2
\instr_debug[29]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[29]~output_o\);

-- Location: IOOBUF_X0_Y9_N2
\instr_debug[30]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstMem|Mux0~0_combout\,
	devoe => ww_devoe,
	o => \instr_debug[30]~output_o\);

-- Location: IOOBUF_X60_Y54_N9
\instr_debug[31]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \instr_debug[31]~output_o\);

-- Location: IOOBUF_X22_Y0_N9
\ALU_debug[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux31~3_combout\,
	devoe => ww_devoe,
	o => \ALU_debug[0]~output_o\);

-- Location: IOOBUF_X29_Y0_N16
\ALU_debug[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux30~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[1]~output_o\);

-- Location: IOOBUF_X38_Y0_N16
\ALU_debug[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux29~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[2]~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\ALU_debug[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux28~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[3]~output_o\);

-- Location: IOOBUF_X22_Y0_N2
\ALU_debug[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux27~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[4]~output_o\);

-- Location: IOOBUF_X24_Y0_N30
\ALU_debug[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux26~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[5]~output_o\);

-- Location: IOOBUF_X14_Y0_N9
\ALU_debug[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux25~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[6]~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\ALU_debug[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux24~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[7]~output_o\);

-- Location: IOOBUF_X0_Y3_N16
\ALU_debug[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux23~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[8]~output_o\);

-- Location: IOOBUF_X18_Y0_N16
\ALU_debug[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux22~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[9]~output_o\);

-- Location: IOOBUF_X24_Y0_N23
\ALU_debug[10]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux21~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[10]~output_o\);

-- Location: IOOBUF_X14_Y0_N16
\ALU_debug[11]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux20~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[11]~output_o\);

-- Location: IOOBUF_X40_Y0_N16
\ALU_debug[12]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux19~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[12]~output_o\);

-- Location: IOOBUF_X29_Y0_N23
\ALU_debug[13]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux18~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[13]~output_o\);

-- Location: IOOBUF_X34_Y0_N30
\ALU_debug[14]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux17~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[14]~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\ALU_debug[15]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux16~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[15]~output_o\);

-- Location: IOOBUF_X20_Y0_N16
\ALU_debug[16]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux15~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[16]~output_o\);

-- Location: IOOBUF_X0_Y3_N9
\ALU_debug[17]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux14~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[17]~output_o\);

-- Location: IOOBUF_X18_Y0_N9
\ALU_debug[18]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux13~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[18]~output_o\);

-- Location: IOOBUF_X16_Y0_N2
\ALU_debug[19]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux12~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[19]~output_o\);

-- Location: IOOBUF_X34_Y0_N9
\ALU_debug[20]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux11~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[20]~output_o\);

-- Location: IOOBUF_X38_Y0_N2
\ALU_debug[21]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux10~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[21]~output_o\);

-- Location: IOOBUF_X34_Y0_N2
\ALU_debug[22]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux9~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[22]~output_o\);

-- Location: IOOBUF_X40_Y0_N9
\ALU_debug[23]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux8~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[23]~output_o\);

-- Location: IOOBUF_X38_Y0_N30
\ALU_debug[24]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux7~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[24]~output_o\);

-- Location: IOOBUF_X40_Y0_N30
\ALU_debug[25]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux6~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[25]~output_o\);

-- Location: IOOBUF_X38_Y0_N23
\ALU_debug[26]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux5~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[26]~output_o\);

-- Location: IOOBUF_X0_Y3_N2
\ALU_debug[27]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux4~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[27]~output_o\);

-- Location: IOOBUF_X0_Y12_N9
\ALU_debug[28]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux3~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[28]~output_o\);

-- Location: IOOBUF_X18_Y0_N30
\ALU_debug[29]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux2~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[29]~output_o\);

-- Location: IOOBUF_X20_Y39_N2
\ALU_debug[30]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux1~combout\,
	devoe => ww_devoe,
	o => \ALU_debug[30]~output_o\);

-- Location: IOOBUF_X18_Y0_N2
\ALU_debug[31]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \CoreALU|Mux0~3_combout\,
	devoe => ww_devoe,
	o => \ALU_debug[31]~output_o\);

-- Location: IOIBUF_X0_Y18_N15
\clk~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G3
\clk~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X25_Y2_N2
\PC_Reg|PC_out[2]~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[2]~30_combout\ = \PC_Reg|PC_out\(2) $ (VCC)
-- \PC_Reg|PC_out[2]~31\ = CARRY(\PC_Reg|PC_out\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(2),
	datad => VCC,
	combout => \PC_Reg|PC_out[2]~30_combout\,
	cout => \PC_Reg|PC_out[2]~31\);

-- Location: LCCOMB_X25_Y2_N6
\PC_Reg|PC_out[4]~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[4]~34_combout\ = (\PC_Reg|PC_out\(4) & (\PC_Reg|PC_out[3]~33\ $ (GND))) # (!\PC_Reg|PC_out\(4) & (!\PC_Reg|PC_out[3]~33\ & VCC))
-- \PC_Reg|PC_out[4]~35\ = CARRY((\PC_Reg|PC_out\(4) & !\PC_Reg|PC_out[3]~33\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datad => VCC,
	cin => \PC_Reg|PC_out[3]~33\,
	combout => \PC_Reg|PC_out[4]~34_combout\,
	cout => \PC_Reg|PC_out[4]~35\);

-- Location: LCCOMB_X25_Y2_N8
\PC_Reg|PC_out[5]~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[5]~36_combout\ = (\PC_Reg|PC_out\(5) & (!\PC_Reg|PC_out[4]~35\)) # (!\PC_Reg|PC_out\(5) & ((\PC_Reg|PC_out[4]~35\) # (GND)))
-- \PC_Reg|PC_out[5]~37\ = CARRY((!\PC_Reg|PC_out[4]~35\) # (!\PC_Reg|PC_out\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(5),
	datad => VCC,
	cin => \PC_Reg|PC_out[4]~35\,
	combout => \PC_Reg|PC_out[5]~36_combout\,
	cout => \PC_Reg|PC_out[5]~37\);

-- Location: LCCOMB_X25_Y2_N10
\PC_Reg|PC_out[6]~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[6]~38_combout\ = (\PC_Reg|PC_out\(6) & (\PC_Reg|PC_out[5]~37\ $ (GND))) # (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out[5]~37\ & VCC))
-- \PC_Reg|PC_out[6]~39\ = CARRY((\PC_Reg|PC_out\(6) & !\PC_Reg|PC_out[5]~37\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datad => VCC,
	cin => \PC_Reg|PC_out[5]~37\,
	combout => \PC_Reg|PC_out[6]~38_combout\,
	cout => \PC_Reg|PC_out[6]~39\);

-- Location: LCCOMB_X26_Y2_N10
\BranchTarget[5]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[5]~10_combout\ = (\PC_Reg|PC_out\(5) & (!\BranchTarget[4]~9\)) # (!\PC_Reg|PC_out\(5) & ((\BranchTarget[4]~9\) # (GND)))
-- \BranchTarget[5]~11\ = CARRY((!\BranchTarget[4]~9\) # (!\PC_Reg|PC_out\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datad => VCC,
	cin => \BranchTarget[4]~9\,
	combout => \BranchTarget[5]~10_combout\,
	cout => \BranchTarget[5]~11\);

-- Location: LCCOMB_X26_Y2_N12
\BranchTarget[6]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[6]~12_combout\ = (\PC_Reg|PC_out\(6) & (\BranchTarget[5]~11\ $ (GND))) # (!\PC_Reg|PC_out\(6) & (!\BranchTarget[5]~11\ & VCC))
-- \BranchTarget[6]~13\ = CARRY((\PC_Reg|PC_out\(6) & !\BranchTarget[5]~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(6),
	datad => VCC,
	cin => \BranchTarget[5]~11\,
	combout => \BranchTarget[6]~12_combout\,
	cout => \BranchTarget[6]~13\);

-- Location: IOIBUF_X0_Y18_N22
\reset~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G4
\reset~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: LCCOMB_X25_Y2_N12
\PC_Reg|PC_out[7]~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[7]~40_combout\ = (\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out[6]~39\)) # (!\PC_Reg|PC_out\(7) & ((\PC_Reg|PC_out[6]~39\) # (GND)))
-- \PC_Reg|PC_out[7]~41\ = CARRY((!\PC_Reg|PC_out[6]~39\) # (!\PC_Reg|PC_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datad => VCC,
	cin => \PC_Reg|PC_out[6]~39\,
	combout => \PC_Reg|PC_out[7]~40_combout\,
	cout => \PC_Reg|PC_out[7]~41\);

-- Location: LCCOMB_X26_Y2_N14
\BranchTarget[7]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[7]~14_combout\ = (\PC_Reg|PC_out\(7) & (!\BranchTarget[6]~13\)) # (!\PC_Reg|PC_out\(7) & ((\BranchTarget[6]~13\) # (GND)))
-- \BranchTarget[7]~15\ = CARRY((!\BranchTarget[6]~13\) # (!\PC_Reg|PC_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datad => VCC,
	cin => \BranchTarget[6]~13\,
	combout => \BranchTarget[7]~14_combout\,
	cout => \BranchTarget[7]~15\);

-- Location: FF_X25_Y2_N13
\PC_Reg|PC_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[7]~40_combout\,
	asdata => \BranchTarget[7]~14_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(7));

-- Location: LCCOMB_X23_Y2_N10
\InstMem|Mux15~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux15~0_combout\ = (\PC_Reg|PC_out\(5)) # (\PC_Reg|PC_out\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \PC_Reg|PC_out\(5),
	datad => \PC_Reg|PC_out\(6),
	combout => \InstMem|Mux15~0_combout\);

-- Location: LCCOMB_X23_Y2_N4
\InstMem|Mux15~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux15~1_combout\ = (\PC_Reg|PC_out\(7)) # ((\InstMem|Mux15~0_combout\) # ((\PC_Reg|PC_out\(4) & \PC_Reg|PC_out\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \PC_Reg|PC_out\(7),
	datac => \PC_Reg|PC_out\(3),
	datad => \InstMem|Mux15~0_combout\,
	combout => \InstMem|Mux15~1_combout\);

-- Location: LCCOMB_X23_Y2_N24
\InstMem|Mux17~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux17~2_combout\ = (\PC_Reg|PC_out\(5)) # ((\PC_Reg|PC_out\(2) & (\PC_Reg|PC_out\(3) & \PC_Reg|PC_out\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datab => \PC_Reg|PC_out\(2),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(4),
	combout => \InstMem|Mux17~2_combout\);

-- Location: LCCOMB_X23_Y2_N22
\InstMem|Mux17~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux17~3_combout\ = (\PC_Reg|PC_out\(6)) # ((\PC_Reg|PC_out\(7)) # (\InstMem|Mux17~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux17~2_combout\,
	combout => \InstMem|Mux17~3_combout\);

-- Location: LCCOMB_X23_Y2_N2
\InstMem|Mux14~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux14~2_combout\ = (!\PC_Reg|PC_out\(5) & ((\PC_Reg|PC_out\(3) & ((!\PC_Reg|PC_out\(4)) # (!\PC_Reg|PC_out\(2)))) # (!\PC_Reg|PC_out\(3) & ((\PC_Reg|PC_out\(4))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datab => \PC_Reg|PC_out\(2),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(4),
	combout => \InstMem|Mux14~2_combout\);

-- Location: LCCOMB_X23_Y2_N20
\InstMem|Mux14~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux14~3_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & \InstMem|Mux14~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux14~2_combout\,
	combout => \InstMem|Mux14~3_combout\);

-- Location: LCCOMB_X22_Y2_N30
\PCSrc~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~0_combout\ = (\InstMem|Mux15~1_combout\ & (!\InstMem|Mux17~3_combout\ & (\InstMem|Mux14~3_combout\ & \InstMem|Mux13~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux17~3_combout\,
	datac => \InstMem|Mux14~3_combout\,
	datad => \InstMem|Mux13~1_combout\,
	combout => \PCSrc~0_combout\);

-- Location: LCCOMB_X24_Y2_N8
\InstMem|Mux13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux13~0_combout\ = (!\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out\(5) & !\PC_Reg|PC_out\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(7),
	datac => \PC_Reg|PC_out\(5),
	datad => \PC_Reg|PC_out\(6),
	combout => \InstMem|Mux13~0_combout\);

-- Location: LCCOMB_X23_Y5_N8
\InstMem|Mux8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux8~0_combout\ = (\PC_Reg|PC_out\(4) & (!\PC_Reg|PC_out\(3) & (!\PC_Reg|PC_out\(2) & \InstMem|Mux13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \PC_Reg|PC_out\(3),
	datac => \PC_Reg|PC_out\(2),
	datad => \InstMem|Mux13~0_combout\,
	combout => \InstMem|Mux8~0_combout\);

-- Location: LCCOMB_X23_Y1_N24
\InstMem|Mux10~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux10~0_combout\ = (!\PC_Reg|PC_out\(3) & (\PC_Reg|PC_out\(4) & \InstMem|Mux13~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(3),
	datab => \PC_Reg|PC_out\(4),
	datad => \InstMem|Mux13~0_combout\,
	combout => \InstMem|Mux10~0_combout\);

-- Location: LCCOMB_X22_Y1_N26
\Control|Mux4~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux4~1_combout\ = (\InstMem|Mux15~1_combout\) # ((\InstMem|Mux14~3_combout\ & ((\InstMem|Mux8~0_combout\) # (\InstMem|Mux10~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \InstMem|Mux10~0_combout\,
	combout => \Control|Mux4~1_combout\);

-- Location: LCCOMB_X22_Y1_N28
\Control|Mux4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux4~0_combout\ = (\InstMem|Mux17~3_combout\) # ((\InstMem|Mux13~1_combout\ & ((!\InstMem|Mux14~3_combout\) # (!\InstMem|Mux15~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux13~1_combout\,
	datac => \InstMem|Mux17~3_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \Control|Mux4~0_combout\);

-- Location: LCCOMB_X22_Y1_N2
\Control|Mux4~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux4~2_combout\ = (\Control|Mux4~0_combout\) # ((!\InstMem|Mux13~1_combout\ & \Control|Mux4~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \InstMem|Mux13~1_combout\,
	datac => \Control|Mux4~1_combout\,
	datad => \Control|Mux4~0_combout\,
	combout => \Control|Mux4~2_combout\);

-- Location: LCCOMB_X22_Y2_N20
\InstMem|Mux0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux0~0_combout\ = (\PC_Reg|PC_out\(2) & (!\PC_Reg|PC_out\(4) & (\PC_Reg|PC_out\(3) & \InstMem|Mux13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(2),
	datab => \PC_Reg|PC_out\(4),
	datac => \PC_Reg|PC_out\(3),
	datad => \InstMem|Mux13~0_combout\,
	combout => \InstMem|Mux0~0_combout\);

-- Location: LCCOMB_X22_Y2_N8
\Control|Mux3~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux3~3_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & !\InstMem|Mux17~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \InstMem|Mux14~2_combout\,
	datad => \InstMem|Mux17~2_combout\,
	combout => \Control|Mux3~3_combout\);

-- Location: LCCOMB_X22_Y1_N12
\Control|Mux3~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux3~2_combout\ = (\Control|Mux3~3_combout\ & ((\InstMem|Mux15~1_combout\ & (\InstMem|Mux13~1_combout\)) # (!\InstMem|Mux15~1_combout\ & ((\InstMem|Mux0~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux13~1_combout\,
	datac => \InstMem|Mux0~0_combout\,
	datad => \Control|Mux3~3_combout\,
	combout => \Control|Mux3~2_combout\);

-- Location: LCCOMB_X22_Y1_N30
\CoreALU|Mux31~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux31~0_combout\ = (!\Control|Mux3~2_combout\ & ((\Control|Mux4~0_combout\) # ((!\InstMem|Mux13~1_combout\ & \Control|Mux4~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux3~2_combout\,
	datab => \InstMem|Mux13~1_combout\,
	datac => \Control|Mux4~1_combout\,
	datad => \Control|Mux4~0_combout\,
	combout => \CoreALU|Mux31~0_combout\);

-- Location: LCCOMB_X24_Y2_N2
\InstMem|Mux3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux3~0_combout\ = (!\PC_Reg|PC_out\(5) & ((\PC_Reg|PC_out\(4) & ((!\PC_Reg|PC_out\(2)) # (!\PC_Reg|PC_out\(3)))) # (!\PC_Reg|PC_out\(4) & ((\PC_Reg|PC_out\(3)) # (\PC_Reg|PC_out\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \PC_Reg|PC_out\(5),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(2),
	combout => \InstMem|Mux3~0_combout\);

-- Location: LCCOMB_X24_Y2_N24
\InstMem|Mux3~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux3~1_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & \InstMem|Mux3~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux3~0_combout\,
	combout => \InstMem|Mux3~1_combout\);

-- Location: LCCOMB_X24_Y2_N0
\InstMem|Mux4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux4~0_combout\ = (!\PC_Reg|PC_out\(3) & (!\PC_Reg|PC_out\(2) & (\InstMem|Mux13~0_combout\ & !\PC_Reg|PC_out\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(3),
	datab => \PC_Reg|PC_out\(2),
	datac => \InstMem|Mux13~0_combout\,
	datad => \PC_Reg|PC_out\(4),
	combout => \InstMem|Mux4~0_combout\);

-- Location: LCCOMB_X24_Y2_N26
\InstMem|Mux1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux1~0_combout\ = (\PC_Reg|PC_out\(2) & (!\PC_Reg|PC_out\(4) & (\InstMem|Mux13~0_combout\ & !\PC_Reg|PC_out\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(2),
	datab => \PC_Reg|PC_out\(4),
	datac => \InstMem|Mux13~0_combout\,
	datad => \PC_Reg|PC_out\(3),
	combout => \InstMem|Mux1~0_combout\);

-- Location: LCCOMB_X22_Y2_N6
\InstMem|Mux11~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux11~2_combout\ = (!\PC_Reg|PC_out\(4) & (!\PC_Reg|PC_out\(5) & ((\PC_Reg|PC_out\(2)) # (\PC_Reg|PC_out\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(2),
	datab => \PC_Reg|PC_out\(4),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(5),
	combout => \InstMem|Mux11~2_combout\);

-- Location: LCCOMB_X22_Y5_N12
\InstMem|Mux11~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux11~3_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & \InstMem|Mux11~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux11~2_combout\,
	combout => \InstMem|Mux11~3_combout\);

-- Location: LCCOMB_X22_Y1_N6
\RegFile|mem~1129\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1129_combout\ = (!\InstMem|Mux15~1_combout\ & (!\InstMem|Mux13~1_combout\ & (!\InstMem|Mux17~3_combout\ & !\InstMem|Mux10~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux13~1_combout\,
	datac => \InstMem|Mux17~3_combout\,
	datad => \InstMem|Mux10~0_combout\,
	combout => \RegFile|mem~1129_combout\);

-- Location: LCCOMB_X22_Y2_N4
\InstMem|Mux12~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux12~2_combout\ = (\PC_Reg|PC_out\(5)) # (\PC_Reg|PC_out\(4) $ (((!\PC_Reg|PC_out\(3) & \PC_Reg|PC_out\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datab => \PC_Reg|PC_out\(4),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(2),
	combout => \InstMem|Mux12~2_combout\);

-- Location: LCCOMB_X22_Y5_N10
\InstMem|Mux12~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux12~3_combout\ = (\PC_Reg|PC_out\(6)) # ((\PC_Reg|PC_out\(7)) # (\InstMem|Mux12~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux12~2_combout\,
	combout => \InstMem|Mux12~3_combout\);

-- Location: LCCOMB_X22_Y5_N18
\RegFile|mem~1131\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1131_combout\ = (\InstMem|Mux11~3_combout\ & (\RegFile|mem~1129_combout\ & \InstMem|Mux12~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux11~3_combout\,
	datac => \RegFile|mem~1129_combout\,
	datad => \InstMem|Mux12~3_combout\,
	combout => \RegFile|mem~1131_combout\);

-- Location: FF_X23_Y1_N11
\RegFile|mem~102\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux31~3_combout\,
	sload => VCC,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~102_q\);

-- Location: LCCOMB_X22_Y1_N24
\RegFile|mem~262feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~262feeder_combout\ = \CoreALU|Mux31~3_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux31~3_combout\,
	combout => \RegFile|mem~262feeder_combout\);

-- Location: LCCOMB_X22_Y1_N0
\Control|Mux5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux5~0_combout\ = (!\InstMem|Mux15~1_combout\ & (!\InstMem|Mux13~1_combout\ & (!\InstMem|Mux17~3_combout\ & \InstMem|Mux10~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux15~1_combout\,
	datab => \InstMem|Mux13~1_combout\,
	datac => \InstMem|Mux17~3_combout\,
	datad => \InstMem|Mux10~0_combout\,
	combout => \Control|Mux5~0_combout\);

-- Location: LCCOMB_X22_Y5_N6
\RegFile|mem~1133\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1133_combout\ = (\InstMem|Mux11~3_combout\ & (\Control|Mux5~0_combout\ & !\InstMem|Mux12~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux11~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \InstMem|Mux12~3_combout\,
	combout => \RegFile|mem~1133_combout\);

-- Location: FF_X22_Y1_N25
\RegFile|mem~262\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~262feeder_combout\,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~262_q\);

-- Location: LCCOMB_X22_Y5_N28
\RegFile|mem~1132\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1132_combout\ = (!\InstMem|Mux11~3_combout\ & (\Control|Mux5~0_combout\ & !\InstMem|Mux12~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux11~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \InstMem|Mux12~3_combout\,
	combout => \RegFile|mem~1132_combout\);

-- Location: FF_X23_Y1_N21
\RegFile|mem~198\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux31~3_combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~198_q\);

-- Location: LCCOMB_X23_Y1_N20
\SrcB[0]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[0]~4_combout\ = (\InstMem|Mux3~1_combout\ & (\RegFile|mem~262_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~198_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~262_q\,
	datac => \RegFile|mem~198_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \SrcB[0]~4_combout\);

-- Location: LCCOMB_X23_Y1_N10
\SrcB[0]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[0]~5_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux4~0_combout\ & ((\SrcB[0]~4_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~102_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~102_q\,
	datad => \SrcB[0]~4_combout\,
	combout => \SrcB[0]~5_combout\);

-- Location: LCCOMB_X23_Y1_N18
\SrcB[0]~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[0]~6_combout\ = (\ExtUnit|Mux31~0_combout\ & (((\InstMem|Mux4~0_combout\)))) # (!\ExtUnit|Mux31~0_combout\ & (\SrcB[0]~5_combout\ & ((\InstMem|Mux3~1_combout\) # (\InstMem|Mux4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux31~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \SrcB[0]~5_combout\,
	combout => \SrcB[0]~6_combout\);

-- Location: LCCOMB_X22_Y1_N14
\Control|Mux5~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Control|Mux5~1_combout\ = (\InstMem|Mux14~3_combout\ & (!\InstMem|Mux8~0_combout\ & \Control|Mux5~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \Control|Mux5~0_combout\,
	combout => \Control|Mux5~1_combout\);

-- Location: LCCOMB_X22_Y5_N24
\RegFile|mem~1130\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1130_combout\ = (!\InstMem|Mux11~3_combout\ & (\RegFile|mem~1129_combout\ & !\InstMem|Mux12~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux11~3_combout\,
	datac => \RegFile|mem~1129_combout\,
	datad => \InstMem|Mux12~3_combout\,
	combout => \RegFile|mem~1130_combout\);

-- Location: FF_X23_Y2_N17
\RegFile|mem~70\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux31~3_combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~70_q\);

-- Location: LCCOMB_X23_Y2_N16
\RegFile|rd1[0]~64\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[0]~64_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~70_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~70_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[0]~64_combout\);

-- Location: LCCOMB_X22_Y1_N10
\CoreALU|Mux31~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux31~1_combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[0]~6_combout\ & ((\Control|Mux5~1_combout\) # (\RegFile|rd1[0]~64_combout\))) # (!\SrcB[0]~6_combout\ & (\Control|Mux5~1_combout\ & \RegFile|rd1[0]~64_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \SrcB[0]~6_combout\,
	datac => \Control|Mux5~1_combout\,
	datad => \RegFile|rd1[0]~64_combout\,
	combout => \CoreALU|Mux31~1_combout\);

-- Location: LCCOMB_X22_Y4_N0
\CoreALU|Add0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~0_combout\ = (\RegFile|rd1[0]~64_combout\ & (\SrcB[0]~6_combout\ $ (VCC))) # (!\RegFile|rd1[0]~64_combout\ & (\SrcB[0]~6_combout\ & VCC))
-- \CoreALU|Add0~1\ = CARRY((\RegFile|rd1[0]~64_combout\ & \SrcB[0]~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[0]~64_combout\,
	datab => \SrcB[0]~6_combout\,
	datad => VCC,
	combout => \CoreALU|Add0~0_combout\,
	cout => \CoreALU|Add0~1\);

-- Location: LCCOMB_X24_Y4_N0
\CoreALU|Add1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~0_combout\ = (\RegFile|rd1[0]~64_combout\ & ((GND) # (!\SrcB[0]~6_combout\))) # (!\RegFile|rd1[0]~64_combout\ & (\SrcB[0]~6_combout\ $ (GND)))
-- \CoreALU|Add1~1\ = CARRY((\RegFile|rd1[0]~64_combout\) # (!\SrcB[0]~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[0]~64_combout\,
	datab => \SrcB[0]~6_combout\,
	datad => VCC,
	combout => \CoreALU|Add1~0_combout\,
	cout => \CoreALU|Add1~1\);

-- Location: LCCOMB_X22_Y1_N20
\CoreALU|Mux31~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux31~2_combout\ = (\Control|Mux3~2_combout\ & ((\CoreALU|Add1~0_combout\))) # (!\Control|Mux3~2_combout\ & (\CoreALU|Add0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux3~2_combout\,
	datac => \CoreALU|Add0~0_combout\,
	datad => \CoreALU|Add1~0_combout\,
	combout => \CoreALU|Mux31~2_combout\);

-- Location: LCCOMB_X22_Y1_N4
\CoreALU|Mux31~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux31~3_combout\ = (\CoreALU|Mux31~1_combout\) # ((!\Control|Mux4~2_combout\ & (!\Control|Mux5~1_combout\ & \CoreALU|Mux31~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux4~2_combout\,
	datab => \CoreALU|Mux31~1_combout\,
	datac => \Control|Mux5~1_combout\,
	datad => \CoreALU|Mux31~2_combout\,
	combout => \CoreALU|Mux31~3_combout\);

-- Location: FF_X24_Y1_N31
\RegFile|mem~132\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux1~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~132_q\);

-- Location: LCCOMB_X22_Y5_N4
\RegFile|mem~1134\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1134_combout\ = (!\InstMem|Mux11~3_combout\ & (\RegFile|mem~1129_combout\ & \InstMem|Mux12~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux11~3_combout\,
	datac => \RegFile|mem~1129_combout\,
	datad => \InstMem|Mux12~3_combout\,
	combout => \RegFile|mem~1134_combout\);

-- Location: FF_X21_Y1_N13
\RegFile|mem~68\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux1~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~68_q\);

-- Location: LCCOMB_X21_Y1_N12
\RegFile|mem~1126\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1126_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~132_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~68_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~132_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~68_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1126_combout\);

-- Location: LCCOMB_X23_Y1_N16
\RegFile|mem~228feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~228feeder_combout\ = \CoreALU|Mux1~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux1~combout\,
	combout => \RegFile|mem~228feeder_combout\);

-- Location: FF_X23_Y1_N17
\RegFile|mem~228\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~228feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~228_q\);

-- Location: FF_X21_Y1_N3
\RegFile|mem~292\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux1~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~292_q\);

-- Location: LCCOMB_X21_Y1_N2
\RegFile|mem~1125\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1125_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~292_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~228_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~228_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~292_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1125_combout\);

-- Location: LCCOMB_X24_Y2_N22
\SrcB[30]~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[30]~7_combout\ = (!\ExtUnit|Mux31~0_combout\ & ((\InstMem|Mux3~1_combout\) # ((\InstMem|Mux4~0_combout\) # (\InstMem|Mux1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \InstMem|Mux1~0_combout\,
	datad => \ExtUnit|Mux31~0_combout\,
	combout => \SrcB[30]~7_combout\);

-- Location: LCCOMB_X21_Y1_N14
\SrcB[30]~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[30]~46_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1125_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1126_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1126_combout\,
	datab => \RegFile|mem~1125_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[30]~46_combout\);

-- Location: FF_X26_Y1_N15
\RegFile|mem~100\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux1~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~100_q\);

-- Location: LCCOMB_X26_Y5_N24
\RegFile|rd1[30]~94\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[30]~94_combout\ = (!\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out\(6) & (\RegFile|mem~100_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \PC_Reg|PC_out\(6),
	datac => \RegFile|mem~100_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[30]~94_combout\);

-- Location: LCCOMB_X22_Y1_N22
\CoreALU|Mux20~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux20~3_combout\ = (\Control|Mux3~2_combout\) # ((\Control|Mux4~2_combout\ & \Control|Mux5~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Control|Mux4~2_combout\,
	datac => \Control|Mux5~1_combout\,
	datad => \Control|Mux3~2_combout\,
	combout => \CoreALU|Mux20~3_combout\);

-- Location: LCCOMB_X22_Y1_N16
\CoreALU|Mux20~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux20~2_combout\ = (!\Control|Mux4~2_combout\ & ((!\Control|Mux5~1_combout\) # (!\Control|Mux3~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux3~2_combout\,
	datab => \Control|Mux4~2_combout\,
	datac => \Control|Mux5~1_combout\,
	combout => \CoreALU|Mux20~2_combout\);

-- Location: LCCOMB_X23_Y1_N14
\RegFile|mem~227feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~227feeder_combout\ = \CoreALU|Mux2~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux2~combout\,
	combout => \RegFile|mem~227feeder_combout\);

-- Location: FF_X23_Y1_N15
\RegFile|mem~227\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~227feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~227_q\);

-- Location: FF_X21_Y1_N17
\RegFile|mem~291\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux2~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~291_q\);

-- Location: LCCOMB_X21_Y1_N16
\RegFile|mem~1123\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1123_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~291_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~227_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~227_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~291_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1123_combout\);

-- Location: FF_X24_Y1_N27
\RegFile|mem~131\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux2~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~131_q\);

-- Location: FF_X21_Y1_N31
\RegFile|mem~67\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux2~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~67_q\);

-- Location: LCCOMB_X21_Y1_N30
\RegFile|mem~1124\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1124_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~131_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~67_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~131_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~67_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1124_combout\);

-- Location: LCCOMB_X21_Y1_N0
\SrcB[29]~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[29]~45_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1123_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1124_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1123_combout\,
	datac => \RegFile|mem~1124_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[29]~45_combout\);

-- Location: FF_X24_Y5_N11
\RegFile|mem~98\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux3~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~98_q\);

-- Location: LCCOMB_X24_Y5_N10
\RegFile|rd1[28]~92\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[28]~92_combout\ = (\InstMem|Mux14~2_combout\ & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~98_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~2_combout\,
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~98_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[28]~92_combout\);

-- Location: FF_X27_Y3_N19
\RegFile|mem~97\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux4~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~97_q\);

-- Location: LCCOMB_X27_Y3_N18
\RegFile|rd1[27]~91\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[27]~91_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~97_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~97_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[27]~91_combout\);

-- Location: FF_X26_Y3_N7
\RegFile|mem~128\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux5~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~128_q\);

-- Location: FF_X25_Y5_N17
\RegFile|mem~64\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux5~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~64_q\);

-- Location: LCCOMB_X25_Y5_N16
\RegFile|mem~1118\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1118_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~128_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~64_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~128_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~64_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1118_combout\);

-- Location: LCCOMB_X26_Y5_N20
\RegFile|mem~224feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~224feeder_combout\ = \CoreALU|Mux5~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux5~combout\,
	combout => \RegFile|mem~224feeder_combout\);

-- Location: FF_X26_Y5_N21
\RegFile|mem~224\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~224feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~224_q\);

-- Location: FF_X25_Y5_N23
\RegFile|mem~288\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux5~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~288_q\);

-- Location: LCCOMB_X25_Y5_N22
\RegFile|mem~1117\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1117_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~288_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~224_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~224_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~288_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1117_combout\);

-- Location: LCCOMB_X25_Y5_N26
\SrcB[26]~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[26]~42_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1117_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1118_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1118_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1117_combout\,
	combout => \SrcB[26]~42_combout\);

-- Location: LCCOMB_X26_Y5_N14
\RegFile|mem~223feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~223feeder_combout\ = \CoreALU|Mux6~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux6~combout\,
	combout => \RegFile|mem~223feeder_combout\);

-- Location: FF_X26_Y5_N15
\RegFile|mem~223\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~223feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~223_q\);

-- Location: FF_X25_Y5_N5
\RegFile|mem~287\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux6~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~287_q\);

-- Location: LCCOMB_X25_Y5_N4
\RegFile|mem~1115\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1115_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~287_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~223_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~223_q\,
	datac => \RegFile|mem~287_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1115_combout\);

-- Location: FF_X26_Y3_N15
\RegFile|mem~127\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux6~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~127_q\);

-- Location: FF_X25_Y5_N7
\RegFile|mem~63\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux6~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~63_q\);

-- Location: LCCOMB_X25_Y5_N6
\RegFile|mem~1116\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1116_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~127_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~63_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~127_q\,
	datac => \RegFile|mem~63_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1116_combout\);

-- Location: LCCOMB_X25_Y5_N8
\SrcB[25]~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[25]~41_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1115_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1116_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1115_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1116_combout\,
	combout => \SrcB[25]~41_combout\);

-- Location: FF_X27_Y3_N1
\RegFile|mem~94\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux7~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~94_q\);

-- Location: LCCOMB_X27_Y3_N0
\RegFile|rd1[24]~88\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[24]~88_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~94_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~94_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[24]~88_combout\);

-- Location: FF_X27_Y3_N27
\RegFile|mem~93\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux8~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~93_q\);

-- Location: LCCOMB_X27_Y3_N26
\RegFile|rd1[23]~87\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[23]~87_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~93_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~93_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[23]~87_combout\);

-- Location: FF_X24_Y3_N3
\RegFile|mem~220\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux9~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~220_q\);

-- Location: FF_X24_Y3_N7
\RegFile|mem~284\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux9~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~284_q\);

-- Location: LCCOMB_X23_Y5_N18
\RegFile|mem~1109\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1109_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~284_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~220_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~220_q\,
	datad => \RegFile|mem~284_q\,
	combout => \RegFile|mem~1109_combout\);

-- Location: FF_X23_Y3_N7
\RegFile|mem~124\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux9~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~124_q\);

-- Location: FF_X23_Y3_N25
\RegFile|mem~60\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux9~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~60_q\);

-- Location: LCCOMB_X23_Y3_N24
\RegFile|mem~1110\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1110_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~124_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~60_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~124_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~60_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1110_combout\);

-- Location: LCCOMB_X23_Y3_N28
\SrcB[22]~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[22]~38_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1109_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1110_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1109_combout\,
	datab => \RegFile|mem~1110_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \InstMem|Mux4~0_combout\,
	combout => \SrcB[22]~38_combout\);

-- Location: FF_X27_Y3_N7
\RegFile|mem~91\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux10~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~91_q\);

-- Location: LCCOMB_X27_Y3_N6
\RegFile|rd1[21]~85\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[21]~85_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~91_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~91_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[21]~85_combout\);

-- Location: FF_X27_Y3_N29
\RegFile|mem~90\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux11~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~90_q\);

-- Location: LCCOMB_X27_Y3_N28
\RegFile|rd1[20]~84\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[20]~84_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~90_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~90_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[20]~84_combout\);

-- Location: FF_X20_Y3_N31
\RegFile|mem~89\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux12~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~89_q\);

-- Location: LCCOMB_X20_Y3_N30
\RegFile|rd1[19]~83\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[19]~83_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~89_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~89_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[19]~83_combout\);

-- Location: FF_X20_Y3_N21
\RegFile|mem~88\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux13~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~88_q\);

-- Location: LCCOMB_X20_Y3_N20
\RegFile|rd1[18]~82\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[18]~82_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~88_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~88_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[18]~82_combout\);

-- Location: FF_X25_Y3_N15
\RegFile|mem~119\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux14~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~119_q\);

-- Location: FF_X25_Y3_N25
\RegFile|mem~55\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux14~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~55_q\);

-- Location: LCCOMB_X25_Y3_N24
\RegFile|mem~1100\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1100_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~119_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~55_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~119_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~55_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1100_combout\);

-- Location: LCCOMB_X21_Y2_N0
\RegFile|mem~215feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~215feeder_combout\ = \CoreALU|Mux14~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux14~combout\,
	combout => \RegFile|mem~215feeder_combout\);

-- Location: FF_X21_Y2_N1
\RegFile|mem~215\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~215feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~215_q\);

-- Location: FF_X21_Y2_N31
\RegFile|mem~279\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux14~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~279_q\);

-- Location: LCCOMB_X21_Y2_N30
\RegFile|mem~1099\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1099_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~279_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~215_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~215_q\,
	datac => \RegFile|mem~279_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1099_combout\);

-- Location: LCCOMB_X25_Y3_N28
\SrcB[17]~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[17]~33_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1099_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1100_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1100_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1099_combout\,
	combout => \SrcB[17]~33_combout\);

-- Location: FF_X25_Y3_N5
\RegFile|mem~54\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux15~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~54_q\);

-- Location: FF_X25_Y3_N7
\RegFile|mem~118\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux15~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~118_q\);

-- Location: LCCOMB_X25_Y3_N4
\RegFile|mem~1098\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1098_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~118_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~54_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~54_q\,
	datad => \RegFile|mem~118_q\,
	combout => \RegFile|mem~1098_combout\);

-- Location: FF_X21_Y2_N7
\RegFile|mem~278\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux15~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~278_q\);

-- Location: LCCOMB_X21_Y2_N12
\RegFile|mem~214feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~214feeder_combout\ = \CoreALU|Mux15~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux15~combout\,
	combout => \RegFile|mem~214feeder_combout\);

-- Location: FF_X21_Y2_N13
\RegFile|mem~214\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~214feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~214_q\);

-- Location: LCCOMB_X21_Y2_N6
\RegFile|mem~1097\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1097_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~278_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~214_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~278_q\,
	datad => \RegFile|mem~214_q\,
	combout => \RegFile|mem~1097_combout\);

-- Location: LCCOMB_X25_Y3_N8
\SrcB[16]~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[16]~32_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1097_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1098_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1098_combout\,
	datad => \RegFile|mem~1097_combout\,
	combout => \SrcB[16]~32_combout\);

-- Location: FF_X22_Y2_N1
\RegFile|mem~85\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux16~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~85_q\);

-- Location: LCCOMB_X22_Y2_N0
\RegFile|rd1[15]~79\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[15]~79_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~85_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~85_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[15]~79_combout\);

-- Location: FF_X23_Y2_N9
\RegFile|mem~84\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux17~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~84_q\);

-- Location: LCCOMB_X23_Y2_N8
\RegFile|rd1[14]~78\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[14]~78_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~84_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~84_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[14]~78_combout\);

-- Location: FF_X20_Y4_N25
\RegFile|mem~83\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux18~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~83_q\);

-- Location: LCCOMB_X20_Y4_N24
\RegFile|rd1[13]~77\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[13]~77_combout\ = (!\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out\(6) & (\RegFile|mem~83_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \PC_Reg|PC_out\(6),
	datac => \RegFile|mem~83_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[13]~77_combout\);

-- Location: LCCOMB_X24_Y5_N6
\RegFile|mem~114feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~114feeder_combout\ = \CoreALU|Mux19~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux19~combout\,
	combout => \RegFile|mem~114feeder_combout\);

-- Location: FF_X24_Y5_N7
\RegFile|mem~114\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~114feeder_combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~114_q\);

-- Location: FF_X23_Y5_N17
\RegFile|mem~50\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux19~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~50_q\);

-- Location: LCCOMB_X23_Y5_N16
\RegFile|mem~1088\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1088_combout\ = (\InstMem|Mux3~1_combout\ & (\RegFile|mem~114_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~50_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~114_q\,
	datac => \RegFile|mem~50_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1088_combout\);

-- Location: LCCOMB_X23_Y5_N14
\RegFile|mem~1089\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1089_combout\ = (\InstMem|Mux4~0_combout\ & (((\InstMem|Mux3~1_combout\)))) # (!\InstMem|Mux4~0_combout\ & (!\InstMem|Mux1~0_combout\ & ((\RegFile|mem~1088_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \RegFile|mem~1088_combout\,
	combout => \RegFile|mem~1089_combout\);

-- Location: LCCOMB_X26_Y5_N18
\RegFile|mem~210feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~210feeder_combout\ = \CoreALU|Mux19~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux19~combout\,
	combout => \RegFile|mem~210feeder_combout\);

-- Location: FF_X26_Y5_N19
\RegFile|mem~210\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~210feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~210_q\);

-- Location: FF_X23_Y5_N13
\RegFile|mem~274\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux19~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~274_q\);

-- Location: LCCOMB_X23_Y5_N12
\RegFile|mem~1090\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1090_combout\ = (\RegFile|mem~1089_combout\ & ((\RegFile|mem~274_q\))) # (!\RegFile|mem~1089_combout\ & (\RegFile|mem~210_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~210_q\,
	datab => \RegFile|mem~1089_combout\,
	datac => \RegFile|mem~274_q\,
	combout => \RegFile|mem~1090_combout\);

-- Location: LCCOMB_X23_Y5_N30
\RegFile|mem~1091\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1091_combout\ = (\InstMem|Mux4~0_combout\ & (!\InstMem|Mux1~0_combout\ & ((\RegFile|mem~1090_combout\)))) # (!\InstMem|Mux4~0_combout\ & (((\RegFile|mem~1089_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1089_combout\,
	datad => \RegFile|mem~1090_combout\,
	combout => \RegFile|mem~1091_combout\);

-- Location: LCCOMB_X23_Y5_N24
\SrcB[12]~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[12]~26_combout\ = (\RegFile|mem~1091_combout\ & \SrcB[30]~7_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \RegFile|mem~1091_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[12]~26_combout\);

-- Location: LCCOMB_X18_Y4_N8
\RegFile|mem~81feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~81feeder_combout\ = \CoreALU|Mux20~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux20~combout\,
	combout => \RegFile|mem~81feeder_combout\);

-- Location: FF_X18_Y4_N9
\RegFile|mem~81\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~81feeder_combout\,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~81_q\);

-- Location: LCCOMB_X21_Y4_N14
\RegFile|rd1[11]~75\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[11]~75_combout\ = (\RegFile|mem~81_q\ & (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~81_q\,
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[11]~75_combout\);

-- Location: LCCOMB_X26_Y4_N0
\InstMem|Mux15~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux15~2_combout\ = (\PC_Reg|PC_out\(6)) # ((\PC_Reg|PC_out\(5)) # ((\PC_Reg|PC_out\(4) & \PC_Reg|PC_out\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(5),
	combout => \InstMem|Mux15~2_combout\);

-- Location: LCCOMB_X26_Y4_N18
\SrcB[10]~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~48_combout\ = (!\PC_Reg|PC_out\(5) & (!\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out\(6) & !\InstMem|Mux15~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datab => \PC_Reg|PC_out\(7),
	datac => \PC_Reg|PC_out\(6),
	datad => \InstMem|Mux15~2_combout\,
	combout => \SrcB[10]~48_combout\);

-- Location: LCCOMB_X26_Y4_N6
\SrcB[10]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~9_combout\ = (!\PC_Reg|PC_out\(4) & (\SrcB[10]~48_combout\ & (!\InstMem|Mux17~2_combout\ & !\InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \SrcB[10]~48_combout\,
	datac => \InstMem|Mux17~2_combout\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \SrcB[10]~9_combout\);

-- Location: FF_X23_Y2_N31
\RegFile|mem~80\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux21~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~80_q\);

-- Location: LCCOMB_X23_Y2_N30
\RegFile|rd1[10]~74\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[10]~74_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~80_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~80_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[10]~74_combout\);

-- Location: FF_X22_Y2_N3
\RegFile|mem~79\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux22~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~79_q\);

-- Location: LCCOMB_X22_Y2_N2
\RegFile|rd1[9]~73\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[9]~73_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~79_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~79_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[9]~73_combout\);

-- Location: FF_X23_Y2_N29
\RegFile|mem~78\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux23~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~78_q\);

-- Location: LCCOMB_X23_Y2_N28
\RegFile|rd1[8]~72\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[8]~72_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~78_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~78_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[8]~72_combout\);

-- Location: FF_X22_Y2_N29
\RegFile|mem~77\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux24~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~77_q\);

-- Location: LCCOMB_X22_Y2_N28
\RegFile|rd1[7]~71\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[7]~71_combout\ = (\InstMem|Mux14~2_combout\ & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~77_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~2_combout\,
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~77_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[7]~71_combout\);

-- Location: FF_X23_Y4_N27
\RegFile|mem~108\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux25~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~108_q\);

-- Location: FF_X23_Y4_N29
\RegFile|mem~44\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux25~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~44_q\);

-- Location: LCCOMB_X23_Y4_N28
\RegFile|mem~1080\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1080_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~108_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~44_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~108_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~44_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1080_combout\);

-- Location: LCCOMB_X21_Y2_N8
\RegFile|mem~204feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~204feeder_combout\ = \CoreALU|Mux25~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux25~combout\,
	combout => \RegFile|mem~204feeder_combout\);

-- Location: FF_X21_Y2_N9
\RegFile|mem~204\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~204feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~204_q\);

-- Location: FF_X21_Y2_N23
\RegFile|mem~268\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux25~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~268_q\);

-- Location: LCCOMB_X21_Y2_N22
\RegFile|mem~1079\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1079_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~268_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~204_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~204_q\,
	datac => \RegFile|mem~268_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1079_combout\);

-- Location: LCCOMB_X23_Y4_N4
\SrcB[6]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[6]~16_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1079_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1080_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1080_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1079_combout\,
	combout => \SrcB[6]~16_combout\);

-- Location: FF_X24_Y1_N13
\RegFile|mem~107\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux26~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~107_q\);

-- Location: FF_X25_Y5_N15
\RegFile|mem~43\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux26~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~43_q\);

-- Location: LCCOMB_X25_Y5_N14
\RegFile|mem~1078\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1078_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~107_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~43_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~107_q\,
	datac => \RegFile|mem~43_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1078_combout\);

-- Location: LCCOMB_X23_Y1_N4
\RegFile|mem~203feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~203feeder_combout\ = \CoreALU|Mux26~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux26~combout\,
	combout => \RegFile|mem~203feeder_combout\);

-- Location: FF_X23_Y1_N5
\RegFile|mem~203\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~203feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~203_q\);

-- Location: FF_X25_Y5_N21
\RegFile|mem~267\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux26~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~267_q\);

-- Location: LCCOMB_X25_Y5_N20
\RegFile|mem~1077\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1077_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~267_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~203_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~203_q\,
	datac => \RegFile|mem~267_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1077_combout\);

-- Location: LCCOMB_X25_Y5_N24
\SrcB[5]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[5]~15_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1077_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1078_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1078_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1077_combout\,
	combout => \SrcB[5]~15_combout\);

-- Location: FF_X23_Y2_N1
\RegFile|mem~74\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux27~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~74_q\);

-- Location: LCCOMB_X23_Y2_N0
\RegFile|rd1[4]~68\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[4]~68_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~74_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~74_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[4]~68_combout\);

-- Location: FF_X22_Y2_N11
\RegFile|mem~73\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux28~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~73_q\);

-- Location: LCCOMB_X22_Y2_N10
\RegFile|rd1[3]~67\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[3]~67_combout\ = (\InstMem|Mux14~2_combout\ & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~73_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~2_combout\,
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~73_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[3]~67_combout\);

-- Location: LCCOMB_X26_Y4_N12
\SrcB[2]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[2]~10_combout\ = (!\PC_Reg|PC_out\(3) & (!\PC_Reg|PC_out\(2) & \SrcB[10]~9_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(3),
	datac => \PC_Reg|PC_out\(2),
	datad => \SrcB[10]~9_combout\,
	combout => \SrcB[2]~10_combout\);

-- Location: FF_X24_Y5_N29
\RegFile|mem~72\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux29~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~72_q\);

-- Location: LCCOMB_X24_Y5_N28
\RegFile|rd1[2]~66\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[2]~66_combout\ = (\InstMem|Mux14~2_combout\ & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~72_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~2_combout\,
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~72_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[2]~66_combout\);

-- Location: LCCOMB_X23_Y5_N2
\ExtUnit|Mux30~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux30~3_combout\ = (!\PC_Reg|PC_out\(5) & (!\PC_Reg|PC_out\(3) & !\PC_Reg|PC_out\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(5),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(4),
	combout => \ExtUnit|Mux30~3_combout\);

-- Location: LCCOMB_X23_Y5_N20
\ExtUnit|Mux30~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux30~12_combout\ = (!\PC_Reg|PC_out\(6) & (\PC_Reg|PC_out\(2) & (!\PC_Reg|PC_out\(7) & \ExtUnit|Mux30~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(2),
	datac => \PC_Reg|PC_out\(7),
	datad => \ExtUnit|Mux30~3_combout\,
	combout => \ExtUnit|Mux30~12_combout\);

-- Location: LCCOMB_X22_Y1_N18
\RegFile|mem~263feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~263feeder_combout\ = \CoreALU|Mux30~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux30~combout\,
	combout => \RegFile|mem~263feeder_combout\);

-- Location: FF_X22_Y1_N19
\RegFile|mem~263\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~263feeder_combout\,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~263_q\);

-- Location: FF_X23_Y1_N13
\RegFile|mem~199\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux30~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~199_q\);

-- Location: LCCOMB_X23_Y1_N12
\RegFile|mem~1066\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1066_combout\ = (\InstMem|Mux3~1_combout\ & (\RegFile|mem~263_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~199_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|mem~263_q\,
	datac => \RegFile|mem~199_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1066_combout\);

-- Location: FF_X25_Y4_N27
\RegFile|mem~39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux30~combout\,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~39_q\);

-- Location: FF_X25_Y4_N1
\RegFile|mem~103\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux30~combout\,
	sload => VCC,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~103_q\);

-- Location: LCCOMB_X25_Y4_N0
\RegFile|mem~1067\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1067_combout\ = (\InstMem|Mux3~1_combout\ & ((\RegFile|mem~103_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~39_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~39_q\,
	datac => \RegFile|mem~103_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1067_combout\);

-- Location: LCCOMB_X23_Y5_N22
\RegFile|mem~1068\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1068_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1066_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1067_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1066_combout\,
	datad => \RegFile|mem~1067_combout\,
	combout => \RegFile|mem~1068_combout\);

-- Location: LCCOMB_X23_Y5_N28
\SrcB[1]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[1]~8_combout\ = (\ExtUnit|Mux31~0_combout\ & (\ExtUnit|Mux30~12_combout\)) # (!\ExtUnit|Mux31~0_combout\ & (((\RegFile|mem~1068_combout\ & \SrcB[30]~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux31~0_combout\,
	datab => \ExtUnit|Mux30~12_combout\,
	datac => \RegFile|mem~1068_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[1]~8_combout\);

-- Location: LCCOMB_X22_Y4_N2
\CoreALU|Add0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~2_combout\ = (\SrcB[1]~8_combout\ & ((\RegFile|rd1[1]~65_combout\ & (\CoreALU|Add0~1\ & VCC)) # (!\RegFile|rd1[1]~65_combout\ & (!\CoreALU|Add0~1\)))) # (!\SrcB[1]~8_combout\ & ((\RegFile|rd1[1]~65_combout\ & (!\CoreALU|Add0~1\)) # 
-- (!\RegFile|rd1[1]~65_combout\ & ((\CoreALU|Add0~1\) # (GND)))))
-- \CoreALU|Add0~3\ = CARRY((\SrcB[1]~8_combout\ & (!\RegFile|rd1[1]~65_combout\ & !\CoreALU|Add0~1\)) # (!\SrcB[1]~8_combout\ & ((!\CoreALU|Add0~1\) # (!\RegFile|rd1[1]~65_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[1]~8_combout\,
	datab => \RegFile|rd1[1]~65_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~1\,
	combout => \CoreALU|Add0~2_combout\,
	cout => \CoreALU|Add0~3\);

-- Location: LCCOMB_X25_Y4_N4
\CoreALU|Mux30~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux30~3_combout\ = (\CoreALU|Add0~2_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~2_combout\,
	combout => \CoreALU|Mux30~3_combout\);

-- Location: LCCOMB_X24_Y4_N2
\CoreALU|Add1~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~2_combout\ = (\RegFile|rd1[1]~65_combout\ & ((\SrcB[1]~8_combout\ & (!\CoreALU|Add1~1\)) # (!\SrcB[1]~8_combout\ & (\CoreALU|Add1~1\ & VCC)))) # (!\RegFile|rd1[1]~65_combout\ & ((\SrcB[1]~8_combout\ & ((\CoreALU|Add1~1\) # (GND))) # 
-- (!\SrcB[1]~8_combout\ & (!\CoreALU|Add1~1\))))
-- \CoreALU|Add1~3\ = CARRY((\RegFile|rd1[1]~65_combout\ & (\SrcB[1]~8_combout\ & !\CoreALU|Add1~1\)) # (!\RegFile|rd1[1]~65_combout\ & ((\SrcB[1]~8_combout\) # (!\CoreALU|Add1~1\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[1]~65_combout\,
	datab => \SrcB[1]~8_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~1\,
	combout => \CoreALU|Add1~2_combout\,
	cout => \CoreALU|Add1~3\);

-- Location: LCCOMB_X25_Y4_N12
\CoreALU|Mux30~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux30~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & ((\CoreALU|Add1~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux30~3_combout\)))) # (!\CoreALU|Mux20~2_combout\ & (((!\CoreALU|Mux20~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110100001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux30~3_combout\,
	datac => \CoreALU|Mux20~3_combout\,
	datad => \CoreALU|Add1~2_combout\,
	combout => \CoreALU|Mux30~2_combout\);

-- Location: LCCOMB_X25_Y4_N26
\CoreALU|Mux30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux30~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[1]~65_combout\ & ((\SrcB[1]~8_combout\) # (!\CoreALU|Mux30~2_combout\))) # (!\RegFile|rd1[1]~65_combout\ & (\SrcB[1]~8_combout\ & !\CoreALU|Mux30~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux30~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[1]~65_combout\,
	datab => \CoreALU|Mux31~0_combout\,
	datac => \SrcB[1]~8_combout\,
	datad => \CoreALU|Mux30~2_combout\,
	combout => \CoreALU|Mux30~combout\);

-- Location: FF_X27_Y4_N17
\RegFile|mem~71\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux30~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~71_q\);

-- Location: LCCOMB_X27_Y4_N16
\RegFile|rd1[1]~65\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[1]~65_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~71_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~71_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[1]~65_combout\);

-- Location: LCCOMB_X24_Y4_N4
\CoreALU|Add1~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~4_combout\ = ((\SrcB[2]~12_combout\ $ (\RegFile|rd1[2]~66_combout\ $ (\CoreALU|Add1~3\)))) # (GND)
-- \CoreALU|Add1~5\ = CARRY((\SrcB[2]~12_combout\ & (\RegFile|rd1[2]~66_combout\ & !\CoreALU|Add1~3\)) # (!\SrcB[2]~12_combout\ & ((\RegFile|rd1[2]~66_combout\) # (!\CoreALU|Add1~3\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[2]~12_combout\,
	datab => \RegFile|rd1[2]~66_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~3\,
	combout => \CoreALU|Add1~4_combout\,
	cout => \CoreALU|Add1~5\);

-- Location: LCCOMB_X22_Y4_N4
\CoreALU|Add0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~4_combout\ = ((\SrcB[2]~12_combout\ $ (\RegFile|rd1[2]~66_combout\ $ (!\CoreALU|Add0~3\)))) # (GND)
-- \CoreALU|Add0~5\ = CARRY((\SrcB[2]~12_combout\ & ((\RegFile|rd1[2]~66_combout\) # (!\CoreALU|Add0~3\))) # (!\SrcB[2]~12_combout\ & (\RegFile|rd1[2]~66_combout\ & !\CoreALU|Add0~3\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[2]~12_combout\,
	datab => \RegFile|rd1[2]~66_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~3\,
	combout => \CoreALU|Add0~4_combout\,
	cout => \CoreALU|Add0~5\);

-- Location: LCCOMB_X23_Y4_N20
\CoreALU|Mux29~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux29~3_combout\ = (\CoreALU|Add0~4_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \Control|Mux5~0_combout\,
	datac => \CoreALU|Add0~4_combout\,
	datad => \InstMem|Mux8~0_combout\,
	combout => \CoreALU|Mux29~3_combout\);

-- Location: LCCOMB_X25_Y4_N2
\CoreALU|Mux29~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux29~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~4_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux29~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (((!\CoreALU|Mux20~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Add1~4_combout\,
	datac => \CoreALU|Mux29~3_combout\,
	datad => \CoreALU|Mux20~3_combout\,
	combout => \CoreALU|Mux29~2_combout\);

-- Location: LCCOMB_X25_Y4_N20
\CoreALU|Mux29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux29~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[2]~66_combout\ & ((\SrcB[2]~12_combout\) # (!\CoreALU|Mux29~2_combout\))) # (!\RegFile|rd1[2]~66_combout\ & (\SrcB[2]~12_combout\ & !\CoreALU|Mux29~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux29~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[2]~66_combout\,
	datab => \CoreALU|Mux31~0_combout\,
	datac => \SrcB[2]~12_combout\,
	datad => \CoreALU|Mux29~2_combout\,
	combout => \CoreALU|Mux29~combout\);

-- Location: LCCOMB_X27_Y2_N28
\RegFile|mem~200feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~200feeder_combout\ = \CoreALU|Mux29~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux29~combout\,
	combout => \RegFile|mem~200feeder_combout\);

-- Location: FF_X27_Y2_N29
\RegFile|mem~200\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~200feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~200_q\);

-- Location: FF_X27_Y2_N3
\RegFile|mem~264\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux29~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~264_q\);

-- Location: LCCOMB_X27_Y2_N2
\RegFile|mem~1069\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1069_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~264_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~200_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~200_q\,
	datac => \RegFile|mem~264_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1069_combout\);

-- Location: FF_X25_Y4_N21
\RegFile|mem~104\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux29~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~104_q\);

-- Location: FF_X25_Y4_N31
\RegFile|mem~40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux29~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~40_q\);

-- Location: LCCOMB_X25_Y4_N30
\RegFile|mem~1070\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1070_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~104_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~40_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~104_q\,
	datac => \RegFile|mem~40_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1070_combout\);

-- Location: LCCOMB_X26_Y4_N26
\SrcB[2]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[2]~11_combout\ = (\InstMem|Mux4~0_combout\ & (\RegFile|mem~1069_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1070_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1069_combout\,
	datad => \RegFile|mem~1070_combout\,
	combout => \SrcB[2]~11_combout\);

-- Location: LCCOMB_X26_Y4_N24
\SrcB[2]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[2]~12_combout\ = (\SrcB[2]~10_combout\) # ((!\ExtUnit|Mux31~0_combout\ & (\SrcB[2]~11_combout\ & \SrcB[30]~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[2]~10_combout\,
	datab => \ExtUnit|Mux31~0_combout\,
	datac => \SrcB[2]~11_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[2]~12_combout\);

-- Location: LCCOMB_X24_Y4_N6
\CoreALU|Add1~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~6_combout\ = (\SrcB[3]~13_combout\ & ((\RegFile|rd1[3]~67_combout\ & (!\CoreALU|Add1~5\)) # (!\RegFile|rd1[3]~67_combout\ & ((\CoreALU|Add1~5\) # (GND))))) # (!\SrcB[3]~13_combout\ & ((\RegFile|rd1[3]~67_combout\ & (\CoreALU|Add1~5\ & VCC)) 
-- # (!\RegFile|rd1[3]~67_combout\ & (!\CoreALU|Add1~5\))))
-- \CoreALU|Add1~7\ = CARRY((\SrcB[3]~13_combout\ & ((!\CoreALU|Add1~5\) # (!\RegFile|rd1[3]~67_combout\))) # (!\SrcB[3]~13_combout\ & (!\RegFile|rd1[3]~67_combout\ & !\CoreALU|Add1~5\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[3]~13_combout\,
	datab => \RegFile|rd1[3]~67_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~5\,
	combout => \CoreALU|Add1~6_combout\,
	cout => \CoreALU|Add1~7\);

-- Location: LCCOMB_X22_Y4_N6
\CoreALU|Add0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~6_combout\ = (\RegFile|rd1[3]~67_combout\ & ((\SrcB[3]~13_combout\ & (\CoreALU|Add0~5\ & VCC)) # (!\SrcB[3]~13_combout\ & (!\CoreALU|Add0~5\)))) # (!\RegFile|rd1[3]~67_combout\ & ((\SrcB[3]~13_combout\ & (!\CoreALU|Add0~5\)) # 
-- (!\SrcB[3]~13_combout\ & ((\CoreALU|Add0~5\) # (GND)))))
-- \CoreALU|Add0~7\ = CARRY((\RegFile|rd1[3]~67_combout\ & (!\SrcB[3]~13_combout\ & !\CoreALU|Add0~5\)) # (!\RegFile|rd1[3]~67_combout\ & ((!\CoreALU|Add0~5\) # (!\SrcB[3]~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[3]~67_combout\,
	datab => \SrcB[3]~13_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~5\,
	combout => \CoreALU|Add0~6_combout\,
	cout => \CoreALU|Add0~7\);

-- Location: LCCOMB_X23_Y1_N2
\CoreALU|Mux28~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux28~3_combout\ = (\CoreALU|Add0~6_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \CoreALU|Add0~6_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \CoreALU|Mux28~3_combout\);

-- Location: LCCOMB_X23_Y1_N28
\CoreALU|Mux28~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux28~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~6_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux28~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Add1~6_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux28~3_combout\,
	combout => \CoreALU|Mux28~2_combout\);

-- Location: LCCOMB_X23_Y1_N6
\CoreALU|Mux28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux28~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[3]~13_combout\ & ((\RegFile|rd1[3]~67_combout\) # (!\CoreALU|Mux28~2_combout\))) # (!\SrcB[3]~13_combout\ & (\RegFile|rd1[3]~67_combout\ & !\CoreALU|Mux28~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux28~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \SrcB[3]~13_combout\,
	datac => \RegFile|rd1[3]~67_combout\,
	datad => \CoreALU|Mux28~2_combout\,
	combout => \CoreALU|Mux28~combout\);

-- Location: LCCOMB_X25_Y4_N28
\RegFile|mem~105feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~105feeder_combout\ = \CoreALU|Mux28~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux28~combout\,
	combout => \RegFile|mem~105feeder_combout\);

-- Location: FF_X25_Y4_N29
\RegFile|mem~105\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~105feeder_combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~105_q\);

-- Location: FF_X25_Y4_N23
\RegFile|mem~41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux28~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~41_q\);

-- Location: LCCOMB_X25_Y4_N22
\RegFile|mem~1071\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1071_combout\ = (\InstMem|Mux3~1_combout\ & (\RegFile|mem~105_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~41_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|mem~105_q\,
	datac => \RegFile|mem~41_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1071_combout\);

-- Location: LCCOMB_X24_Y2_N20
\RegFile|mem~1072\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1072_combout\ = (\InstMem|Mux4~0_combout\ & (\InstMem|Mux3~1_combout\)) # (!\InstMem|Mux4~0_combout\ & (((!\InstMem|Mux1~0_combout\ & \RegFile|mem~1071_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \InstMem|Mux1~0_combout\,
	datad => \RegFile|mem~1071_combout\,
	combout => \RegFile|mem~1072_combout\);

-- Location: LCCOMB_X23_Y1_N26
\RegFile|mem~201feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~201feeder_combout\ = \CoreALU|Mux28~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux28~combout\,
	combout => \RegFile|mem~201feeder_combout\);

-- Location: FF_X23_Y1_N27
\RegFile|mem~201\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~201feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~201_q\);

-- Location: FF_X24_Y2_N19
\RegFile|mem~265\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux28~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~265_q\);

-- Location: LCCOMB_X24_Y2_N18
\RegFile|mem~1073\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1073_combout\ = (\RegFile|mem~1072_combout\ & ((\RegFile|mem~265_q\))) # (!\RegFile|mem~1072_combout\ & (\RegFile|mem~201_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|mem~201_q\,
	datac => \RegFile|mem~265_q\,
	datad => \RegFile|mem~1072_combout\,
	combout => \RegFile|mem~1073_combout\);

-- Location: LCCOMB_X24_Y2_N12
\RegFile|mem~1074\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1074_combout\ = (\InstMem|Mux4~0_combout\ & (!\InstMem|Mux1~0_combout\ & ((\RegFile|mem~1073_combout\)))) # (!\InstMem|Mux4~0_combout\ & (((\RegFile|mem~1072_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~1072_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \RegFile|mem~1073_combout\,
	combout => \RegFile|mem~1074_combout\);

-- Location: LCCOMB_X24_Y2_N14
\SrcB[3]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[3]~13_combout\ = (\ExtUnit|Mux28~3_combout\ & ((\ExtUnit|Mux31~0_combout\) # ((\SrcB[30]~7_combout\ & \RegFile|mem~1074_combout\)))) # (!\ExtUnit|Mux28~3_combout\ & (((\SrcB[30]~7_combout\ & \RegFile|mem~1074_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux28~3_combout\,
	datab => \ExtUnit|Mux31~0_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1074_combout\,
	combout => \SrcB[3]~13_combout\);

-- Location: LCCOMB_X24_Y4_N8
\CoreALU|Add1~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~8_combout\ = ((\SrcB[4]~14_combout\ $ (\RegFile|rd1[4]~68_combout\ $ (\CoreALU|Add1~7\)))) # (GND)
-- \CoreALU|Add1~9\ = CARRY((\SrcB[4]~14_combout\ & (\RegFile|rd1[4]~68_combout\ & !\CoreALU|Add1~7\)) # (!\SrcB[4]~14_combout\ & ((\RegFile|rd1[4]~68_combout\) # (!\CoreALU|Add1~7\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[4]~14_combout\,
	datab => \RegFile|rd1[4]~68_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~7\,
	combout => \CoreALU|Add1~8_combout\,
	cout => \CoreALU|Add1~9\);

-- Location: LCCOMB_X22_Y4_N8
\CoreALU|Add0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~8_combout\ = ((\RegFile|rd1[4]~68_combout\ $ (\SrcB[4]~14_combout\ $ (!\CoreALU|Add0~7\)))) # (GND)
-- \CoreALU|Add0~9\ = CARRY((\RegFile|rd1[4]~68_combout\ & ((\SrcB[4]~14_combout\) # (!\CoreALU|Add0~7\))) # (!\RegFile|rd1[4]~68_combout\ & (\SrcB[4]~14_combout\ & !\CoreALU|Add0~7\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[4]~68_combout\,
	datab => \SrcB[4]~14_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~7\,
	combout => \CoreALU|Add0~8_combout\,
	cout => \CoreALU|Add0~9\);

-- Location: LCCOMB_X23_Y4_N6
\CoreALU|Mux27~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux27~3_combout\ = (\CoreALU|Add0~8_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~8_combout\,
	combout => \CoreALU|Mux27~3_combout\);

-- Location: LCCOMB_X23_Y4_N30
\CoreALU|Mux27~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux27~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~8_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux27~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (((!\CoreALU|Mux20~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Add1~8_combout\,
	datac => \CoreALU|Mux20~3_combout\,
	datad => \CoreALU|Mux27~3_combout\,
	combout => \CoreALU|Mux27~2_combout\);

-- Location: LCCOMB_X23_Y4_N0
\CoreALU|Mux27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux27~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[4]~68_combout\ & ((\SrcB[4]~14_combout\) # (!\CoreALU|Mux27~2_combout\))) # (!\RegFile|rd1[4]~68_combout\ & (!\CoreALU|Mux27~2_combout\ & \SrcB[4]~14_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux27~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[4]~68_combout\,
	datac => \CoreALU|Mux27~2_combout\,
	datad => \SrcB[4]~14_combout\,
	combout => \CoreALU|Mux27~combout\);

-- Location: FF_X24_Y3_N5
\RegFile|mem~202\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux27~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~202_q\);

-- Location: FF_X23_Y5_N27
\RegFile|mem~266\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux27~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~266_q\);

-- Location: LCCOMB_X23_Y5_N26
\RegFile|mem~1075\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1075_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~266_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~202_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~202_q\,
	datac => \RegFile|mem~266_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1075_combout\);

-- Location: FF_X23_Y4_N1
\RegFile|mem~106\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux27~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~106_q\);

-- Location: FF_X23_Y5_N5
\RegFile|mem~42\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux27~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~42_q\);

-- Location: LCCOMB_X23_Y5_N4
\RegFile|mem~1076\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1076_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~106_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~42_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~106_q\,
	datac => \RegFile|mem~42_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1076_combout\);

-- Location: LCCOMB_X23_Y5_N10
\SrcB[4]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[4]~14_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1075_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1076_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1075_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1076_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[4]~14_combout\);

-- Location: LCCOMB_X24_Y4_N10
\CoreALU|Add1~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~10_combout\ = (\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\ & (!\CoreALU|Add1~9\)) # (!\SrcB[5]~15_combout\ & (\CoreALU|Add1~9\ & VCC)))) # (!\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\ & ((\CoreALU|Add1~9\) # (GND))) # 
-- (!\SrcB[5]~15_combout\ & (!\CoreALU|Add1~9\))))
-- \CoreALU|Add1~11\ = CARRY((\RegFile|rd1[5]~69_combout\ & (\SrcB[5]~15_combout\ & !\CoreALU|Add1~9\)) # (!\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\) # (!\CoreALU|Add1~9\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[5]~69_combout\,
	datab => \SrcB[5]~15_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~9\,
	combout => \CoreALU|Add1~10_combout\,
	cout => \CoreALU|Add1~11\);

-- Location: LCCOMB_X22_Y4_N10
\CoreALU|Add0~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~10_combout\ = (\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\ & (\CoreALU|Add0~9\ & VCC)) # (!\SrcB[5]~15_combout\ & (!\CoreALU|Add0~9\)))) # (!\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\ & (!\CoreALU|Add0~9\)) # 
-- (!\SrcB[5]~15_combout\ & ((\CoreALU|Add0~9\) # (GND)))))
-- \CoreALU|Add0~11\ = CARRY((\RegFile|rd1[5]~69_combout\ & (!\SrcB[5]~15_combout\ & !\CoreALU|Add0~9\)) # (!\RegFile|rd1[5]~69_combout\ & ((!\CoreALU|Add0~9\) # (!\SrcB[5]~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[5]~69_combout\,
	datab => \SrcB[5]~15_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~9\,
	combout => \CoreALU|Add0~10_combout\,
	cout => \CoreALU|Add0~11\);

-- Location: LCCOMB_X23_Y1_N8
\CoreALU|Mux26~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux26~3_combout\ = (\CoreALU|Add0~10_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~10_combout\,
	combout => \CoreALU|Mux26~3_combout\);

-- Location: LCCOMB_X24_Y1_N14
\CoreALU|Mux26~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux26~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~10_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux26~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~10_combout\,
	datad => \CoreALU|Mux26~3_combout\,
	combout => \CoreALU|Mux26~2_combout\);

-- Location: LCCOMB_X24_Y1_N12
\CoreALU|Mux26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux26~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[5]~69_combout\ & ((\SrcB[5]~15_combout\) # (!\CoreALU|Mux26~2_combout\))) # (!\RegFile|rd1[5]~69_combout\ & (!\CoreALU|Mux26~2_combout\ & \SrcB[5]~15_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux26~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[5]~69_combout\,
	datac => \CoreALU|Mux26~2_combout\,
	datad => \SrcB[5]~15_combout\,
	combout => \CoreALU|Mux26~combout\);

-- Location: FF_X23_Y2_N27
\RegFile|mem~75\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux26~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~75_q\);

-- Location: LCCOMB_X23_Y2_N26
\RegFile|rd1[5]~69\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[5]~69_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~75_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~75_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[5]~69_combout\);

-- Location: LCCOMB_X24_Y4_N12
\CoreALU|Add1~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~12_combout\ = ((\RegFile|rd1[6]~70_combout\ $ (\SrcB[6]~16_combout\ $ (\CoreALU|Add1~11\)))) # (GND)
-- \CoreALU|Add1~13\ = CARRY((\RegFile|rd1[6]~70_combout\ & ((!\CoreALU|Add1~11\) # (!\SrcB[6]~16_combout\))) # (!\RegFile|rd1[6]~70_combout\ & (!\SrcB[6]~16_combout\ & !\CoreALU|Add1~11\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[6]~70_combout\,
	datab => \SrcB[6]~16_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~11\,
	combout => \CoreALU|Add1~12_combout\,
	cout => \CoreALU|Add1~13\);

-- Location: LCCOMB_X22_Y4_N12
\CoreALU|Add0~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~12_combout\ = ((\SrcB[6]~16_combout\ $ (\RegFile|rd1[6]~70_combout\ $ (!\CoreALU|Add0~11\)))) # (GND)
-- \CoreALU|Add0~13\ = CARRY((\SrcB[6]~16_combout\ & ((\RegFile|rd1[6]~70_combout\) # (!\CoreALU|Add0~11\))) # (!\SrcB[6]~16_combout\ & (\RegFile|rd1[6]~70_combout\ & !\CoreALU|Add0~11\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[6]~16_combout\,
	datab => \RegFile|rd1[6]~70_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~11\,
	combout => \CoreALU|Add0~12_combout\,
	cout => \CoreALU|Add0~13\);

-- Location: LCCOMB_X23_Y4_N12
\CoreALU|Mux25~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux25~3_combout\ = (\CoreALU|Add0~12_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~12_combout\,
	combout => \CoreALU|Mux25~3_combout\);

-- Location: LCCOMB_X23_Y4_N2
\CoreALU|Mux25~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux25~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~12_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux25~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (((!\CoreALU|Mux20~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Add1~12_combout\,
	datac => \CoreALU|Mux20~3_combout\,
	datad => \CoreALU|Mux25~3_combout\,
	combout => \CoreALU|Mux25~2_combout\);

-- Location: LCCOMB_X23_Y4_N26
\CoreALU|Mux25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux25~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[6]~16_combout\ & ((\RegFile|rd1[6]~70_combout\) # (!\CoreALU|Mux25~2_combout\))) # (!\SrcB[6]~16_combout\ & (\RegFile|rd1[6]~70_combout\ & !\CoreALU|Mux25~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux25~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \SrcB[6]~16_combout\,
	datac => \RegFile|rd1[6]~70_combout\,
	datad => \CoreALU|Mux25~2_combout\,
	combout => \CoreALU|Mux25~combout\);

-- Location: FF_X23_Y2_N13
\RegFile|mem~76\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux25~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~76_q\);

-- Location: LCCOMB_X23_Y2_N12
\RegFile|rd1[6]~70\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[6]~70_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~76_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~76_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[6]~70_combout\);

-- Location: LCCOMB_X24_Y4_N14
\CoreALU|Add1~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~14_combout\ = (\SrcB[7]~19_combout\ & ((\RegFile|rd1[7]~71_combout\ & (!\CoreALU|Add1~13\)) # (!\RegFile|rd1[7]~71_combout\ & ((\CoreALU|Add1~13\) # (GND))))) # (!\SrcB[7]~19_combout\ & ((\RegFile|rd1[7]~71_combout\ & (\CoreALU|Add1~13\ & 
-- VCC)) # (!\RegFile|rd1[7]~71_combout\ & (!\CoreALU|Add1~13\))))
-- \CoreALU|Add1~15\ = CARRY((\SrcB[7]~19_combout\ & ((!\CoreALU|Add1~13\) # (!\RegFile|rd1[7]~71_combout\))) # (!\SrcB[7]~19_combout\ & (!\RegFile|rd1[7]~71_combout\ & !\CoreALU|Add1~13\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[7]~19_combout\,
	datab => \RegFile|rd1[7]~71_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~13\,
	combout => \CoreALU|Add1~14_combout\,
	cout => \CoreALU|Add1~15\);

-- Location: LCCOMB_X22_Y4_N14
\CoreALU|Add0~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~14_combout\ = (\RegFile|rd1[7]~71_combout\ & ((\SrcB[7]~19_combout\ & (\CoreALU|Add0~13\ & VCC)) # (!\SrcB[7]~19_combout\ & (!\CoreALU|Add0~13\)))) # (!\RegFile|rd1[7]~71_combout\ & ((\SrcB[7]~19_combout\ & (!\CoreALU|Add0~13\)) # 
-- (!\SrcB[7]~19_combout\ & ((\CoreALU|Add0~13\) # (GND)))))
-- \CoreALU|Add0~15\ = CARRY((\RegFile|rd1[7]~71_combout\ & (!\SrcB[7]~19_combout\ & !\CoreALU|Add0~13\)) # (!\RegFile|rd1[7]~71_combout\ & ((!\CoreALU|Add0~13\) # (!\SrcB[7]~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[7]~71_combout\,
	datab => \SrcB[7]~19_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~13\,
	combout => \CoreALU|Add0~14_combout\,
	cout => \CoreALU|Add0~15\);

-- Location: LCCOMB_X24_Y2_N10
\CoreALU|Mux24~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux24~3_combout\ = (\CoreALU|Add0~14_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~14_combout\,
	combout => \CoreALU|Mux24~3_combout\);

-- Location: LCCOMB_X24_Y2_N16
\CoreALU|Mux24~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux24~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~14_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux24~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Add1~14_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux24~3_combout\,
	combout => \CoreALU|Mux24~2_combout\);

-- Location: LCCOMB_X24_Y2_N30
\CoreALU|Mux24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux24~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[7]~71_combout\ & ((\SrcB[7]~19_combout\) # (!\CoreALU|Mux24~2_combout\))) # (!\RegFile|rd1[7]~71_combout\ & (\SrcB[7]~19_combout\ & !\CoreALU|Mux24~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux24~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[7]~71_combout\,
	datab => \SrcB[7]~19_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux24~2_combout\,
	combout => \CoreALU|Mux24~combout\);

-- Location: FF_X23_Y2_N23
\RegFile|mem~205\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux24~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~205_q\);

-- Location: FF_X22_Y2_N23
\RegFile|mem~45\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux24~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~45_q\);

-- Location: FF_X24_Y2_N31
\RegFile|mem~109\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux24~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~109_q\);

-- Location: FF_X24_Y2_N5
\RegFile|mem~269\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux24~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~269_q\);

-- Location: LCCOMB_X24_Y2_N4
\SrcB[7]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[7]~17_combout\ = (\InstMem|Mux4~0_combout\ & (((\RegFile|mem~269_q\) # (!\InstMem|Mux3~1_combout\)))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~109_q\ & ((\InstMem|Mux3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~109_q\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~269_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \SrcB[7]~17_combout\);

-- Location: LCCOMB_X22_Y2_N22
\SrcB[7]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[7]~18_combout\ = (\InstMem|Mux3~1_combout\ & (((\SrcB[7]~17_combout\)))) # (!\InstMem|Mux3~1_combout\ & ((\SrcB[7]~17_combout\ & (\RegFile|mem~205_q\)) # (!\SrcB[7]~17_combout\ & ((\RegFile|mem~45_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~205_q\,
	datac => \RegFile|mem~45_q\,
	datad => \SrcB[7]~17_combout\,
	combout => \SrcB[7]~18_combout\);

-- Location: LCCOMB_X22_Y2_N16
\SrcB[7]~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[7]~19_combout\ = (!\InstMem|Mux1~0_combout\ & (\SrcB[7]~18_combout\ & \SrcB[30]~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datac => \SrcB[7]~18_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[7]~19_combout\);

-- Location: LCCOMB_X24_Y4_N16
\CoreALU|Add1~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~16_combout\ = ((\SrcB[8]~20_combout\ $ (\RegFile|rd1[8]~72_combout\ $ (\CoreALU|Add1~15\)))) # (GND)
-- \CoreALU|Add1~17\ = CARRY((\SrcB[8]~20_combout\ & (\RegFile|rd1[8]~72_combout\ & !\CoreALU|Add1~15\)) # (!\SrcB[8]~20_combout\ & ((\RegFile|rd1[8]~72_combout\) # (!\CoreALU|Add1~15\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[8]~20_combout\,
	datab => \RegFile|rd1[8]~72_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~15\,
	combout => \CoreALU|Add1~16_combout\,
	cout => \CoreALU|Add1~17\);

-- Location: LCCOMB_X22_Y4_N16
\CoreALU|Add0~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~16_combout\ = ((\SrcB[8]~20_combout\ $ (\RegFile|rd1[8]~72_combout\ $ (!\CoreALU|Add0~15\)))) # (GND)
-- \CoreALU|Add0~17\ = CARRY((\SrcB[8]~20_combout\ & ((\RegFile|rd1[8]~72_combout\) # (!\CoreALU|Add0~15\))) # (!\SrcB[8]~20_combout\ & (\RegFile|rd1[8]~72_combout\ & !\CoreALU|Add0~15\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[8]~20_combout\,
	datab => \RegFile|rd1[8]~72_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~15\,
	combout => \CoreALU|Add0~16_combout\,
	cout => \CoreALU|Add0~17\);

-- Location: LCCOMB_X21_Y4_N20
\CoreALU|Mux23~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux23~3_combout\ = (\CoreALU|Add0~16_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~16_combout\,
	combout => \CoreALU|Mux23~3_combout\);

-- Location: LCCOMB_X21_Y4_N6
\CoreALU|Mux23~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux23~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~16_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux23~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~16_combout\,
	datad => \CoreALU|Mux23~3_combout\,
	combout => \CoreALU|Mux23~2_combout\);

-- Location: LCCOMB_X21_Y4_N22
\CoreALU|Mux23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux23~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[8]~72_combout\ & ((\SrcB[8]~20_combout\) # (!\CoreALU|Mux23~2_combout\))) # (!\RegFile|rd1[8]~72_combout\ & (\SrcB[8]~20_combout\ & !\CoreALU|Mux23~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux23~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[8]~72_combout\,
	datab => \SrcB[8]~20_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux23~2_combout\,
	combout => \CoreALU|Mux23~combout\);

-- Location: LCCOMB_X20_Y2_N16
\RegFile|mem~206feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~206feeder_combout\ = \CoreALU|Mux23~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux23~combout\,
	combout => \RegFile|mem~206feeder_combout\);

-- Location: FF_X20_Y2_N17
\RegFile|mem~206\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~206feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~206_q\);

-- Location: FF_X21_Y2_N5
\RegFile|mem~270\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux23~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~270_q\);

-- Location: LCCOMB_X21_Y2_N4
\RegFile|mem~1081\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1081_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~270_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~206_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~206_q\,
	datac => \RegFile|mem~270_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1081_combout\);

-- Location: FF_X21_Y4_N23
\RegFile|mem~110\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux23~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~110_q\);

-- Location: FF_X21_Y4_N9
\RegFile|mem~46\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux23~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~46_q\);

-- Location: LCCOMB_X21_Y4_N8
\RegFile|mem~1082\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1082_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~110_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~46_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~110_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~46_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1082_combout\);

-- Location: LCCOMB_X21_Y4_N16
\SrcB[8]~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[8]~20_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1081_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1082_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1081_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1082_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[8]~20_combout\);

-- Location: LCCOMB_X24_Y4_N18
\CoreALU|Add1~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~18_combout\ = (\SrcB[9]~21_combout\ & ((\RegFile|rd1[9]~73_combout\ & (!\CoreALU|Add1~17\)) # (!\RegFile|rd1[9]~73_combout\ & ((\CoreALU|Add1~17\) # (GND))))) # (!\SrcB[9]~21_combout\ & ((\RegFile|rd1[9]~73_combout\ & (\CoreALU|Add1~17\ & 
-- VCC)) # (!\RegFile|rd1[9]~73_combout\ & (!\CoreALU|Add1~17\))))
-- \CoreALU|Add1~19\ = CARRY((\SrcB[9]~21_combout\ & ((!\CoreALU|Add1~17\) # (!\RegFile|rd1[9]~73_combout\))) # (!\SrcB[9]~21_combout\ & (!\RegFile|rd1[9]~73_combout\ & !\CoreALU|Add1~17\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[9]~21_combout\,
	datab => \RegFile|rd1[9]~73_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~17\,
	combout => \CoreALU|Add1~18_combout\,
	cout => \CoreALU|Add1~19\);

-- Location: LCCOMB_X22_Y4_N18
\CoreALU|Add0~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~18_combout\ = (\SrcB[9]~21_combout\ & ((\RegFile|rd1[9]~73_combout\ & (\CoreALU|Add0~17\ & VCC)) # (!\RegFile|rd1[9]~73_combout\ & (!\CoreALU|Add0~17\)))) # (!\SrcB[9]~21_combout\ & ((\RegFile|rd1[9]~73_combout\ & (!\CoreALU|Add0~17\)) # 
-- (!\RegFile|rd1[9]~73_combout\ & ((\CoreALU|Add0~17\) # (GND)))))
-- \CoreALU|Add0~19\ = CARRY((\SrcB[9]~21_combout\ & (!\RegFile|rd1[9]~73_combout\ & !\CoreALU|Add0~17\)) # (!\SrcB[9]~21_combout\ & ((!\CoreALU|Add0~17\) # (!\RegFile|rd1[9]~73_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[9]~21_combout\,
	datab => \RegFile|rd1[9]~73_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~17\,
	combout => \CoreALU|Add0~18_combout\,
	cout => \CoreALU|Add0~19\);

-- Location: LCCOMB_X23_Y4_N10
\CoreALU|Mux22~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux22~3_combout\ = (\CoreALU|Add0~18_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~18_combout\,
	combout => \CoreALU|Mux22~3_combout\);

-- Location: LCCOMB_X23_Y4_N18
\CoreALU|Mux22~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux22~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~18_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux22~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Add1~18_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux22~3_combout\,
	combout => \CoreALU|Mux22~2_combout\);

-- Location: LCCOMB_X23_Y4_N22
\CoreALU|Mux22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux22~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[9]~73_combout\ & ((\SrcB[9]~21_combout\) # (!\CoreALU|Mux22~2_combout\))) # (!\RegFile|rd1[9]~73_combout\ & (\SrcB[9]~21_combout\ & !\CoreALU|Mux22~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux22~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[9]~73_combout\,
	datac => \SrcB[9]~21_combout\,
	datad => \CoreALU|Mux22~2_combout\,
	combout => \CoreALU|Mux22~combout\);

-- Location: FF_X23_Y4_N23
\RegFile|mem~111\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux22~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~111_q\);

-- Location: FF_X23_Y4_N9
\RegFile|mem~47\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux22~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~47_q\);

-- Location: LCCOMB_X23_Y4_N8
\RegFile|mem~1084\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1084_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~111_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~47_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~111_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~47_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1084_combout\);

-- Location: FF_X21_Y2_N19
\RegFile|mem~271\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux22~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~271_q\);

-- Location: LCCOMB_X20_Y2_N14
\RegFile|mem~207feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~207feeder_combout\ = \CoreALU|Mux22~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux22~combout\,
	combout => \RegFile|mem~207feeder_combout\);

-- Location: FF_X20_Y2_N15
\RegFile|mem~207\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~207feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~207_q\);

-- Location: LCCOMB_X21_Y2_N18
\RegFile|mem~1083\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1083_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~271_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~207_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~271_q\,
	datad => \RegFile|mem~207_q\,
	combout => \RegFile|mem~1083_combout\);

-- Location: LCCOMB_X23_Y4_N16
\SrcB[9]~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[9]~21_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1083_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1084_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1084_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1083_combout\,
	combout => \SrcB[9]~21_combout\);

-- Location: LCCOMB_X24_Y4_N20
\CoreALU|Add1~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~20_combout\ = ((\SrcB[10]~24_combout\ $ (\RegFile|rd1[10]~74_combout\ $ (\CoreALU|Add1~19\)))) # (GND)
-- \CoreALU|Add1~21\ = CARRY((\SrcB[10]~24_combout\ & (\RegFile|rd1[10]~74_combout\ & !\CoreALU|Add1~19\)) # (!\SrcB[10]~24_combout\ & ((\RegFile|rd1[10]~74_combout\) # (!\CoreALU|Add1~19\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[10]~24_combout\,
	datab => \RegFile|rd1[10]~74_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~19\,
	combout => \CoreALU|Add1~20_combout\,
	cout => \CoreALU|Add1~21\);

-- Location: LCCOMB_X22_Y4_N20
\CoreALU|Add0~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~20_combout\ = ((\RegFile|rd1[10]~74_combout\ $ (\SrcB[10]~24_combout\ $ (!\CoreALU|Add0~19\)))) # (GND)
-- \CoreALU|Add0~21\ = CARRY((\RegFile|rd1[10]~74_combout\ & ((\SrcB[10]~24_combout\) # (!\CoreALU|Add0~19\))) # (!\RegFile|rd1[10]~74_combout\ & (\SrcB[10]~24_combout\ & !\CoreALU|Add0~19\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[10]~74_combout\,
	datab => \SrcB[10]~24_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~19\,
	combout => \CoreALU|Add0~20_combout\,
	cout => \CoreALU|Add0~21\);

-- Location: LCCOMB_X25_Y4_N10
\CoreALU|Mux21~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux21~3_combout\ = (\CoreALU|Add0~20_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~20_combout\,
	combout => \CoreALU|Mux21~3_combout\);

-- Location: LCCOMB_X25_Y4_N24
\CoreALU|Mux21~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux21~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~20_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux21~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Add1~20_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux21~3_combout\,
	combout => \CoreALU|Mux21~2_combout\);

-- Location: LCCOMB_X25_Y4_N6
\CoreALU|Mux21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux21~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[10]~74_combout\ & ((\SrcB[10]~24_combout\) # (!\CoreALU|Mux21~2_combout\))) # (!\RegFile|rd1[10]~74_combout\ & (\SrcB[10]~24_combout\ & !\CoreALU|Mux21~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux21~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[10]~74_combout\,
	datab => \CoreALU|Mux31~0_combout\,
	datac => \SrcB[10]~24_combout\,
	datad => \CoreALU|Mux21~2_combout\,
	combout => \CoreALU|Mux21~combout\);

-- Location: LCCOMB_X23_Y4_N24
\RegFile|mem~112feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~112feeder_combout\ = \CoreALU|Mux21~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux21~combout\,
	combout => \RegFile|mem~112feeder_combout\);

-- Location: FF_X23_Y4_N25
\RegFile|mem~112\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~112feeder_combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~112_q\);

-- Location: FF_X23_Y4_N15
\RegFile|mem~48\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux21~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~48_q\);

-- Location: LCCOMB_X23_Y4_N14
\RegFile|mem~1085\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1085_combout\ = (\InstMem|Mux4~0_combout\ & (((\InstMem|Mux3~1_combout\)))) # (!\InstMem|Mux4~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~112_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~48_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~112_q\,
	datac => \RegFile|mem~48_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1085_combout\);

-- Location: LCCOMB_X26_Y4_N30
\SrcB[10]~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~49_combout\ = (!\InstMem|Mux1~0_combout\ & (!\ExtUnit|Mux31~0_combout\ & ((\InstMem|Mux4~0_combout\) # (\InstMem|Mux3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \InstMem|Mux1~0_combout\,
	datad => \ExtUnit|Mux31~0_combout\,
	combout => \SrcB[10]~49_combout\);

-- Location: LCCOMB_X26_Y4_N4
\RegFile|mem~272feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~272feeder_combout\ = \CoreALU|Mux21~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux21~combout\,
	combout => \RegFile|mem~272feeder_combout\);

-- Location: FF_X26_Y4_N5
\RegFile|mem~272\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~272feeder_combout\,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~272_q\);

-- Location: FF_X26_Y4_N3
\RegFile|mem~208\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux21~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~208_q\);

-- Location: LCCOMB_X26_Y4_N16
\RegFile|mem~1135\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1135_combout\ = (\InstMem|Mux4~0_combout\ & (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & \InstMem|Mux3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \PC_Reg|PC_out\(6),
	datac => \PC_Reg|PC_out\(7),
	datad => \InstMem|Mux3~0_combout\,
	combout => \RegFile|mem~1135_combout\);

-- Location: LCCOMB_X26_Y4_N2
\SrcB[10]~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~22_combout\ = (\RegFile|mem~1135_combout\ & (\RegFile|mem~272_q\)) # (!\RegFile|mem~1135_combout\ & ((\RegFile|mem~208_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|mem~272_q\,
	datac => \RegFile|mem~208_q\,
	datad => \RegFile|mem~1135_combout\,
	combout => \SrcB[10]~22_combout\);

-- Location: LCCOMB_X26_Y4_N10
\SrcB[10]~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~23_combout\ = (\SrcB[10]~49_combout\ & ((\InstMem|Mux4~0_combout\ & ((\SrcB[10]~22_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1085_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1085_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \SrcB[10]~49_combout\,
	datad => \SrcB[10]~22_combout\,
	combout => \SrcB[10]~23_combout\);

-- Location: LCCOMB_X26_Y4_N8
\SrcB[10]~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[10]~24_combout\ = (\SrcB[10]~23_combout\) # ((\SrcB[10]~9_combout\ & (\PC_Reg|PC_out\(3) & \PC_Reg|PC_out\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[10]~9_combout\,
	datab => \PC_Reg|PC_out\(3),
	datac => \PC_Reg|PC_out\(2),
	datad => \SrcB[10]~23_combout\,
	combout => \SrcB[10]~24_combout\);

-- Location: LCCOMB_X24_Y4_N22
\CoreALU|Add1~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~22_combout\ = (\SrcB[11]~25_combout\ & ((\RegFile|rd1[11]~75_combout\ & (!\CoreALU|Add1~21\)) # (!\RegFile|rd1[11]~75_combout\ & ((\CoreALU|Add1~21\) # (GND))))) # (!\SrcB[11]~25_combout\ & ((\RegFile|rd1[11]~75_combout\ & (\CoreALU|Add1~21\ 
-- & VCC)) # (!\RegFile|rd1[11]~75_combout\ & (!\CoreALU|Add1~21\))))
-- \CoreALU|Add1~23\ = CARRY((\SrcB[11]~25_combout\ & ((!\CoreALU|Add1~21\) # (!\RegFile|rd1[11]~75_combout\))) # (!\SrcB[11]~25_combout\ & (!\RegFile|rd1[11]~75_combout\ & !\CoreALU|Add1~21\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[11]~25_combout\,
	datab => \RegFile|rd1[11]~75_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~21\,
	combout => \CoreALU|Add1~22_combout\,
	cout => \CoreALU|Add1~23\);

-- Location: LCCOMB_X22_Y4_N22
\CoreALU|Add0~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~22_combout\ = (\RegFile|rd1[11]~75_combout\ & ((\SrcB[11]~25_combout\ & (\CoreALU|Add0~21\ & VCC)) # (!\SrcB[11]~25_combout\ & (!\CoreALU|Add0~21\)))) # (!\RegFile|rd1[11]~75_combout\ & ((\SrcB[11]~25_combout\ & (!\CoreALU|Add0~21\)) # 
-- (!\SrcB[11]~25_combout\ & ((\CoreALU|Add0~21\) # (GND)))))
-- \CoreALU|Add0~23\ = CARRY((\RegFile|rd1[11]~75_combout\ & (!\SrcB[11]~25_combout\ & !\CoreALU|Add0~21\)) # (!\RegFile|rd1[11]~75_combout\ & ((!\CoreALU|Add0~21\) # (!\SrcB[11]~25_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[11]~75_combout\,
	datab => \SrcB[11]~25_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~21\,
	combout => \CoreALU|Add0~22_combout\,
	cout => \CoreALU|Add0~23\);

-- Location: LCCOMB_X21_Y4_N12
\CoreALU|Mux20~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux20~5_combout\ = (\CoreALU|Add0~22_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~22_combout\,
	combout => \CoreALU|Mux20~5_combout\);

-- Location: LCCOMB_X21_Y4_N2
\CoreALU|Mux20~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux20~4_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~22_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux20~5_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~22_combout\,
	datad => \CoreALU|Mux20~5_combout\,
	combout => \CoreALU|Mux20~4_combout\);

-- Location: LCCOMB_X21_Y4_N30
\CoreALU|Mux20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux20~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[11]~25_combout\ & ((\RegFile|rd1[11]~75_combout\) # (!\CoreALU|Mux20~4_combout\))) # (!\SrcB[11]~25_combout\ & (\RegFile|rd1[11]~75_combout\ & !\CoreALU|Mux20~4_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux20~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \SrcB[11]~25_combout\,
	datac => \RegFile|rd1[11]~75_combout\,
	datad => \CoreALU|Mux20~4_combout\,
	combout => \CoreALU|Mux20~combout\);

-- Location: FF_X21_Y4_N31
\RegFile|mem~113\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux20~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~113_q\);

-- Location: FF_X21_Y4_N29
\RegFile|mem~49\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux20~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~49_q\);

-- Location: LCCOMB_X21_Y4_N28
\RegFile|mem~1087\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1087_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~113_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~49_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~113_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~49_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1087_combout\);

-- Location: LCCOMB_X20_Y2_N8
\RegFile|mem~209feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~209feeder_combout\ = \CoreALU|Mux20~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux20~combout\,
	combout => \RegFile|mem~209feeder_combout\);

-- Location: FF_X20_Y2_N9
\RegFile|mem~209\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~209feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~209_q\);

-- Location: FF_X21_Y2_N21
\RegFile|mem~273\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux20~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~273_q\);

-- Location: LCCOMB_X21_Y2_N20
\RegFile|mem~1086\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1086_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~273_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~209_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~209_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~273_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1086_combout\);

-- Location: LCCOMB_X21_Y4_N24
\SrcB[11]~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[11]~25_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1086_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1087_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \RegFile|mem~1087_combout\,
	datac => \RegFile|mem~1086_combout\,
	datad => \InstMem|Mux4~0_combout\,
	combout => \SrcB[11]~25_combout\);

-- Location: LCCOMB_X24_Y4_N24
\CoreALU|Add1~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~24_combout\ = ((\RegFile|rd1[12]~76_combout\ $ (\SrcB[12]~26_combout\ $ (\CoreALU|Add1~23\)))) # (GND)
-- \CoreALU|Add1~25\ = CARRY((\RegFile|rd1[12]~76_combout\ & ((!\CoreALU|Add1~23\) # (!\SrcB[12]~26_combout\))) # (!\RegFile|rd1[12]~76_combout\ & (!\SrcB[12]~26_combout\ & !\CoreALU|Add1~23\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[12]~76_combout\,
	datab => \SrcB[12]~26_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~23\,
	combout => \CoreALU|Add1~24_combout\,
	cout => \CoreALU|Add1~25\);

-- Location: LCCOMB_X22_Y4_N24
\CoreALU|Add0~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~24_combout\ = ((\RegFile|rd1[12]~76_combout\ $ (\SrcB[12]~26_combout\ $ (!\CoreALU|Add0~23\)))) # (GND)
-- \CoreALU|Add0~25\ = CARRY((\RegFile|rd1[12]~76_combout\ & ((\SrcB[12]~26_combout\) # (!\CoreALU|Add0~23\))) # (!\RegFile|rd1[12]~76_combout\ & (\SrcB[12]~26_combout\ & !\CoreALU|Add0~23\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[12]~76_combout\,
	datab => \SrcB[12]~26_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~23\,
	combout => \CoreALU|Add0~24_combout\,
	cout => \CoreALU|Add0~25\);

-- Location: LCCOMB_X25_Y4_N16
\CoreALU|Mux19~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux19~3_combout\ = (\CoreALU|Add0~24_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~24_combout\,
	combout => \CoreALU|Mux19~3_combout\);

-- Location: LCCOMB_X25_Y4_N8
\CoreALU|Mux19~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux19~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~24_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux19~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Add1~24_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux19~3_combout\,
	combout => \CoreALU|Mux19~2_combout\);

-- Location: LCCOMB_X26_Y5_N28
\CoreALU|Mux19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux19~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[12]~76_combout\ & ((\SrcB[12]~26_combout\) # (!\CoreALU|Mux19~2_combout\))) # (!\RegFile|rd1[12]~76_combout\ & (\SrcB[12]~26_combout\ & !\CoreALU|Mux19~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux19~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[12]~76_combout\,
	datab => \SrcB[12]~26_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux19~2_combout\,
	combout => \CoreALU|Mux19~combout\);

-- Location: FF_X26_Y5_N13
\RegFile|mem~82\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux19~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~82_q\);

-- Location: LCCOMB_X26_Y5_N12
\RegFile|rd1[12]~76\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[12]~76_combout\ = (!\PC_Reg|PC_out\(7) & (!\PC_Reg|PC_out\(6) & (\RegFile|mem~82_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \PC_Reg|PC_out\(6),
	datac => \RegFile|mem~82_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[12]~76_combout\);

-- Location: LCCOMB_X24_Y4_N26
\CoreALU|Add1~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~26_combout\ = (\SrcB[13]~27_combout\ & ((\RegFile|rd1[13]~77_combout\ & (!\CoreALU|Add1~25\)) # (!\RegFile|rd1[13]~77_combout\ & ((\CoreALU|Add1~25\) # (GND))))) # (!\SrcB[13]~27_combout\ & ((\RegFile|rd1[13]~77_combout\ & (\CoreALU|Add1~25\ 
-- & VCC)) # (!\RegFile|rd1[13]~77_combout\ & (!\CoreALU|Add1~25\))))
-- \CoreALU|Add1~27\ = CARRY((\SrcB[13]~27_combout\ & ((!\CoreALU|Add1~25\) # (!\RegFile|rd1[13]~77_combout\))) # (!\SrcB[13]~27_combout\ & (!\RegFile|rd1[13]~77_combout\ & !\CoreALU|Add1~25\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[13]~27_combout\,
	datab => \RegFile|rd1[13]~77_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~25\,
	combout => \CoreALU|Add1~26_combout\,
	cout => \CoreALU|Add1~27\);

-- Location: LCCOMB_X22_Y4_N26
\CoreALU|Add0~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~26_combout\ = (\RegFile|rd1[13]~77_combout\ & ((\SrcB[13]~27_combout\ & (\CoreALU|Add0~25\ & VCC)) # (!\SrcB[13]~27_combout\ & (!\CoreALU|Add0~25\)))) # (!\RegFile|rd1[13]~77_combout\ & ((\SrcB[13]~27_combout\ & (!\CoreALU|Add0~25\)) # 
-- (!\SrcB[13]~27_combout\ & ((\CoreALU|Add0~25\) # (GND)))))
-- \CoreALU|Add0~27\ = CARRY((\RegFile|rd1[13]~77_combout\ & (!\SrcB[13]~27_combout\ & !\CoreALU|Add0~25\)) # (!\RegFile|rd1[13]~77_combout\ & ((!\CoreALU|Add0~25\) # (!\SrcB[13]~27_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[13]~77_combout\,
	datab => \SrcB[13]~27_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~25\,
	combout => \CoreALU|Add0~26_combout\,
	cout => \CoreALU|Add0~27\);

-- Location: LCCOMB_X21_Y4_N18
\CoreALU|Mux18~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux18~3_combout\ = (\CoreALU|Add0~26_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~26_combout\,
	combout => \CoreALU|Mux18~3_combout\);

-- Location: LCCOMB_X21_Y4_N10
\CoreALU|Mux18~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux18~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~26_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux18~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~26_combout\,
	datad => \CoreALU|Mux18~3_combout\,
	combout => \CoreALU|Mux18~2_combout\);

-- Location: LCCOMB_X21_Y4_N26
\CoreALU|Mux18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux18~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[13]~77_combout\ & ((\SrcB[13]~27_combout\) # (!\CoreALU|Mux18~2_combout\))) # (!\RegFile|rd1[13]~77_combout\ & (\SrcB[13]~27_combout\ & !\CoreALU|Mux18~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux18~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[13]~77_combout\,
	datac => \SrcB[13]~27_combout\,
	datad => \CoreALU|Mux18~2_combout\,
	combout => \CoreALU|Mux18~combout\);

-- Location: FF_X20_Y4_N7
\RegFile|mem~275\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux18~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~275_q\);

-- Location: FF_X22_Y4_N11
\RegFile|mem~211\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux18~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~211_q\);

-- Location: LCCOMB_X20_Y4_N6
\RegFile|mem~1092\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1092_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~275_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~211_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~275_q\,
	datad => \RegFile|mem~211_q\,
	combout => \RegFile|mem~1092_combout\);

-- Location: FF_X21_Y4_N27
\RegFile|mem~115\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux18~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~115_q\);

-- Location: FF_X21_Y4_N1
\RegFile|mem~51\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux18~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~51_q\);

-- Location: LCCOMB_X21_Y4_N0
\RegFile|mem~1093\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1093_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~115_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~51_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~115_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~51_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1093_combout\);

-- Location: LCCOMB_X21_Y4_N4
\SrcB[13]~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[13]~27_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1092_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1093_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1092_combout\,
	datad => \RegFile|mem~1093_combout\,
	combout => \SrcB[13]~27_combout\);

-- Location: LCCOMB_X24_Y4_N28
\CoreALU|Add1~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~28_combout\ = ((\SrcB[14]~30_combout\ $ (\RegFile|rd1[14]~78_combout\ $ (\CoreALU|Add1~27\)))) # (GND)
-- \CoreALU|Add1~29\ = CARRY((\SrcB[14]~30_combout\ & (\RegFile|rd1[14]~78_combout\ & !\CoreALU|Add1~27\)) # (!\SrcB[14]~30_combout\ & ((\RegFile|rd1[14]~78_combout\) # (!\CoreALU|Add1~27\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[14]~30_combout\,
	datab => \RegFile|rd1[14]~78_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~27\,
	combout => \CoreALU|Add1~28_combout\,
	cout => \CoreALU|Add1~29\);

-- Location: LCCOMB_X22_Y4_N28
\CoreALU|Add0~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~28_combout\ = ((\SrcB[14]~30_combout\ $ (\RegFile|rd1[14]~78_combout\ $ (!\CoreALU|Add0~27\)))) # (GND)
-- \CoreALU|Add0~29\ = CARRY((\SrcB[14]~30_combout\ & ((\RegFile|rd1[14]~78_combout\) # (!\CoreALU|Add0~27\))) # (!\SrcB[14]~30_combout\ & (\RegFile|rd1[14]~78_combout\ & !\CoreALU|Add0~27\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[14]~30_combout\,
	datab => \RegFile|rd1[14]~78_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~27\,
	combout => \CoreALU|Add0~28_combout\,
	cout => \CoreALU|Add0~29\);

-- Location: LCCOMB_X25_Y4_N18
\CoreALU|Mux17~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux17~3_combout\ = (\CoreALU|Add0~28_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~28_combout\,
	combout => \CoreALU|Mux17~3_combout\);

-- Location: LCCOMB_X25_Y4_N14
\CoreALU|Mux17~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux17~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~28_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux17~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Add1~28_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux17~3_combout\,
	combout => \CoreALU|Mux17~2_combout\);

-- Location: LCCOMB_X26_Y4_N28
\CoreALU|Mux17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux17~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[14]~78_combout\ & ((\SrcB[14]~30_combout\) # (!\CoreALU|Mux17~2_combout\))) # (!\RegFile|rd1[14]~78_combout\ & (\SrcB[14]~30_combout\ & !\CoreALU|Mux17~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux17~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[14]~78_combout\,
	datab => \SrcB[14]~30_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux17~2_combout\,
	combout => \CoreALU|Mux17~combout\);

-- Location: FF_X26_Y4_N29
\RegFile|mem~276\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux17~combout\,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~276_q\);

-- Location: FF_X26_Y4_N15
\RegFile|mem~212\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux17~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~212_q\);

-- Location: LCCOMB_X26_Y4_N14
\SrcB[14]~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[14]~28_combout\ = (\RegFile|mem~1135_combout\ & (\RegFile|mem~276_q\)) # (!\RegFile|mem~1135_combout\ & ((\RegFile|mem~212_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|mem~276_q\,
	datac => \RegFile|mem~212_q\,
	datad => \RegFile|mem~1135_combout\,
	combout => \SrcB[14]~28_combout\);

-- Location: LCCOMB_X24_Y5_N16
\RegFile|mem~116feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~116feeder_combout\ = \CoreALU|Mux17~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux17~combout\,
	combout => \RegFile|mem~116feeder_combout\);

-- Location: FF_X24_Y5_N17
\RegFile|mem~116\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~116feeder_combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~116_q\);

-- Location: FF_X25_Y5_N3
\RegFile|mem~52\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux17~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~52_q\);

-- Location: LCCOMB_X25_Y5_N2
\RegFile|mem~1094\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1094_combout\ = (\InstMem|Mux4~0_combout\ & (((\InstMem|Mux3~1_combout\)))) # (!\InstMem|Mux4~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~116_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~52_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~116_q\,
	datac => \RegFile|mem~52_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1094_combout\);

-- Location: LCCOMB_X26_Y4_N22
\SrcB[14]~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[14]~29_combout\ = (\InstMem|Mux4~0_combout\ & (\SrcB[14]~28_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1094_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datac => \SrcB[14]~28_combout\,
	datad => \RegFile|mem~1094_combout\,
	combout => \SrcB[14]~29_combout\);

-- Location: LCCOMB_X26_Y4_N20
\SrcB[14]~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[14]~30_combout\ = (!\InstMem|Mux1~0_combout\ & (\SrcB[14]~29_combout\ & \SrcB[30]~7_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datac => \SrcB[14]~29_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[14]~30_combout\);

-- Location: LCCOMB_X24_Y4_N30
\CoreALU|Add1~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~30_combout\ = (\SrcB[15]~31_combout\ & ((\RegFile|rd1[15]~79_combout\ & (!\CoreALU|Add1~29\)) # (!\RegFile|rd1[15]~79_combout\ & ((\CoreALU|Add1~29\) # (GND))))) # (!\SrcB[15]~31_combout\ & ((\RegFile|rd1[15]~79_combout\ & (\CoreALU|Add1~29\ 
-- & VCC)) # (!\RegFile|rd1[15]~79_combout\ & (!\CoreALU|Add1~29\))))
-- \CoreALU|Add1~31\ = CARRY((\SrcB[15]~31_combout\ & ((!\CoreALU|Add1~29\) # (!\RegFile|rd1[15]~79_combout\))) # (!\SrcB[15]~31_combout\ & (!\RegFile|rd1[15]~79_combout\ & !\CoreALU|Add1~29\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[15]~31_combout\,
	datab => \RegFile|rd1[15]~79_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~29\,
	combout => \CoreALU|Add1~30_combout\,
	cout => \CoreALU|Add1~31\);

-- Location: LCCOMB_X22_Y4_N30
\CoreALU|Add0~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~30_combout\ = (\SrcB[15]~31_combout\ & ((\RegFile|rd1[15]~79_combout\ & (\CoreALU|Add0~29\ & VCC)) # (!\RegFile|rd1[15]~79_combout\ & (!\CoreALU|Add0~29\)))) # (!\SrcB[15]~31_combout\ & ((\RegFile|rd1[15]~79_combout\ & (!\CoreALU|Add0~29\)) 
-- # (!\RegFile|rd1[15]~79_combout\ & ((\CoreALU|Add0~29\) # (GND)))))
-- \CoreALU|Add0~31\ = CARRY((\SrcB[15]~31_combout\ & (!\RegFile|rd1[15]~79_combout\ & !\CoreALU|Add0~29\)) # (!\SrcB[15]~31_combout\ & ((!\CoreALU|Add0~29\) # (!\RegFile|rd1[15]~79_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[15]~31_combout\,
	datab => \RegFile|rd1[15]~79_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~29\,
	combout => \CoreALU|Add0~30_combout\,
	cout => \CoreALU|Add0~31\);

-- Location: LCCOMB_X25_Y3_N16
\CoreALU|Mux16~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux16~3_combout\ = (\CoreALU|Add0~30_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \Control|Mux5~0_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~30_combout\,
	combout => \CoreALU|Mux16~3_combout\);

-- Location: LCCOMB_X25_Y3_N2
\CoreALU|Mux16~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux16~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~30_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux16~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~30_combout\,
	datad => \CoreALU|Mux16~3_combout\,
	combout => \CoreALU|Mux16~2_combout\);

-- Location: LCCOMB_X25_Y3_N26
\CoreALU|Mux16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux16~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[15]~79_combout\ & ((\SrcB[15]~31_combout\) # (!\CoreALU|Mux16~2_combout\))) # (!\RegFile|rd1[15]~79_combout\ & (\SrcB[15]~31_combout\ & !\CoreALU|Mux16~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux16~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[15]~79_combout\,
	datab => \SrcB[15]~31_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux16~2_combout\,
	combout => \CoreALU|Mux16~combout\);

-- Location: FF_X26_Y2_N17
\RegFile|mem~213\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux16~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~213_q\);

-- Location: FF_X21_Y2_N3
\RegFile|mem~277\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux16~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~277_q\);

-- Location: LCCOMB_X21_Y2_N2
\RegFile|mem~1095\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1095_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~277_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~213_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~213_q\,
	datac => \RegFile|mem~277_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1095_combout\);

-- Location: FF_X25_Y3_N27
\RegFile|mem~117\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux16~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~117_q\);

-- Location: FF_X25_Y3_N13
\RegFile|mem~53\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux16~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~53_q\);

-- Location: LCCOMB_X25_Y3_N12
\RegFile|mem~1096\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1096_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~117_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~53_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~117_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~53_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1096_combout\);

-- Location: LCCOMB_X25_Y3_N0
\SrcB[15]~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[15]~31_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1095_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1096_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1095_combout\,
	datad => \RegFile|mem~1096_combout\,
	combout => \SrcB[15]~31_combout\);

-- Location: LCCOMB_X24_Y3_N0
\CoreALU|Add1~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~32_combout\ = ((\RegFile|rd1[16]~80_combout\ $ (\SrcB[16]~32_combout\ $ (\CoreALU|Add1~31\)))) # (GND)
-- \CoreALU|Add1~33\ = CARRY((\RegFile|rd1[16]~80_combout\ & ((!\CoreALU|Add1~31\) # (!\SrcB[16]~32_combout\))) # (!\RegFile|rd1[16]~80_combout\ & (!\SrcB[16]~32_combout\ & !\CoreALU|Add1~31\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[16]~80_combout\,
	datab => \SrcB[16]~32_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~31\,
	combout => \CoreALU|Add1~32_combout\,
	cout => \CoreALU|Add1~33\);

-- Location: LCCOMB_X22_Y3_N0
\CoreALU|Add0~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~32_combout\ = ((\SrcB[16]~32_combout\ $ (\RegFile|rd1[16]~80_combout\ $ (!\CoreALU|Add0~31\)))) # (GND)
-- \CoreALU|Add0~33\ = CARRY((\SrcB[16]~32_combout\ & ((\RegFile|rd1[16]~80_combout\) # (!\CoreALU|Add0~31\))) # (!\SrcB[16]~32_combout\ & (\RegFile|rd1[16]~80_combout\ & !\CoreALU|Add0~31\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[16]~32_combout\,
	datab => \RegFile|rd1[16]~80_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~31\,
	combout => \CoreALU|Add0~32_combout\,
	cout => \CoreALU|Add0~33\);

-- Location: LCCOMB_X25_Y3_N18
\CoreALU|Mux15~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux15~3_combout\ = (\CoreALU|Add0~32_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \Control|Mux5~0_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~32_combout\,
	combout => \CoreALU|Mux15~3_combout\);

-- Location: LCCOMB_X25_Y3_N10
\CoreALU|Mux15~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux15~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~32_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux15~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Add1~32_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux15~3_combout\,
	combout => \CoreALU|Mux15~2_combout\);

-- Location: LCCOMB_X25_Y3_N6
\CoreALU|Mux15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux15~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[16]~80_combout\ & ((\SrcB[16]~32_combout\) # (!\CoreALU|Mux15~2_combout\))) # (!\RegFile|rd1[16]~80_combout\ & (\SrcB[16]~32_combout\ & !\CoreALU|Mux15~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux15~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[16]~80_combout\,
	datab => \CoreALU|Mux31~0_combout\,
	datac => \SrcB[16]~32_combout\,
	datad => \CoreALU|Mux15~2_combout\,
	combout => \CoreALU|Mux15~combout\);

-- Location: FF_X27_Y3_N13
\RegFile|mem~86\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux15~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~86_q\);

-- Location: LCCOMB_X27_Y3_N12
\RegFile|rd1[16]~80\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[16]~80_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~86_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~86_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[16]~80_combout\);

-- Location: LCCOMB_X24_Y3_N2
\CoreALU|Add1~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~34_combout\ = (\RegFile|rd1[17]~81_combout\ & ((\SrcB[17]~33_combout\ & (!\CoreALU|Add1~33\)) # (!\SrcB[17]~33_combout\ & (\CoreALU|Add1~33\ & VCC)))) # (!\RegFile|rd1[17]~81_combout\ & ((\SrcB[17]~33_combout\ & ((\CoreALU|Add1~33\) # 
-- (GND))) # (!\SrcB[17]~33_combout\ & (!\CoreALU|Add1~33\))))
-- \CoreALU|Add1~35\ = CARRY((\RegFile|rd1[17]~81_combout\ & (\SrcB[17]~33_combout\ & !\CoreALU|Add1~33\)) # (!\RegFile|rd1[17]~81_combout\ & ((\SrcB[17]~33_combout\) # (!\CoreALU|Add1~33\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[17]~81_combout\,
	datab => \SrcB[17]~33_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~33\,
	combout => \CoreALU|Add1~34_combout\,
	cout => \CoreALU|Add1~35\);

-- Location: LCCOMB_X22_Y3_N2
\CoreALU|Add0~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~34_combout\ = (\SrcB[17]~33_combout\ & ((\RegFile|rd1[17]~81_combout\ & (\CoreALU|Add0~33\ & VCC)) # (!\RegFile|rd1[17]~81_combout\ & (!\CoreALU|Add0~33\)))) # (!\SrcB[17]~33_combout\ & ((\RegFile|rd1[17]~81_combout\ & (!\CoreALU|Add0~33\)) 
-- # (!\RegFile|rd1[17]~81_combout\ & ((\CoreALU|Add0~33\) # (GND)))))
-- \CoreALU|Add0~35\ = CARRY((\SrcB[17]~33_combout\ & (!\RegFile|rd1[17]~81_combout\ & !\CoreALU|Add0~33\)) # (!\SrcB[17]~33_combout\ & ((!\CoreALU|Add0~33\) # (!\RegFile|rd1[17]~81_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[17]~33_combout\,
	datab => \RegFile|rd1[17]~81_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~33\,
	combout => \CoreALU|Add0~34_combout\,
	cout => \CoreALU|Add0~35\);

-- Location: LCCOMB_X25_Y3_N20
\CoreALU|Mux14~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux14~3_combout\ = (\CoreALU|Add0~34_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \Control|Mux5~0_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~34_combout\,
	combout => \CoreALU|Mux14~3_combout\);

-- Location: LCCOMB_X25_Y3_N30
\CoreALU|Mux14~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux14~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~34_combout\ & (\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux14~3_combout\) # (!\CoreALU|Mux20~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Add1~34_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Mux20~2_combout\,
	datad => \CoreALU|Mux14~3_combout\,
	combout => \CoreALU|Mux14~2_combout\);

-- Location: LCCOMB_X25_Y3_N14
\CoreALU|Mux14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux14~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[17]~81_combout\ & ((\SrcB[17]~33_combout\) # (!\CoreALU|Mux14~2_combout\))) # (!\RegFile|rd1[17]~81_combout\ & (!\CoreALU|Mux14~2_combout\ & \SrcB[17]~33_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux14~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[17]~81_combout\,
	datab => \CoreALU|Mux31~0_combout\,
	datac => \CoreALU|Mux14~2_combout\,
	datad => \SrcB[17]~33_combout\,
	combout => \CoreALU|Mux14~combout\);

-- Location: FF_X27_Y3_N11
\RegFile|mem~87\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux14~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~87_q\);

-- Location: LCCOMB_X27_Y3_N10
\RegFile|rd1[17]~81\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[17]~81_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~87_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~87_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[17]~81_combout\);

-- Location: LCCOMB_X24_Y3_N4
\CoreALU|Add1~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~36_combout\ = ((\SrcB[18]~34_combout\ $ (\RegFile|rd1[18]~82_combout\ $ (\CoreALU|Add1~35\)))) # (GND)
-- \CoreALU|Add1~37\ = CARRY((\SrcB[18]~34_combout\ & (\RegFile|rd1[18]~82_combout\ & !\CoreALU|Add1~35\)) # (!\SrcB[18]~34_combout\ & ((\RegFile|rd1[18]~82_combout\) # (!\CoreALU|Add1~35\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[18]~34_combout\,
	datab => \RegFile|rd1[18]~82_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~35\,
	combout => \CoreALU|Add1~36_combout\,
	cout => \CoreALU|Add1~37\);

-- Location: LCCOMB_X22_Y3_N4
\CoreALU|Add0~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~36_combout\ = ((\RegFile|rd1[18]~82_combout\ $ (\SrcB[18]~34_combout\ $ (!\CoreALU|Add0~35\)))) # (GND)
-- \CoreALU|Add0~37\ = CARRY((\RegFile|rd1[18]~82_combout\ & ((\SrcB[18]~34_combout\) # (!\CoreALU|Add0~35\))) # (!\RegFile|rd1[18]~82_combout\ & (\SrcB[18]~34_combout\ & !\CoreALU|Add0~35\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[18]~82_combout\,
	datab => \SrcB[18]~34_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~35\,
	combout => \CoreALU|Add0~36_combout\,
	cout => \CoreALU|Add0~37\);

-- Location: LCCOMB_X21_Y3_N16
\CoreALU|Mux13~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux13~3_combout\ = (\CoreALU|Add0~36_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~36_combout\,
	combout => \CoreALU|Mux13~3_combout\);

-- Location: LCCOMB_X21_Y3_N22
\CoreALU|Mux13~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux13~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~36_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux13~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~36_combout\,
	datad => \CoreALU|Mux13~3_combout\,
	combout => \CoreALU|Mux13~2_combout\);

-- Location: LCCOMB_X21_Y3_N6
\CoreALU|Mux13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux13~combout\ = (\CoreALU|Mux13~2_combout\ & (((\SrcB[18]~34_combout\ & \RegFile|rd1[18]~82_combout\)) # (!\CoreALU|Mux31~0_combout\))) # (!\CoreALU|Mux13~2_combout\ & (\CoreALU|Mux31~0_combout\ & ((\SrcB[18]~34_combout\) # 
-- (\RegFile|rd1[18]~82_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[18]~34_combout\,
	datab => \RegFile|rd1[18]~82_combout\,
	datac => \CoreALU|Mux13~2_combout\,
	datad => \CoreALU|Mux31~0_combout\,
	combout => \CoreALU|Mux13~combout\);

-- Location: FF_X21_Y3_N7
\RegFile|mem~120\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux13~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~120_q\);

-- Location: FF_X21_Y3_N5
\RegFile|mem~56\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux13~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~56_q\);

-- Location: LCCOMB_X21_Y3_N4
\RegFile|mem~1102\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1102_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~120_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~56_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~120_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~56_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1102_combout\);

-- Location: LCCOMB_X21_Y2_N28
\RegFile|mem~216feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~216feeder_combout\ = \CoreALU|Mux13~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux13~combout\,
	combout => \RegFile|mem~216feeder_combout\);

-- Location: FF_X21_Y2_N29
\RegFile|mem~216\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~216feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~216_q\);

-- Location: FF_X21_Y2_N15
\RegFile|mem~280\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux13~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~280_q\);

-- Location: LCCOMB_X21_Y2_N14
\RegFile|mem~1101\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1101_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~280_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~216_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~216_q\,
	datac => \RegFile|mem~280_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1101_combout\);

-- Location: LCCOMB_X21_Y3_N28
\SrcB[18]~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[18]~34_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1101_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1102_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1102_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1101_combout\,
	combout => \SrcB[18]~34_combout\);

-- Location: LCCOMB_X24_Y3_N6
\CoreALU|Add1~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~38_combout\ = (\SrcB[19]~35_combout\ & ((\RegFile|rd1[19]~83_combout\ & (!\CoreALU|Add1~37\)) # (!\RegFile|rd1[19]~83_combout\ & ((\CoreALU|Add1~37\) # (GND))))) # (!\SrcB[19]~35_combout\ & ((\RegFile|rd1[19]~83_combout\ & (\CoreALU|Add1~37\ 
-- & VCC)) # (!\RegFile|rd1[19]~83_combout\ & (!\CoreALU|Add1~37\))))
-- \CoreALU|Add1~39\ = CARRY((\SrcB[19]~35_combout\ & ((!\CoreALU|Add1~37\) # (!\RegFile|rd1[19]~83_combout\))) # (!\SrcB[19]~35_combout\ & (!\RegFile|rd1[19]~83_combout\ & !\CoreALU|Add1~37\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[19]~35_combout\,
	datab => \RegFile|rd1[19]~83_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~37\,
	combout => \CoreALU|Add1~38_combout\,
	cout => \CoreALU|Add1~39\);

-- Location: LCCOMB_X22_Y3_N6
\CoreALU|Add0~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~38_combout\ = (\RegFile|rd1[19]~83_combout\ & ((\SrcB[19]~35_combout\ & (\CoreALU|Add0~37\ & VCC)) # (!\SrcB[19]~35_combout\ & (!\CoreALU|Add0~37\)))) # (!\RegFile|rd1[19]~83_combout\ & ((\SrcB[19]~35_combout\ & (!\CoreALU|Add0~37\)) # 
-- (!\SrcB[19]~35_combout\ & ((\CoreALU|Add0~37\) # (GND)))))
-- \CoreALU|Add0~39\ = CARRY((\RegFile|rd1[19]~83_combout\ & (!\SrcB[19]~35_combout\ & !\CoreALU|Add0~37\)) # (!\RegFile|rd1[19]~83_combout\ & ((!\CoreALU|Add0~37\) # (!\SrcB[19]~35_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[19]~83_combout\,
	datab => \SrcB[19]~35_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~37\,
	combout => \CoreALU|Add0~38_combout\,
	cout => \CoreALU|Add0~39\);

-- Location: LCCOMB_X21_Y3_N18
\CoreALU|Mux12~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux12~3_combout\ = (\CoreALU|Add0~38_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~38_combout\,
	combout => \CoreALU|Mux12~3_combout\);

-- Location: LCCOMB_X21_Y3_N2
\CoreALU|Mux12~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux12~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~38_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux12~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~38_combout\,
	datad => \CoreALU|Mux12~3_combout\,
	combout => \CoreALU|Mux12~2_combout\);

-- Location: LCCOMB_X21_Y3_N26
\CoreALU|Mux12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux12~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[19]~35_combout\ & ((\RegFile|rd1[19]~83_combout\) # (!\CoreALU|Mux12~2_combout\))) # (!\SrcB[19]~35_combout\ & (\RegFile|rd1[19]~83_combout\ & !\CoreALU|Mux12~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux12~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[19]~35_combout\,
	datab => \RegFile|rd1[19]~83_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux12~2_combout\,
	combout => \CoreALU|Mux12~combout\);

-- Location: FF_X21_Y3_N27
\RegFile|mem~121\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux12~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~121_q\);

-- Location: FF_X21_Y3_N13
\RegFile|mem~57\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux12~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~57_q\);

-- Location: LCCOMB_X21_Y3_N12
\RegFile|mem~1104\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1104_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~121_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~57_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~121_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~57_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1104_combout\);

-- Location: LCCOMB_X21_Y2_N16
\RegFile|mem~217feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~217feeder_combout\ = \CoreALU|Mux12~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux12~combout\,
	combout => \RegFile|mem~217feeder_combout\);

-- Location: FF_X21_Y2_N17
\RegFile|mem~217\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~217feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~217_q\);

-- Location: FF_X21_Y2_N11
\RegFile|mem~281\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux12~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~281_q\);

-- Location: LCCOMB_X21_Y2_N10
\RegFile|mem~1103\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1103_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~281_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~217_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~217_q\,
	datac => \RegFile|mem~281_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1103_combout\);

-- Location: LCCOMB_X21_Y3_N20
\SrcB[19]~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[19]~35_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1103_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1104_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~1104_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1103_combout\,
	combout => \SrcB[19]~35_combout\);

-- Location: LCCOMB_X24_Y3_N8
\CoreALU|Add1~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~40_combout\ = ((\SrcB[20]~36_combout\ $ (\RegFile|rd1[20]~84_combout\ $ (\CoreALU|Add1~39\)))) # (GND)
-- \CoreALU|Add1~41\ = CARRY((\SrcB[20]~36_combout\ & (\RegFile|rd1[20]~84_combout\ & !\CoreALU|Add1~39\)) # (!\SrcB[20]~36_combout\ & ((\RegFile|rd1[20]~84_combout\) # (!\CoreALU|Add1~39\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[20]~36_combout\,
	datab => \RegFile|rd1[20]~84_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~39\,
	combout => \CoreALU|Add1~40_combout\,
	cout => \CoreALU|Add1~41\);

-- Location: LCCOMB_X22_Y3_N8
\CoreALU|Add0~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~40_combout\ = ((\SrcB[20]~36_combout\ $ (\RegFile|rd1[20]~84_combout\ $ (!\CoreALU|Add0~39\)))) # (GND)
-- \CoreALU|Add0~41\ = CARRY((\SrcB[20]~36_combout\ & ((\RegFile|rd1[20]~84_combout\) # (!\CoreALU|Add0~39\))) # (!\SrcB[20]~36_combout\ & (\RegFile|rd1[20]~84_combout\ & !\CoreALU|Add0~39\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[20]~36_combout\,
	datab => \RegFile|rd1[20]~84_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~39\,
	combout => \CoreALU|Add0~40_combout\,
	cout => \CoreALU|Add0~41\);

-- Location: LCCOMB_X21_Y3_N0
\CoreALU|Mux11~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux11~3_combout\ = (\CoreALU|Add0~40_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \CoreALU|Add0~40_combout\,
	datad => \Control|Mux5~0_combout\,
	combout => \CoreALU|Mux11~3_combout\);

-- Location: LCCOMB_X21_Y3_N10
\CoreALU|Mux11~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux11~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~40_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux11~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~40_combout\,
	datad => \CoreALU|Mux11~3_combout\,
	combout => \CoreALU|Mux11~2_combout\);

-- Location: LCCOMB_X21_Y3_N30
\CoreALU|Mux11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux11~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[20]~84_combout\ & ((\SrcB[20]~36_combout\) # (!\CoreALU|Mux11~2_combout\))) # (!\RegFile|rd1[20]~84_combout\ & (\SrcB[20]~36_combout\ & !\CoreALU|Mux11~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux11~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[20]~84_combout\,
	datab => \SrcB[20]~36_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux11~2_combout\,
	combout => \CoreALU|Mux11~combout\);

-- Location: LCCOMB_X21_Y2_N24
\RegFile|mem~218feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~218feeder_combout\ = \CoreALU|Mux11~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux11~combout\,
	combout => \RegFile|mem~218feeder_combout\);

-- Location: FF_X21_Y2_N25
\RegFile|mem~218\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~218feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~218_q\);

-- Location: FF_X21_Y2_N27
\RegFile|mem~282\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux11~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~282_q\);

-- Location: LCCOMB_X21_Y2_N26
\RegFile|mem~1105\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1105_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~282_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~218_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \RegFile|mem~218_q\,
	datac => \RegFile|mem~282_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1105_combout\);

-- Location: FF_X21_Y3_N25
\RegFile|mem~58\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux11~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~58_q\);

-- Location: FF_X21_Y3_N31
\RegFile|mem~122\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux11~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~122_q\);

-- Location: LCCOMB_X21_Y3_N24
\RegFile|mem~1106\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1106_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~122_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~58_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux1~0_combout\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~58_q\,
	datad => \RegFile|mem~122_q\,
	combout => \RegFile|mem~1106_combout\);

-- Location: LCCOMB_X21_Y3_N8
\SrcB[20]~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[20]~36_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1105_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1106_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \InstMem|Mux4~0_combout\,
	datac => \RegFile|mem~1105_combout\,
	datad => \RegFile|mem~1106_combout\,
	combout => \SrcB[20]~36_combout\);

-- Location: LCCOMB_X24_Y3_N10
\CoreALU|Add1~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~42_combout\ = (\SrcB[21]~37_combout\ & ((\RegFile|rd1[21]~85_combout\ & (!\CoreALU|Add1~41\)) # (!\RegFile|rd1[21]~85_combout\ & ((\CoreALU|Add1~41\) # (GND))))) # (!\SrcB[21]~37_combout\ & ((\RegFile|rd1[21]~85_combout\ & (\CoreALU|Add1~41\ 
-- & VCC)) # (!\RegFile|rd1[21]~85_combout\ & (!\CoreALU|Add1~41\))))
-- \CoreALU|Add1~43\ = CARRY((\SrcB[21]~37_combout\ & ((!\CoreALU|Add1~41\) # (!\RegFile|rd1[21]~85_combout\))) # (!\SrcB[21]~37_combout\ & (!\RegFile|rd1[21]~85_combout\ & !\CoreALU|Add1~41\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[21]~37_combout\,
	datab => \RegFile|rd1[21]~85_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~41\,
	combout => \CoreALU|Add1~42_combout\,
	cout => \CoreALU|Add1~43\);

-- Location: LCCOMB_X22_Y3_N10
\CoreALU|Add0~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~42_combout\ = (\SrcB[21]~37_combout\ & ((\RegFile|rd1[21]~85_combout\ & (\CoreALU|Add0~41\ & VCC)) # (!\RegFile|rd1[21]~85_combout\ & (!\CoreALU|Add0~41\)))) # (!\SrcB[21]~37_combout\ & ((\RegFile|rd1[21]~85_combout\ & (!\CoreALU|Add0~41\)) 
-- # (!\RegFile|rd1[21]~85_combout\ & ((\CoreALU|Add0~41\) # (GND)))))
-- \CoreALU|Add0~43\ = CARRY((\SrcB[21]~37_combout\ & (!\RegFile|rd1[21]~85_combout\ & !\CoreALU|Add0~41\)) # (!\SrcB[21]~37_combout\ & ((!\CoreALU|Add0~41\) # (!\RegFile|rd1[21]~85_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[21]~37_combout\,
	datab => \RegFile|rd1[21]~85_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~41\,
	combout => \CoreALU|Add0~42_combout\,
	cout => \CoreALU|Add0~43\);

-- Location: LCCOMB_X23_Y3_N10
\CoreALU|Mux10~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux10~3_combout\ = (\CoreALU|Add0~42_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~42_combout\,
	combout => \CoreALU|Mux10~3_combout\);

-- Location: LCCOMB_X23_Y3_N2
\CoreALU|Mux10~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux10~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~42_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux10~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~42_combout\,
	datad => \CoreALU|Mux10~3_combout\,
	combout => \CoreALU|Mux10~2_combout\);

-- Location: LCCOMB_X23_Y3_N22
\CoreALU|Mux10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux10~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[21]~85_combout\ & ((\SrcB[21]~37_combout\) # (!\CoreALU|Mux10~2_combout\))) # (!\RegFile|rd1[21]~85_combout\ & (\SrcB[21]~37_combout\ & !\CoreALU|Mux10~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux10~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[21]~85_combout\,
	datab => \SrcB[21]~37_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux10~2_combout\,
	combout => \CoreALU|Mux10~combout\);

-- Location: FF_X23_Y3_N23
\RegFile|mem~123\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux10~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~123_q\);

-- Location: FF_X23_Y3_N17
\RegFile|mem~59\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux10~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~59_q\);

-- Location: LCCOMB_X23_Y3_N16
\RegFile|mem~1108\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1108_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~123_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~59_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~123_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~59_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1108_combout\);

-- Location: LCCOMB_X27_Y5_N12
\RegFile|mem~219feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~219feeder_combout\ = \CoreALU|Mux10~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux10~combout\,
	combout => \RegFile|mem~219feeder_combout\);

-- Location: FF_X27_Y5_N13
\RegFile|mem~219\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~219feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~219_q\);

-- Location: FF_X27_Y5_N23
\RegFile|mem~283\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux10~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~283_q\);

-- Location: LCCOMB_X27_Y5_N22
\RegFile|mem~1107\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1107_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~283_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~219_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~219_q\,
	datab => \InstMem|Mux3~1_combout\,
	datac => \RegFile|mem~283_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1107_combout\);

-- Location: LCCOMB_X23_Y3_N8
\SrcB[21]~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[21]~37_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1107_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1108_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1108_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1107_combout\,
	combout => \SrcB[21]~37_combout\);

-- Location: LCCOMB_X24_Y3_N12
\CoreALU|Add1~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~44_combout\ = ((\RegFile|rd1[22]~86_combout\ $ (\SrcB[22]~38_combout\ $ (\CoreALU|Add1~43\)))) # (GND)
-- \CoreALU|Add1~45\ = CARRY((\RegFile|rd1[22]~86_combout\ & ((!\CoreALU|Add1~43\) # (!\SrcB[22]~38_combout\))) # (!\RegFile|rd1[22]~86_combout\ & (!\SrcB[22]~38_combout\ & !\CoreALU|Add1~43\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[22]~86_combout\,
	datab => \SrcB[22]~38_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~43\,
	combout => \CoreALU|Add1~44_combout\,
	cout => \CoreALU|Add1~45\);

-- Location: LCCOMB_X22_Y3_N12
\CoreALU|Add0~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~44_combout\ = ((\RegFile|rd1[22]~86_combout\ $ (\SrcB[22]~38_combout\ $ (!\CoreALU|Add0~43\)))) # (GND)
-- \CoreALU|Add0~45\ = CARRY((\RegFile|rd1[22]~86_combout\ & ((\SrcB[22]~38_combout\) # (!\CoreALU|Add0~43\))) # (!\RegFile|rd1[22]~86_combout\ & (\SrcB[22]~38_combout\ & !\CoreALU|Add0~43\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[22]~86_combout\,
	datab => \SrcB[22]~38_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~43\,
	combout => \CoreALU|Add0~44_combout\,
	cout => \CoreALU|Add0~45\);

-- Location: LCCOMB_X23_Y3_N12
\CoreALU|Mux9~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux9~3_combout\ = (\CoreALU|Add0~44_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~44_combout\,
	combout => \CoreALU|Mux9~3_combout\);

-- Location: LCCOMB_X23_Y3_N18
\CoreALU|Mux9~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux9~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~44_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux9~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~44_combout\,
	datad => \CoreALU|Mux9~3_combout\,
	combout => \CoreALU|Mux9~2_combout\);

-- Location: LCCOMB_X23_Y3_N6
\CoreALU|Mux9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux9~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[22]~38_combout\ & ((\RegFile|rd1[22]~86_combout\) # (!\CoreALU|Mux9~2_combout\))) # (!\SrcB[22]~38_combout\ & (\RegFile|rd1[22]~86_combout\ & !\CoreALU|Mux9~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux9~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \SrcB[22]~38_combout\,
	datac => \RegFile|rd1[22]~86_combout\,
	datad => \CoreALU|Mux9~2_combout\,
	combout => \CoreALU|Mux9~combout\);

-- Location: FF_X27_Y3_N9
\RegFile|mem~92\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux9~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~92_q\);

-- Location: LCCOMB_X27_Y3_N8
\RegFile|rd1[22]~86\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[22]~86_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~92_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~92_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[22]~86_combout\);

-- Location: LCCOMB_X24_Y3_N14
\CoreALU|Add1~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~46_combout\ = (\SrcB[23]~39_combout\ & ((\RegFile|rd1[23]~87_combout\ & (!\CoreALU|Add1~45\)) # (!\RegFile|rd1[23]~87_combout\ & ((\CoreALU|Add1~45\) # (GND))))) # (!\SrcB[23]~39_combout\ & ((\RegFile|rd1[23]~87_combout\ & (\CoreALU|Add1~45\ 
-- & VCC)) # (!\RegFile|rd1[23]~87_combout\ & (!\CoreALU|Add1~45\))))
-- \CoreALU|Add1~47\ = CARRY((\SrcB[23]~39_combout\ & ((!\CoreALU|Add1~45\) # (!\RegFile|rd1[23]~87_combout\))) # (!\SrcB[23]~39_combout\ & (!\RegFile|rd1[23]~87_combout\ & !\CoreALU|Add1~45\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[23]~39_combout\,
	datab => \RegFile|rd1[23]~87_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~45\,
	combout => \CoreALU|Add1~46_combout\,
	cout => \CoreALU|Add1~47\);

-- Location: LCCOMB_X22_Y3_N14
\CoreALU|Add0~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~46_combout\ = (\SrcB[23]~39_combout\ & ((\RegFile|rd1[23]~87_combout\ & (\CoreALU|Add0~45\ & VCC)) # (!\RegFile|rd1[23]~87_combout\ & (!\CoreALU|Add0~45\)))) # (!\SrcB[23]~39_combout\ & ((\RegFile|rd1[23]~87_combout\ & (!\CoreALU|Add0~45\)) 
-- # (!\RegFile|rd1[23]~87_combout\ & ((\CoreALU|Add0~45\) # (GND)))))
-- \CoreALU|Add0~47\ = CARRY((\SrcB[23]~39_combout\ & (!\RegFile|rd1[23]~87_combout\ & !\CoreALU|Add0~45\)) # (!\SrcB[23]~39_combout\ & ((!\CoreALU|Add0~45\) # (!\RegFile|rd1[23]~87_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[23]~39_combout\,
	datab => \RegFile|rd1[23]~87_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~45\,
	combout => \CoreALU|Add0~46_combout\,
	cout => \CoreALU|Add0~47\);

-- Location: LCCOMB_X23_Y3_N14
\CoreALU|Mux8~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux8~3_combout\ = (\CoreALU|Add0~46_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~46_combout\,
	combout => \CoreALU|Mux8~3_combout\);

-- Location: LCCOMB_X26_Y3_N18
\CoreALU|Mux8~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux8~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~46_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux8~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~46_combout\,
	datad => \CoreALU|Mux8~3_combout\,
	combout => \CoreALU|Mux8~2_combout\);

-- Location: LCCOMB_X26_Y3_N24
\CoreALU|Mux8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux8~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[23]~87_combout\ & ((\SrcB[23]~39_combout\) # (!\CoreALU|Mux8~2_combout\))) # (!\RegFile|rd1[23]~87_combout\ & (\SrcB[23]~39_combout\ & !\CoreALU|Mux8~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux8~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[23]~87_combout\,
	datac => \SrcB[23]~39_combout\,
	datad => \CoreALU|Mux8~2_combout\,
	combout => \CoreALU|Mux8~combout\);

-- Location: FF_X26_Y3_N25
\RegFile|mem~125\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux8~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~125_q\);

-- Location: FF_X25_Y5_N19
\RegFile|mem~61\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux8~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~61_q\);

-- Location: LCCOMB_X25_Y5_N18
\RegFile|mem~1112\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1112_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~125_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~61_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~125_q\,
	datac => \RegFile|mem~61_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1112_combout\);

-- Location: LCCOMB_X26_Y5_N30
\RegFile|mem~221feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~221feeder_combout\ = \CoreALU|Mux8~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux8~combout\,
	combout => \RegFile|mem~221feeder_combout\);

-- Location: FF_X26_Y5_N31
\RegFile|mem~221\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~221feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~221_q\);

-- Location: FF_X25_Y5_N29
\RegFile|mem~285\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux8~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~285_q\);

-- Location: LCCOMB_X25_Y5_N28
\RegFile|mem~1111\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1111_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~285_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~221_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~221_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~285_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1111_combout\);

-- Location: LCCOMB_X25_Y5_N12
\SrcB[23]~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[23]~39_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1111_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1112_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1112_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1111_combout\,
	combout => \SrcB[23]~39_combout\);

-- Location: LCCOMB_X24_Y3_N16
\CoreALU|Add1~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~48_combout\ = ((\SrcB[24]~40_combout\ $ (\RegFile|rd1[24]~88_combout\ $ (\CoreALU|Add1~47\)))) # (GND)
-- \CoreALU|Add1~49\ = CARRY((\SrcB[24]~40_combout\ & (\RegFile|rd1[24]~88_combout\ & !\CoreALU|Add1~47\)) # (!\SrcB[24]~40_combout\ & ((\RegFile|rd1[24]~88_combout\) # (!\CoreALU|Add1~47\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[24]~40_combout\,
	datab => \RegFile|rd1[24]~88_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~47\,
	combout => \CoreALU|Add1~48_combout\,
	cout => \CoreALU|Add1~49\);

-- Location: LCCOMB_X22_Y3_N16
\CoreALU|Add0~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~48_combout\ = ((\SrcB[24]~40_combout\ $ (\RegFile|rd1[24]~88_combout\ $ (!\CoreALU|Add0~47\)))) # (GND)
-- \CoreALU|Add0~49\ = CARRY((\SrcB[24]~40_combout\ & ((\RegFile|rd1[24]~88_combout\) # (!\CoreALU|Add0~47\))) # (!\SrcB[24]~40_combout\ & (\RegFile|rd1[24]~88_combout\ & !\CoreALU|Add0~47\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[24]~40_combout\,
	datab => \RegFile|rd1[24]~88_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~47\,
	combout => \CoreALU|Add0~48_combout\,
	cout => \CoreALU|Add0~49\);

-- Location: LCCOMB_X23_Y3_N20
\CoreALU|Mux7~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux7~3_combout\ = (\CoreALU|Add0~48_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \CoreALU|Add0~48_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \CoreALU|Mux7~3_combout\);

-- Location: LCCOMB_X23_Y3_N4
\CoreALU|Mux7~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux7~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~48_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux7~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (((!\CoreALU|Mux20~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Add1~48_combout\,
	datac => \CoreALU|Mux20~3_combout\,
	datad => \CoreALU|Mux7~3_combout\,
	combout => \CoreALU|Mux7~2_combout\);

-- Location: LCCOMB_X26_Y3_N0
\CoreALU|Mux7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux7~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[24]~88_combout\ & ((\SrcB[24]~40_combout\) # (!\CoreALU|Mux7~2_combout\))) # (!\RegFile|rd1[24]~88_combout\ & (\SrcB[24]~40_combout\ & !\CoreALU|Mux7~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux7~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[24]~88_combout\,
	datac => \SrcB[24]~40_combout\,
	datad => \CoreALU|Mux7~2_combout\,
	combout => \CoreALU|Mux7~combout\);

-- Location: FF_X26_Y3_N1
\RegFile|mem~126\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux7~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~126_q\);

-- Location: FF_X25_Y5_N1
\RegFile|mem~62\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux7~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~62_q\);

-- Location: LCCOMB_X25_Y5_N0
\RegFile|mem~1114\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1114_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~126_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~62_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~126_q\,
	datac => \RegFile|mem~62_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1114_combout\);

-- Location: LCCOMB_X26_Y5_N16
\RegFile|mem~222feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~222feeder_combout\ = \CoreALU|Mux7~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux7~combout\,
	combout => \RegFile|mem~222feeder_combout\);

-- Location: FF_X26_Y5_N17
\RegFile|mem~222\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~222feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~222_q\);

-- Location: FF_X25_Y5_N11
\RegFile|mem~286\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux7~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~286_q\);

-- Location: LCCOMB_X25_Y5_N10
\RegFile|mem~1113\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1113_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~286_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~222_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux3~1_combout\,
	datab => \RegFile|mem~222_q\,
	datac => \RegFile|mem~286_q\,
	datad => \InstMem|Mux1~0_combout\,
	combout => \RegFile|mem~1113_combout\);

-- Location: LCCOMB_X25_Y5_N30
\SrcB[24]~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[24]~40_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1113_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1114_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1114_combout\,
	datac => \SrcB[30]~7_combout\,
	datad => \RegFile|mem~1113_combout\,
	combout => \SrcB[24]~40_combout\);

-- Location: LCCOMB_X24_Y3_N18
\CoreALU|Add1~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~50_combout\ = (\RegFile|rd1[25]~89_combout\ & ((\SrcB[25]~41_combout\ & (!\CoreALU|Add1~49\)) # (!\SrcB[25]~41_combout\ & (\CoreALU|Add1~49\ & VCC)))) # (!\RegFile|rd1[25]~89_combout\ & ((\SrcB[25]~41_combout\ & ((\CoreALU|Add1~49\) # 
-- (GND))) # (!\SrcB[25]~41_combout\ & (!\CoreALU|Add1~49\))))
-- \CoreALU|Add1~51\ = CARRY((\RegFile|rd1[25]~89_combout\ & (\SrcB[25]~41_combout\ & !\CoreALU|Add1~49\)) # (!\RegFile|rd1[25]~89_combout\ & ((\SrcB[25]~41_combout\) # (!\CoreALU|Add1~49\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[25]~89_combout\,
	datab => \SrcB[25]~41_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~49\,
	combout => \CoreALU|Add1~50_combout\,
	cout => \CoreALU|Add1~51\);

-- Location: LCCOMB_X22_Y3_N18
\CoreALU|Add0~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~50_combout\ = (\SrcB[25]~41_combout\ & ((\RegFile|rd1[25]~89_combout\ & (\CoreALU|Add0~49\ & VCC)) # (!\RegFile|rd1[25]~89_combout\ & (!\CoreALU|Add0~49\)))) # (!\SrcB[25]~41_combout\ & ((\RegFile|rd1[25]~89_combout\ & (!\CoreALU|Add0~49\)) 
-- # (!\RegFile|rd1[25]~89_combout\ & ((\CoreALU|Add0~49\) # (GND)))))
-- \CoreALU|Add0~51\ = CARRY((\SrcB[25]~41_combout\ & (!\RegFile|rd1[25]~89_combout\ & !\CoreALU|Add0~49\)) # (!\SrcB[25]~41_combout\ & ((!\CoreALU|Add0~49\) # (!\RegFile|rd1[25]~89_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[25]~41_combout\,
	datab => \RegFile|rd1[25]~89_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~49\,
	combout => \CoreALU|Add0~50_combout\,
	cout => \CoreALU|Add0~51\);

-- Location: LCCOMB_X26_Y3_N12
\CoreALU|Mux6~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux6~3_combout\ = (\CoreALU|Add0~50_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~50_combout\,
	combout => \CoreALU|Mux6~3_combout\);

-- Location: LCCOMB_X26_Y3_N28
\CoreALU|Mux6~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux6~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~50_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux6~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~50_combout\,
	datad => \CoreALU|Mux6~3_combout\,
	combout => \CoreALU|Mux6~2_combout\);

-- Location: LCCOMB_X26_Y3_N14
\CoreALU|Mux6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux6~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[25]~89_combout\ & ((\SrcB[25]~41_combout\) # (!\CoreALU|Mux6~2_combout\))) # (!\RegFile|rd1[25]~89_combout\ & (\SrcB[25]~41_combout\ & !\CoreALU|Mux6~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux6~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[25]~89_combout\,
	datac => \SrcB[25]~41_combout\,
	datad => \CoreALU|Mux6~2_combout\,
	combout => \CoreALU|Mux6~combout\);

-- Location: FF_X27_Y3_N31
\RegFile|mem~95\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux6~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~95_q\);

-- Location: LCCOMB_X27_Y3_N30
\RegFile|rd1[25]~89\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[25]~89_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~95_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~95_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[25]~89_combout\);

-- Location: LCCOMB_X24_Y3_N20
\CoreALU|Add1~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~52_combout\ = ((\RegFile|rd1[26]~90_combout\ $ (\SrcB[26]~42_combout\ $ (\CoreALU|Add1~51\)))) # (GND)
-- \CoreALU|Add1~53\ = CARRY((\RegFile|rd1[26]~90_combout\ & ((!\CoreALU|Add1~51\) # (!\SrcB[26]~42_combout\))) # (!\RegFile|rd1[26]~90_combout\ & (!\SrcB[26]~42_combout\ & !\CoreALU|Add1~51\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[26]~90_combout\,
	datab => \SrcB[26]~42_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~51\,
	combout => \CoreALU|Add1~52_combout\,
	cout => \CoreALU|Add1~53\);

-- Location: LCCOMB_X22_Y3_N20
\CoreALU|Add0~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~52_combout\ = ((\RegFile|rd1[26]~90_combout\ $ (\SrcB[26]~42_combout\ $ (!\CoreALU|Add0~51\)))) # (GND)
-- \CoreALU|Add0~53\ = CARRY((\RegFile|rd1[26]~90_combout\ & ((\SrcB[26]~42_combout\) # (!\CoreALU|Add0~51\))) # (!\RegFile|rd1[26]~90_combout\ & (\SrcB[26]~42_combout\ & !\CoreALU|Add0~51\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[26]~90_combout\,
	datab => \SrcB[26]~42_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~51\,
	combout => \CoreALU|Add0~52_combout\,
	cout => \CoreALU|Add0~53\);

-- Location: LCCOMB_X21_Y3_N14
\CoreALU|Mux5~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux5~3_combout\ = (\CoreALU|Add0~52_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \CoreALU|Add0~52_combout\,
	datad => \Control|Mux5~0_combout\,
	combout => \CoreALU|Mux5~3_combout\);

-- Location: LCCOMB_X26_Y3_N20
\CoreALU|Mux5~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux5~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~52_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux5~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~52_combout\,
	datad => \CoreALU|Mux5~3_combout\,
	combout => \CoreALU|Mux5~2_combout\);

-- Location: LCCOMB_X26_Y3_N6
\CoreALU|Mux5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux5~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[26]~90_combout\ & ((\SrcB[26]~42_combout\) # (!\CoreALU|Mux5~2_combout\))) # (!\RegFile|rd1[26]~90_combout\ & (\SrcB[26]~42_combout\ & !\CoreALU|Mux5~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux5~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[26]~90_combout\,
	datac => \SrcB[26]~42_combout\,
	datad => \CoreALU|Mux5~2_combout\,
	combout => \CoreALU|Mux5~combout\);

-- Location: FF_X27_Y3_N21
\RegFile|mem~96\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux5~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~96_q\);

-- Location: LCCOMB_X27_Y3_N20
\RegFile|rd1[26]~90\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[26]~90_combout\ = (!\PC_Reg|PC_out\(7) & (\InstMem|Mux14~2_combout\ & (\RegFile|mem~96_q\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \InstMem|Mux14~2_combout\,
	datac => \RegFile|mem~96_q\,
	datad => \PC_Reg|PC_out\(6),
	combout => \RegFile|rd1[26]~90_combout\);

-- Location: LCCOMB_X24_Y3_N22
\CoreALU|Add1~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~54_combout\ = (\SrcB[27]~43_combout\ & ((\RegFile|rd1[27]~91_combout\ & (!\CoreALU|Add1~53\)) # (!\RegFile|rd1[27]~91_combout\ & ((\CoreALU|Add1~53\) # (GND))))) # (!\SrcB[27]~43_combout\ & ((\RegFile|rd1[27]~91_combout\ & (\CoreALU|Add1~53\ 
-- & VCC)) # (!\RegFile|rd1[27]~91_combout\ & (!\CoreALU|Add1~53\))))
-- \CoreALU|Add1~55\ = CARRY((\SrcB[27]~43_combout\ & ((!\CoreALU|Add1~53\) # (!\RegFile|rd1[27]~91_combout\))) # (!\SrcB[27]~43_combout\ & (!\RegFile|rd1[27]~91_combout\ & !\CoreALU|Add1~53\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[27]~43_combout\,
	datab => \RegFile|rd1[27]~91_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~53\,
	combout => \CoreALU|Add1~54_combout\,
	cout => \CoreALU|Add1~55\);

-- Location: LCCOMB_X22_Y3_N22
\CoreALU|Add0~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~54_combout\ = (\SrcB[27]~43_combout\ & ((\RegFile|rd1[27]~91_combout\ & (\CoreALU|Add0~53\ & VCC)) # (!\RegFile|rd1[27]~91_combout\ & (!\CoreALU|Add0~53\)))) # (!\SrcB[27]~43_combout\ & ((\RegFile|rd1[27]~91_combout\ & (!\CoreALU|Add0~53\)) 
-- # (!\RegFile|rd1[27]~91_combout\ & ((\CoreALU|Add0~53\) # (GND)))))
-- \CoreALU|Add0~55\ = CARRY((\SrcB[27]~43_combout\ & (!\RegFile|rd1[27]~91_combout\ & !\CoreALU|Add0~53\)) # (!\SrcB[27]~43_combout\ & ((!\CoreALU|Add0~53\) # (!\RegFile|rd1[27]~91_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[27]~43_combout\,
	datab => \RegFile|rd1[27]~91_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~53\,
	combout => \CoreALU|Add0~54_combout\,
	cout => \CoreALU|Add0~55\);

-- Location: LCCOMB_X26_Y3_N10
\CoreALU|Mux4~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux4~3_combout\ = (\CoreALU|Add0~54_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~54_combout\,
	combout => \CoreALU|Mux4~3_combout\);

-- Location: LCCOMB_X26_Y3_N16
\CoreALU|Mux4~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux4~2_combout\ = (\CoreALU|Mux20~2_combout\ & ((\CoreALU|Mux20~3_combout\ & (\CoreALU|Add1~54_combout\)) # (!\CoreALU|Mux20~3_combout\ & ((\CoreALU|Mux4~3_combout\))))) # (!\CoreALU|Mux20~2_combout\ & (!\CoreALU|Mux20~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~2_combout\,
	datab => \CoreALU|Mux20~3_combout\,
	datac => \CoreALU|Add1~54_combout\,
	datad => \CoreALU|Mux4~3_combout\,
	combout => \CoreALU|Mux4~2_combout\);

-- Location: LCCOMB_X26_Y3_N30
\CoreALU|Mux4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux4~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[27]~91_combout\ & ((\SrcB[27]~43_combout\) # (!\CoreALU|Mux4~2_combout\))) # (!\RegFile|rd1[27]~91_combout\ & (\SrcB[27]~43_combout\ & !\CoreALU|Mux4~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux4~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[27]~91_combout\,
	datac => \SrcB[27]~43_combout\,
	datad => \CoreALU|Mux4~2_combout\,
	combout => \CoreALU|Mux4~combout\);

-- Location: LCCOMB_X27_Y3_N16
\RegFile|mem~225feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~225feeder_combout\ = \CoreALU|Mux4~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \CoreALU|Mux4~combout\,
	combout => \RegFile|mem~225feeder_combout\);

-- Location: FF_X27_Y3_N17
\RegFile|mem~225\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~225feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~225_q\);

-- Location: FF_X21_Y1_N21
\RegFile|mem~289\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux4~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~289_q\);

-- Location: LCCOMB_X21_Y1_N20
\RegFile|mem~1119\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1119_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~289_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~225_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~225_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~289_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1119_combout\);

-- Location: FF_X26_Y3_N31
\RegFile|mem~129\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux4~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~129_q\);

-- Location: FF_X21_Y1_N11
\RegFile|mem~65\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux4~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~65_q\);

-- Location: LCCOMB_X21_Y1_N10
\RegFile|mem~1120\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1120_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~129_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~65_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~129_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~65_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1120_combout\);

-- Location: LCCOMB_X21_Y1_N8
\SrcB[27]~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[27]~43_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1119_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1120_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \RegFile|mem~1119_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \RegFile|mem~1120_combout\,
	combout => \SrcB[27]~43_combout\);

-- Location: LCCOMB_X24_Y3_N24
\CoreALU|Add1~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~56_combout\ = ((\SrcB[28]~44_combout\ $ (\RegFile|rd1[28]~92_combout\ $ (\CoreALU|Add1~55\)))) # (GND)
-- \CoreALU|Add1~57\ = CARRY((\SrcB[28]~44_combout\ & (\RegFile|rd1[28]~92_combout\ & !\CoreALU|Add1~55\)) # (!\SrcB[28]~44_combout\ & ((\RegFile|rd1[28]~92_combout\) # (!\CoreALU|Add1~55\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[28]~44_combout\,
	datab => \RegFile|rd1[28]~92_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~55\,
	combout => \CoreALU|Add1~56_combout\,
	cout => \CoreALU|Add1~57\);

-- Location: LCCOMB_X22_Y3_N24
\CoreALU|Add0~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~56_combout\ = ((\SrcB[28]~44_combout\ $ (\RegFile|rd1[28]~92_combout\ $ (!\CoreALU|Add0~55\)))) # (GND)
-- \CoreALU|Add0~57\ = CARRY((\SrcB[28]~44_combout\ & ((\RegFile|rd1[28]~92_combout\) # (!\CoreALU|Add0~55\))) # (!\SrcB[28]~44_combout\ & (\RegFile|rd1[28]~92_combout\ & !\CoreALU|Add0~55\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[28]~44_combout\,
	datab => \RegFile|rd1[28]~92_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~55\,
	combout => \CoreALU|Add0~56_combout\,
	cout => \CoreALU|Add0~57\);

-- Location: LCCOMB_X25_Y3_N22
\CoreALU|Mux3~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux3~3_combout\ = (\CoreALU|Add0~56_combout\ & (((\InstMem|Mux8~0_combout\) # (!\Control|Mux5~0_combout\)) # (!\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux14~3_combout\,
	datab => \Control|Mux5~0_combout\,
	datac => \InstMem|Mux8~0_combout\,
	datad => \CoreALU|Add0~56_combout\,
	combout => \CoreALU|Mux3~3_combout\);

-- Location: LCCOMB_X24_Y1_N0
\CoreALU|Mux3~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux3~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~56_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux3~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~56_combout\,
	datad => \CoreALU|Mux3~3_combout\,
	combout => \CoreALU|Mux3~2_combout\);

-- Location: LCCOMB_X24_Y1_N18
\CoreALU|Mux3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux3~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[28]~92_combout\ & ((\SrcB[28]~44_combout\) # (!\CoreALU|Mux3~2_combout\))) # (!\RegFile|rd1[28]~92_combout\ & (\SrcB[28]~44_combout\ & !\CoreALU|Mux3~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux3~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[28]~92_combout\,
	datab => \SrcB[28]~44_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux3~2_combout\,
	combout => \CoreALU|Mux3~combout\);

-- Location: FF_X24_Y1_N19
\RegFile|mem~130\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux3~combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~130_q\);

-- Location: FF_X21_Y1_N5
\RegFile|mem~66\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux3~combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~66_q\);

-- Location: LCCOMB_X21_Y1_N4
\RegFile|mem~1122\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1122_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~130_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~66_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~130_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~66_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1122_combout\);

-- Location: FF_X24_Y1_N29
\RegFile|mem~226\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux3~combout\,
	sload => VCC,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~226_q\);

-- Location: FF_X21_Y1_N23
\RegFile|mem~290\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux3~combout\,
	sload => VCC,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~290_q\);

-- Location: LCCOMB_X21_Y1_N22
\RegFile|mem~1121\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1121_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & ((\RegFile|mem~290_q\))) # (!\InstMem|Mux3~1_combout\ & (\RegFile|mem~226_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~226_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~290_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1121_combout\);

-- Location: LCCOMB_X21_Y1_N18
\SrcB[28]~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[28]~44_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1121_combout\))) # (!\InstMem|Mux4~0_combout\ & (\RegFile|mem~1122_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux4~0_combout\,
	datab => \RegFile|mem~1122_combout\,
	datac => \RegFile|mem~1121_combout\,
	datad => \SrcB[30]~7_combout\,
	combout => \SrcB[28]~44_combout\);

-- Location: LCCOMB_X24_Y3_N26
\CoreALU|Add1~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~58_combout\ = (\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\ & (!\CoreALU|Add1~57\)) # (!\SrcB[29]~45_combout\ & (\CoreALU|Add1~57\ & VCC)))) # (!\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\ & ((\CoreALU|Add1~57\) # 
-- (GND))) # (!\SrcB[29]~45_combout\ & (!\CoreALU|Add1~57\))))
-- \CoreALU|Add1~59\ = CARRY((\RegFile|rd1[29]~93_combout\ & (\SrcB[29]~45_combout\ & !\CoreALU|Add1~57\)) # (!\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\) # (!\CoreALU|Add1~57\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[29]~93_combout\,
	datab => \SrcB[29]~45_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~57\,
	combout => \CoreALU|Add1~58_combout\,
	cout => \CoreALU|Add1~59\);

-- Location: LCCOMB_X22_Y3_N26
\CoreALU|Add0~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~58_combout\ = (\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\ & (\CoreALU|Add0~57\ & VCC)) # (!\SrcB[29]~45_combout\ & (!\CoreALU|Add0~57\)))) # (!\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\ & (!\CoreALU|Add0~57\)) # 
-- (!\SrcB[29]~45_combout\ & ((\CoreALU|Add0~57\) # (GND)))))
-- \CoreALU|Add0~59\ = CARRY((\RegFile|rd1[29]~93_combout\ & (!\SrcB[29]~45_combout\ & !\CoreALU|Add0~57\)) # (!\RegFile|rd1[29]~93_combout\ & ((!\CoreALU|Add0~57\) # (!\SrcB[29]~45_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[29]~93_combout\,
	datab => \SrcB[29]~45_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~57\,
	combout => \CoreALU|Add0~58_combout\,
	cout => \CoreALU|Add0~59\);

-- Location: LCCOMB_X23_Y3_N26
\CoreALU|Mux2~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux2~3_combout\ = (\CoreALU|Add0~58_combout\ & (((\InstMem|Mux8~0_combout\) # (!\InstMem|Mux14~3_combout\)) # (!\Control|Mux5~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Control|Mux5~0_combout\,
	datab => \InstMem|Mux8~0_combout\,
	datac => \CoreALU|Add0~58_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \CoreALU|Mux2~3_combout\);

-- Location: LCCOMB_X24_Y1_N20
\CoreALU|Mux2~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux2~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~58_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux2~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~58_combout\,
	datad => \CoreALU|Mux2~3_combout\,
	combout => \CoreALU|Mux2~2_combout\);

-- Location: LCCOMB_X24_Y1_N26
\CoreALU|Mux2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux2~combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[29]~93_combout\ & ((\SrcB[29]~45_combout\) # (!\CoreALU|Mux2~2_combout\))) # (!\RegFile|rd1[29]~93_combout\ & (\SrcB[29]~45_combout\ & !\CoreALU|Mux2~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[29]~93_combout\,
	datac => \SrcB[29]~45_combout\,
	datad => \CoreALU|Mux2~2_combout\,
	combout => \CoreALU|Mux2~combout\);

-- Location: FF_X26_Y1_N5
\RegFile|mem~99\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux2~combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~99_q\);

-- Location: LCCOMB_X26_Y5_N10
\RegFile|rd1[29]~93\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[29]~93_combout\ = (!\PC_Reg|PC_out\(7) & (\RegFile|mem~99_q\ & (!\PC_Reg|PC_out\(6) & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(7),
	datab => \RegFile|mem~99_q\,
	datac => \PC_Reg|PC_out\(6),
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[29]~93_combout\);

-- Location: LCCOMB_X24_Y3_N28
\CoreALU|Add1~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~60_combout\ = ((\SrcB[30]~46_combout\ $ (\RegFile|rd1[30]~94_combout\ $ (\CoreALU|Add1~59\)))) # (GND)
-- \CoreALU|Add1~61\ = CARRY((\SrcB[30]~46_combout\ & (\RegFile|rd1[30]~94_combout\ & !\CoreALU|Add1~59\)) # (!\SrcB[30]~46_combout\ & ((\RegFile|rd1[30]~94_combout\) # (!\CoreALU|Add1~59\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~46_combout\,
	datab => \RegFile|rd1[30]~94_combout\,
	datad => VCC,
	cin => \CoreALU|Add1~59\,
	combout => \CoreALU|Add1~60_combout\,
	cout => \CoreALU|Add1~61\);

-- Location: LCCOMB_X22_Y3_N28
\CoreALU|Add0~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~60_combout\ = ((\RegFile|rd1[30]~94_combout\ $ (\SrcB[30]~46_combout\ $ (!\CoreALU|Add0~59\)))) # (GND)
-- \CoreALU|Add0~61\ = CARRY((\RegFile|rd1[30]~94_combout\ & ((\SrcB[30]~46_combout\) # (!\CoreALU|Add0~59\))) # (!\RegFile|rd1[30]~94_combout\ & (\SrcB[30]~46_combout\ & !\CoreALU|Add0~59\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|rd1[30]~94_combout\,
	datab => \SrcB[30]~46_combout\,
	datad => VCC,
	cin => \CoreALU|Add0~59\,
	combout => \CoreALU|Add0~60_combout\,
	cout => \CoreALU|Add0~61\);

-- Location: LCCOMB_X23_Y3_N0
\CoreALU|Mux1~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux1~3_combout\ = (\CoreALU|Add0~60_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~60_combout\,
	combout => \CoreALU|Mux1~3_combout\);

-- Location: LCCOMB_X24_Y1_N24
\CoreALU|Mux1~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux1~2_combout\ = (\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & (\CoreALU|Add1~60_combout\))) # (!\CoreALU|Mux20~3_combout\ & (((\CoreALU|Mux1~3_combout\)) # (!\CoreALU|Mux20~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~60_combout\,
	datad => \CoreALU|Mux1~3_combout\,
	combout => \CoreALU|Mux1~2_combout\);

-- Location: LCCOMB_X24_Y1_N30
\CoreALU|Mux1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux1~combout\ = (\CoreALU|Mux31~0_combout\ & ((\SrcB[30]~46_combout\ & ((\RegFile|rd1[30]~94_combout\) # (!\CoreALU|Mux1~2_combout\))) # (!\SrcB[30]~46_combout\ & (\RegFile|rd1[30]~94_combout\ & !\CoreALU|Mux1~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((\CoreALU|Mux1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~46_combout\,
	datab => \RegFile|rd1[30]~94_combout\,
	datac => \CoreALU|Mux31~0_combout\,
	datad => \CoreALU|Mux1~2_combout\,
	combout => \CoreALU|Mux1~combout\);

-- Location: FF_X23_Y2_N15
\RegFile|mem~101\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux0~3_combout\,
	sload => VCC,
	ena => \RegFile|mem~1130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~101_q\);

-- Location: LCCOMB_X23_Y2_N14
\RegFile|rd1[31]~95\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|rd1[31]~95_combout\ = (!\PC_Reg|PC_out\(6) & (!\PC_Reg|PC_out\(7) & (\RegFile|mem~101_q\ & \InstMem|Mux14~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \PC_Reg|PC_out\(7),
	datac => \RegFile|mem~101_q\,
	datad => \InstMem|Mux14~2_combout\,
	combout => \RegFile|rd1[31]~95_combout\);

-- Location: LCCOMB_X22_Y1_N8
\RegFile|mem~293feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~293feeder_combout\ = \CoreALU|Mux0~3_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux0~3_combout\,
	combout => \RegFile|mem~293feeder_combout\);

-- Location: FF_X22_Y1_N9
\RegFile|mem~293\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~293feeder_combout\,
	ena => \RegFile|mem~1133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~293_q\);

-- Location: LCCOMB_X24_Y1_N22
\RegFile|mem~229feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~229feeder_combout\ = \CoreALU|Mux0~3_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CoreALU|Mux0~3_combout\,
	combout => \RegFile|mem~229feeder_combout\);

-- Location: FF_X24_Y1_N23
\RegFile|mem~229\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \RegFile|mem~229feeder_combout\,
	ena => \RegFile|mem~1132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~229_q\);

-- Location: LCCOMB_X21_Y1_N28
\RegFile|mem~1127\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1127_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~293_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~229_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~293_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \InstMem|Mux3~1_combout\,
	datad => \RegFile|mem~229_q\,
	combout => \RegFile|mem~1127_combout\);

-- Location: FF_X24_Y1_N5
\RegFile|mem~133\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \CoreALU|Mux0~3_combout\,
	ena => \RegFile|mem~1131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~133_q\);

-- Location: FF_X21_Y1_N7
\RegFile|mem~69\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \CoreALU|Mux0~3_combout\,
	sload => VCC,
	ena => \RegFile|mem~1134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegFile|mem~69_q\);

-- Location: LCCOMB_X21_Y1_N6
\RegFile|mem~1128\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \RegFile|mem~1128_combout\ = (!\InstMem|Mux1~0_combout\ & ((\InstMem|Mux3~1_combout\ & (\RegFile|mem~133_q\)) # (!\InstMem|Mux3~1_combout\ & ((\RegFile|mem~69_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RegFile|mem~133_q\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \RegFile|mem~69_q\,
	datad => \InstMem|Mux3~1_combout\,
	combout => \RegFile|mem~1128_combout\);

-- Location: LCCOMB_X21_Y1_N24
\SrcB[31]~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SrcB[31]~47_combout\ = (\SrcB[30]~7_combout\ & ((\InstMem|Mux4~0_combout\ & (\RegFile|mem~1127_combout\)) # (!\InstMem|Mux4~0_combout\ & ((\RegFile|mem~1128_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SrcB[30]~7_combout\,
	datab => \RegFile|mem~1127_combout\,
	datac => \InstMem|Mux4~0_combout\,
	datad => \RegFile|mem~1128_combout\,
	combout => \SrcB[31]~47_combout\);

-- Location: LCCOMB_X24_Y3_N30
\CoreALU|Add1~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add1~62_combout\ = \SrcB[31]~47_combout\ $ (\CoreALU|Add1~61\ $ (!\RegFile|rd1[31]~95_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SrcB[31]~47_combout\,
	datad => \RegFile|rd1[31]~95_combout\,
	cin => \CoreALU|Add1~61\,
	combout => \CoreALU|Add1~62_combout\);

-- Location: LCCOMB_X22_Y3_N30
\CoreALU|Add0~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Add0~62_combout\ = \RegFile|rd1[31]~95_combout\ $ (\CoreALU|Add0~61\ $ (\SrcB[31]~47_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \RegFile|rd1[31]~95_combout\,
	datad => \SrcB[31]~47_combout\,
	cin => \CoreALU|Add0~61\,
	combout => \CoreALU|Add0~62_combout\);

-- Location: LCCOMB_X23_Y3_N30
\CoreALU|Mux0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux0~4_combout\ = (\CoreALU|Add0~62_combout\ & ((\InstMem|Mux8~0_combout\) # ((!\Control|Mux5~0_combout\) # (!\InstMem|Mux14~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux8~0_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \Control|Mux5~0_combout\,
	datad => \CoreALU|Add0~62_combout\,
	combout => \CoreALU|Mux0~4_combout\);

-- Location: LCCOMB_X24_Y1_N10
\CoreALU|Mux0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux0~2_combout\ = (\CoreALU|Mux20~3_combout\ & (((!\CoreALU|Add1~62_combout\)) # (!\CoreALU|Mux20~2_combout\))) # (!\CoreALU|Mux20~3_combout\ & (\CoreALU|Mux20~2_combout\ & ((!\CoreALU|Mux0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101001101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux20~3_combout\,
	datab => \CoreALU|Mux20~2_combout\,
	datac => \CoreALU|Add1~62_combout\,
	datad => \CoreALU|Mux0~4_combout\,
	combout => \CoreALU|Mux0~2_combout\);

-- Location: LCCOMB_X24_Y1_N4
\CoreALU|Mux0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \CoreALU|Mux0~3_combout\ = (\CoreALU|Mux31~0_combout\ & ((\RegFile|rd1[31]~95_combout\ & ((\SrcB[31]~47_combout\) # (\CoreALU|Mux0~2_combout\))) # (!\RegFile|rd1[31]~95_combout\ & (\SrcB[31]~47_combout\ & \CoreALU|Mux0~2_combout\)))) # 
-- (!\CoreALU|Mux31~0_combout\ & (((!\CoreALU|Mux0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100011010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux31~0_combout\,
	datab => \RegFile|rd1[31]~95_combout\,
	datac => \SrcB[31]~47_combout\,
	datad => \CoreALU|Mux0~2_combout\,
	combout => \CoreALU|Mux0~3_combout\);

-- Location: LCCOMB_X24_Y1_N2
\PCSrc~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~2_combout\ = (!\CoreALU|Mux26~combout\ & (!\CoreALU|Mux25~combout\ & (!\CoreALU|Mux24~combout\ & !\CoreALU|Mux23~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux26~combout\,
	datab => \CoreALU|Mux25~combout\,
	datac => \CoreALU|Mux24~combout\,
	datad => \CoreALU|Mux23~combout\,
	combout => \PCSrc~2_combout\);

-- Location: LCCOMB_X24_Y1_N8
\PCSrc~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~3_combout\ = (!\CoreALU|Mux21~combout\ & (!\CoreALU|Mux20~combout\ & (!\CoreALU|Mux22~combout\ & \PCSrc~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux21~combout\,
	datab => \CoreALU|Mux20~combout\,
	datac => \CoreALU|Mux22~combout\,
	datad => \PCSrc~2_combout\,
	combout => \PCSrc~3_combout\);

-- Location: LCCOMB_X24_Y1_N16
\PCSrc~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~1_combout\ = (!\CoreALU|Mux29~combout\ & (!\CoreALU|Mux30~combout\ & (!\CoreALU|Mux28~combout\ & !\CoreALU|Mux27~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux29~combout\,
	datab => \CoreALU|Mux30~combout\,
	datac => \CoreALU|Mux28~combout\,
	datad => \CoreALU|Mux27~combout\,
	combout => \PCSrc~1_combout\);

-- Location: LCCOMB_X24_Y1_N28
\PCSrc~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~4_combout\ = (!\CoreALU|Mux18~combout\ & (\PCSrc~3_combout\ & (!\CoreALU|Mux3~combout\ & \PCSrc~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux18~combout\,
	datab => \PCSrc~3_combout\,
	datac => \CoreALU|Mux3~combout\,
	datad => \PCSrc~1_combout\,
	combout => \PCSrc~4_combout\);

-- Location: LCCOMB_X24_Y1_N6
\PCSrc~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~5_combout\ = (!\CoreALU|Mux1~combout\ & (!\CoreALU|Mux0~3_combout\ & (!\CoreALU|Mux2~combout\ & \PCSrc~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux1~combout\,
	datab => \CoreALU|Mux0~3_combout\,
	datac => \CoreALU|Mux2~combout\,
	datad => \PCSrc~4_combout\,
	combout => \PCSrc~5_combout\);

-- Location: LCCOMB_X26_Y3_N22
\PCSrc~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~8_combout\ = (!\CoreALU|Mux14~combout\ & (!\CoreALU|Mux15~combout\ & (!\CoreALU|Mux13~combout\ & !\CoreALU|Mux12~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux14~combout\,
	datab => \CoreALU|Mux15~combout\,
	datac => \CoreALU|Mux13~combout\,
	datad => \CoreALU|Mux12~combout\,
	combout => \PCSrc~8_combout\);

-- Location: LCCOMB_X26_Y3_N8
\PCSrc~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~7_combout\ = (!\CoreALU|Mux9~combout\ & (!\CoreALU|Mux11~combout\ & (!\CoreALU|Mux10~combout\ & !\CoreALU|Mux8~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux9~combout\,
	datab => \CoreALU|Mux11~combout\,
	datac => \CoreALU|Mux10~combout\,
	datad => \CoreALU|Mux8~combout\,
	combout => \PCSrc~7_combout\);

-- Location: LCCOMB_X26_Y3_N4
\PCSrc~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~9_combout\ = (!\CoreALU|Mux16~combout\ & (!\CoreALU|Mux17~combout\ & !\CoreALU|Mux19~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux16~combout\,
	datac => \CoreALU|Mux17~combout\,
	datad => \CoreALU|Mux19~combout\,
	combout => \PCSrc~9_combout\);

-- Location: LCCOMB_X26_Y3_N2
\PCSrc~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~6_combout\ = (!\CoreALU|Mux4~combout\ & (!\CoreALU|Mux7~combout\ & (!\CoreALU|Mux6~combout\ & !\CoreALU|Mux5~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CoreALU|Mux4~combout\,
	datab => \CoreALU|Mux7~combout\,
	datac => \CoreALU|Mux6~combout\,
	datad => \CoreALU|Mux5~combout\,
	combout => \PCSrc~6_combout\);

-- Location: LCCOMB_X26_Y3_N26
\PCSrc~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~10_combout\ = (\PCSrc~8_combout\ & (\PCSrc~7_combout\ & (\PCSrc~9_combout\ & \PCSrc~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PCSrc~8_combout\,
	datab => \PCSrc~7_combout\,
	datac => \PCSrc~9_combout\,
	datad => \PCSrc~6_combout\,
	combout => \PCSrc~10_combout\);

-- Location: LCCOMB_X25_Y1_N30
\PCSrc~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PCSrc~11_combout\ = (\PCSrc~0_combout\ & (!\CoreALU|Mux31~3_combout\ & (\PCSrc~5_combout\ & \PCSrc~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PCSrc~0_combout\,
	datab => \CoreALU|Mux31~3_combout\,
	datac => \PCSrc~5_combout\,
	datad => \PCSrc~10_combout\,
	combout => \PCSrc~11_combout\);

-- Location: FF_X25_Y2_N11
\PC_Reg|PC_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[6]~38_combout\,
	asdata => \BranchTarget[6]~12_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(6));

-- Location: LCCOMB_X23_Y2_N18
\ExtUnit|Mux28~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux28~2_combout\ = (\InstMem|Mux13~1_combout\ & (((\InstMem|Mux15~1_combout\ & \InstMem|Mux14~3_combout\)))) # (!\InstMem|Mux13~1_combout\ & (\InstMem|Mux1~0_combout\ & (!\InstMem|Mux15~1_combout\ & !\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux13~1_combout\,
	datab => \InstMem|Mux1~0_combout\,
	datac => \InstMem|Mux15~1_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \ExtUnit|Mux28~2_combout\);

-- Location: LCCOMB_X23_Y2_N6
\ExtUnit|Mux28~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux28~3_combout\ = (!\PC_Reg|PC_out\(6) & (!\InstMem|Mux17~2_combout\ & (!\PC_Reg|PC_out\(7) & \ExtUnit|Mux28~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \InstMem|Mux17~2_combout\,
	datac => \PC_Reg|PC_out\(7),
	datad => \ExtUnit|Mux28~2_combout\,
	combout => \ExtUnit|Mux28~3_combout\);

-- Location: LCCOMB_X26_Y2_N0
\BranchTarget[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[0]~0_combout\ = (\ExtUnit|Mux31~1_combout\ & (\PC_Reg|PC_out\(0) $ (VCC))) # (!\ExtUnit|Mux31~1_combout\ & (\PC_Reg|PC_out\(0) & VCC))
-- \BranchTarget[0]~1\ = CARRY((\ExtUnit|Mux31~1_combout\ & \PC_Reg|PC_out\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux31~1_combout\,
	datab => \PC_Reg|PC_out\(0),
	datad => VCC,
	combout => \BranchTarget[0]~0_combout\,
	cout => \BranchTarget[0]~1\);

-- Location: LCCOMB_X26_Y2_N2
\BranchTarget[1]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[1]~2_combout\ = (\ExtUnit|Mux30~12_combout\ & ((\PC_Reg|PC_out\(1) & (\BranchTarget[0]~1\ & VCC)) # (!\PC_Reg|PC_out\(1) & (!\BranchTarget[0]~1\)))) # (!\ExtUnit|Mux30~12_combout\ & ((\PC_Reg|PC_out\(1) & (!\BranchTarget[0]~1\)) # 
-- (!\PC_Reg|PC_out\(1) & ((\BranchTarget[0]~1\) # (GND)))))
-- \BranchTarget[1]~3\ = CARRY((\ExtUnit|Mux30~12_combout\ & (!\PC_Reg|PC_out\(1) & !\BranchTarget[0]~1\)) # (!\ExtUnit|Mux30~12_combout\ & ((!\BranchTarget[0]~1\) # (!\PC_Reg|PC_out\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux30~12_combout\,
	datab => \PC_Reg|PC_out\(1),
	datad => VCC,
	cin => \BranchTarget[0]~1\,
	combout => \BranchTarget[1]~2_combout\,
	cout => \BranchTarget[1]~3\);

-- Location: FF_X26_Y2_N3
\PC_Reg|PC_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \BranchTarget[1]~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(1));

-- Location: LCCOMB_X26_Y2_N4
\BranchTarget[2]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[2]~4_combout\ = ((\PC_Reg|PC_out\(2) $ (\ExtUnit|Mux29~12_combout\ $ (!\BranchTarget[1]~3\)))) # (GND)
-- \BranchTarget[2]~5\ = CARRY((\PC_Reg|PC_out\(2) & ((\ExtUnit|Mux29~12_combout\) # (!\BranchTarget[1]~3\))) # (!\PC_Reg|PC_out\(2) & (\ExtUnit|Mux29~12_combout\ & !\BranchTarget[1]~3\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(2),
	datab => \ExtUnit|Mux29~12_combout\,
	datad => VCC,
	cin => \BranchTarget[1]~3\,
	combout => \BranchTarget[2]~4_combout\,
	cout => \BranchTarget[2]~5\);

-- Location: LCCOMB_X26_Y2_N6
\BranchTarget[3]~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[3]~6_combout\ = (\ExtUnit|Mux28~3_combout\ & ((\PC_Reg|PC_out\(3) & (\BranchTarget[2]~5\ & VCC)) # (!\PC_Reg|PC_out\(3) & (!\BranchTarget[2]~5\)))) # (!\ExtUnit|Mux28~3_combout\ & ((\PC_Reg|PC_out\(3) & (!\BranchTarget[2]~5\)) # 
-- (!\PC_Reg|PC_out\(3) & ((\BranchTarget[2]~5\) # (GND)))))
-- \BranchTarget[3]~7\ = CARRY((\ExtUnit|Mux28~3_combout\ & (!\PC_Reg|PC_out\(3) & !\BranchTarget[2]~5\)) # (!\ExtUnit|Mux28~3_combout\ & ((!\BranchTarget[2]~5\) # (!\PC_Reg|PC_out\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux28~3_combout\,
	datab => \PC_Reg|PC_out\(3),
	datad => VCC,
	cin => \BranchTarget[2]~5\,
	combout => \BranchTarget[3]~6_combout\,
	cout => \BranchTarget[3]~7\);

-- Location: LCCOMB_X26_Y2_N8
\BranchTarget[4]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[4]~8_combout\ = (\PC_Reg|PC_out\(4) & (\BranchTarget[3]~7\ $ (GND))) # (!\PC_Reg|PC_out\(4) & (!\BranchTarget[3]~7\ & VCC))
-- \BranchTarget[4]~9\ = CARRY((\PC_Reg|PC_out\(4) & !\BranchTarget[3]~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(4),
	datad => VCC,
	cin => \BranchTarget[3]~7\,
	combout => \BranchTarget[4]~8_combout\,
	cout => \BranchTarget[4]~9\);

-- Location: FF_X25_Y2_N9
\PC_Reg|PC_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[5]~36_combout\,
	asdata => \BranchTarget[5]~10_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(5));

-- Location: LCCOMB_X22_Y2_N26
\ExtUnit|Mux29~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux29~3_combout\ = (!\PC_Reg|PC_out\(4) & (!\PC_Reg|PC_out\(3) & !\PC_Reg|PC_out\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(4),
	datac => \PC_Reg|PC_out\(3),
	datad => \PC_Reg|PC_out\(2),
	combout => \ExtUnit|Mux29~3_combout\);

-- Location: LCCOMB_X22_Y2_N24
\ExtUnit|Mux29~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux29~12_combout\ = (!\PC_Reg|PC_out\(5) & (!\PC_Reg|PC_out\(7) & (\ExtUnit|Mux29~3_combout\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(5),
	datab => \PC_Reg|PC_out\(7),
	datac => \ExtUnit|Mux29~3_combout\,
	datad => \PC_Reg|PC_out\(6),
	combout => \ExtUnit|Mux29~12_combout\);

-- Location: FF_X25_Y2_N3
\PC_Reg|PC_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[2]~30_combout\,
	asdata => \BranchTarget[2]~4_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(2));

-- Location: LCCOMB_X25_Y2_N4
\PC_Reg|PC_out[3]~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[3]~32_combout\ = (\PC_Reg|PC_out\(3) & (!\PC_Reg|PC_out[2]~31\)) # (!\PC_Reg|PC_out\(3) & ((\PC_Reg|PC_out[2]~31\) # (GND)))
-- \PC_Reg|PC_out[3]~33\ = CARRY((!\PC_Reg|PC_out[2]~31\) # (!\PC_Reg|PC_out\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(3),
	datad => VCC,
	cin => \PC_Reg|PC_out[2]~31\,
	combout => \PC_Reg|PC_out[3]~32_combout\,
	cout => \PC_Reg|PC_out[3]~33\);

-- Location: FF_X25_Y2_N5
\PC_Reg|PC_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[3]~32_combout\,
	asdata => \BranchTarget[3]~6_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(3));

-- Location: FF_X25_Y2_N7
\PC_Reg|PC_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[4]~34_combout\,
	asdata => \BranchTarget[4]~8_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(4));

-- Location: LCCOMB_X24_Y2_N6
\InstMem|Mux13~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \InstMem|Mux13~1_combout\ = (\PC_Reg|PC_out\(4) & (!\PC_Reg|PC_out\(2) & (\InstMem|Mux13~0_combout\ & \PC_Reg|PC_out\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(4),
	datab => \PC_Reg|PC_out\(2),
	datac => \InstMem|Mux13~0_combout\,
	datad => \PC_Reg|PC_out\(3),
	combout => \InstMem|Mux13~1_combout\);

-- Location: LCCOMB_X24_Y2_N28
\ExtUnit|Mux31~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux31~0_combout\ = (!\InstMem|Mux13~1_combout\ & (!\InstMem|Mux14~3_combout\ & (!\InstMem|Mux15~1_combout\ & !\InstMem|Mux17~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \InstMem|Mux13~1_combout\,
	datab => \InstMem|Mux14~3_combout\,
	datac => \InstMem|Mux15~1_combout\,
	datad => \InstMem|Mux17~3_combout\,
	combout => \ExtUnit|Mux31~0_combout\);

-- Location: LCCOMB_X29_Y2_N4
\ExtUnit|Mux31~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux31~1_combout\ = (\ExtUnit|Mux31~0_combout\ & \InstMem|Mux4~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ExtUnit|Mux31~0_combout\,
	datad => \InstMem|Mux4~0_combout\,
	combout => \ExtUnit|Mux31~1_combout\);

-- Location: FF_X26_Y2_N1
\PC_Reg|PC_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \BranchTarget[0]~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(0));

-- Location: LCCOMB_X25_Y2_N14
\PC_Reg|PC_out[8]~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[8]~42_combout\ = (\PC_Reg|PC_out\(8) & (\PC_Reg|PC_out[7]~41\ $ (GND))) # (!\PC_Reg|PC_out\(8) & (!\PC_Reg|PC_out[7]~41\ & VCC))
-- \PC_Reg|PC_out[8]~43\ = CARRY((\PC_Reg|PC_out\(8) & !\PC_Reg|PC_out[7]~41\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(8),
	datad => VCC,
	cin => \PC_Reg|PC_out[7]~41\,
	combout => \PC_Reg|PC_out[8]~42_combout\,
	cout => \PC_Reg|PC_out[8]~43\);

-- Location: LCCOMB_X26_Y2_N16
\BranchTarget[8]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[8]~16_combout\ = (\PC_Reg|PC_out\(8) & (\BranchTarget[7]~15\ $ (GND))) # (!\PC_Reg|PC_out\(8) & (!\BranchTarget[7]~15\ & VCC))
-- \BranchTarget[8]~17\ = CARRY((\PC_Reg|PC_out\(8) & !\BranchTarget[7]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(8),
	datad => VCC,
	cin => \BranchTarget[7]~15\,
	combout => \BranchTarget[8]~16_combout\,
	cout => \BranchTarget[8]~17\);

-- Location: FF_X25_Y2_N15
\PC_Reg|PC_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[8]~42_combout\,
	asdata => \BranchTarget[8]~16_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(8));

-- Location: LCCOMB_X25_Y2_N16
\PC_Reg|PC_out[9]~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[9]~44_combout\ = (\PC_Reg|PC_out\(9) & (!\PC_Reg|PC_out[8]~43\)) # (!\PC_Reg|PC_out\(9) & ((\PC_Reg|PC_out[8]~43\) # (GND)))
-- \PC_Reg|PC_out[9]~45\ = CARRY((!\PC_Reg|PC_out[8]~43\) # (!\PC_Reg|PC_out\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(9),
	datad => VCC,
	cin => \PC_Reg|PC_out[8]~43\,
	combout => \PC_Reg|PC_out[9]~44_combout\,
	cout => \PC_Reg|PC_out[9]~45\);

-- Location: LCCOMB_X26_Y2_N18
\BranchTarget[9]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[9]~18_combout\ = (\PC_Reg|PC_out\(9) & (!\BranchTarget[8]~17\)) # (!\PC_Reg|PC_out\(9) & ((\BranchTarget[8]~17\) # (GND)))
-- \BranchTarget[9]~19\ = CARRY((!\BranchTarget[8]~17\) # (!\PC_Reg|PC_out\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(9),
	datad => VCC,
	cin => \BranchTarget[8]~17\,
	combout => \BranchTarget[9]~18_combout\,
	cout => \BranchTarget[9]~19\);

-- Location: FF_X25_Y2_N17
\PC_Reg|PC_out[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[9]~44_combout\,
	asdata => \BranchTarget[9]~18_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(9));

-- Location: LCCOMB_X25_Y2_N18
\PC_Reg|PC_out[10]~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[10]~46_combout\ = (\PC_Reg|PC_out\(10) & (\PC_Reg|PC_out[9]~45\ $ (GND))) # (!\PC_Reg|PC_out\(10) & (!\PC_Reg|PC_out[9]~45\ & VCC))
-- \PC_Reg|PC_out[10]~47\ = CARRY((\PC_Reg|PC_out\(10) & !\PC_Reg|PC_out[9]~45\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(10),
	datad => VCC,
	cin => \PC_Reg|PC_out[9]~45\,
	combout => \PC_Reg|PC_out[10]~46_combout\,
	cout => \PC_Reg|PC_out[10]~47\);

-- Location: LCCOMB_X25_Y2_N0
\ExtUnit|Mux21~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux21~3_combout\ = (!\PC_Reg|PC_out\(6) & (!\InstMem|Mux17~2_combout\ & !\PC_Reg|PC_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(6),
	datab => \InstMem|Mux17~2_combout\,
	datad => \PC_Reg|PC_out\(7),
	combout => \ExtUnit|Mux21~3_combout\);

-- Location: LCCOMB_X27_Y2_N4
\ExtUnit|Mux21~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux21~2_combout\ = (\ExtUnit|Mux21~3_combout\ & (\InstMem|Mux0~0_combout\ & (!\InstMem|Mux15~2_combout\ & !\InstMem|Mux14~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux21~3_combout\,
	datab => \InstMem|Mux0~0_combout\,
	datac => \InstMem|Mux15~2_combout\,
	datad => \InstMem|Mux14~3_combout\,
	combout => \ExtUnit|Mux21~2_combout\);

-- Location: LCCOMB_X26_Y2_N20
\BranchTarget[10]~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[10]~20_combout\ = ((\ExtUnit|Mux21~2_combout\ $ (\PC_Reg|PC_out\(10) $ (!\BranchTarget[9]~19\)))) # (GND)
-- \BranchTarget[10]~21\ = CARRY((\ExtUnit|Mux21~2_combout\ & ((\PC_Reg|PC_out\(10)) # (!\BranchTarget[9]~19\))) # (!\ExtUnit|Mux21~2_combout\ & (\PC_Reg|PC_out\(10) & !\BranchTarget[9]~19\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux21~2_combout\,
	datab => \PC_Reg|PC_out\(10),
	datad => VCC,
	cin => \BranchTarget[9]~19\,
	combout => \BranchTarget[10]~20_combout\,
	cout => \BranchTarget[10]~21\);

-- Location: FF_X25_Y2_N19
\PC_Reg|PC_out[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[10]~46_combout\,
	asdata => \BranchTarget[10]~20_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(10));

-- Location: LCCOMB_X25_Y2_N20
\PC_Reg|PC_out[11]~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[11]~48_combout\ = (\PC_Reg|PC_out\(11) & (!\PC_Reg|PC_out[10]~47\)) # (!\PC_Reg|PC_out\(11) & ((\PC_Reg|PC_out[10]~47\) # (GND)))
-- \PC_Reg|PC_out[11]~49\ = CARRY((!\PC_Reg|PC_out[10]~47\) # (!\PC_Reg|PC_out\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(11),
	datad => VCC,
	cin => \PC_Reg|PC_out[10]~47\,
	combout => \PC_Reg|PC_out[11]~48_combout\,
	cout => \PC_Reg|PC_out[11]~49\);

-- Location: LCCOMB_X22_Y2_N14
\ExtUnit|Mux20~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ExtUnit|Mux20~2_combout\ = (\PCSrc~0_combout\ & (!\PC_Reg|PC_out\(7) & (!\InstMem|Mux12~2_combout\ & !\PC_Reg|PC_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PCSrc~0_combout\,
	datab => \PC_Reg|PC_out\(7),
	datac => \InstMem|Mux12~2_combout\,
	datad => \PC_Reg|PC_out\(6),
	combout => \ExtUnit|Mux20~2_combout\);

-- Location: LCCOMB_X26_Y2_N22
\BranchTarget[11]~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[11]~22_combout\ = (\ExtUnit|Mux20~2_combout\ & ((\PC_Reg|PC_out\(11) & (\BranchTarget[10]~21\ & VCC)) # (!\PC_Reg|PC_out\(11) & (!\BranchTarget[10]~21\)))) # (!\ExtUnit|Mux20~2_combout\ & ((\PC_Reg|PC_out\(11) & (!\BranchTarget[10]~21\)) # 
-- (!\PC_Reg|PC_out\(11) & ((\BranchTarget[10]~21\) # (GND)))))
-- \BranchTarget[11]~23\ = CARRY((\ExtUnit|Mux20~2_combout\ & (!\PC_Reg|PC_out\(11) & !\BranchTarget[10]~21\)) # (!\ExtUnit|Mux20~2_combout\ & ((!\BranchTarget[10]~21\) # (!\PC_Reg|PC_out\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \ExtUnit|Mux20~2_combout\,
	datab => \PC_Reg|PC_out\(11),
	datad => VCC,
	cin => \BranchTarget[10]~21\,
	combout => \BranchTarget[11]~22_combout\,
	cout => \BranchTarget[11]~23\);

-- Location: FF_X25_Y2_N21
\PC_Reg|PC_out[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[11]~48_combout\,
	asdata => \BranchTarget[11]~22_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(11));

-- Location: LCCOMB_X25_Y2_N22
\PC_Reg|PC_out[12]~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[12]~50_combout\ = (\PC_Reg|PC_out\(12) & (\PC_Reg|PC_out[11]~49\ $ (GND))) # (!\PC_Reg|PC_out\(12) & (!\PC_Reg|PC_out[11]~49\ & VCC))
-- \PC_Reg|PC_out[12]~51\ = CARRY((\PC_Reg|PC_out\(12) & !\PC_Reg|PC_out[11]~49\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(12),
	datad => VCC,
	cin => \PC_Reg|PC_out[11]~49\,
	combout => \PC_Reg|PC_out[12]~50_combout\,
	cout => \PC_Reg|PC_out[12]~51\);

-- Location: LCCOMB_X26_Y2_N24
\BranchTarget[12]~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[12]~24_combout\ = (\PC_Reg|PC_out\(12) & (\BranchTarget[11]~23\ $ (GND))) # (!\PC_Reg|PC_out\(12) & (!\BranchTarget[11]~23\ & VCC))
-- \BranchTarget[12]~25\ = CARRY((\PC_Reg|PC_out\(12) & !\BranchTarget[11]~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(12),
	datad => VCC,
	cin => \BranchTarget[11]~23\,
	combout => \BranchTarget[12]~24_combout\,
	cout => \BranchTarget[12]~25\);

-- Location: FF_X25_Y2_N23
\PC_Reg|PC_out[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[12]~50_combout\,
	asdata => \BranchTarget[12]~24_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(12));

-- Location: LCCOMB_X25_Y2_N24
\PC_Reg|PC_out[13]~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[13]~52_combout\ = (\PC_Reg|PC_out\(13) & (!\PC_Reg|PC_out[12]~51\)) # (!\PC_Reg|PC_out\(13) & ((\PC_Reg|PC_out[12]~51\) # (GND)))
-- \PC_Reg|PC_out[13]~53\ = CARRY((!\PC_Reg|PC_out[12]~51\) # (!\PC_Reg|PC_out\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(13),
	datad => VCC,
	cin => \PC_Reg|PC_out[12]~51\,
	combout => \PC_Reg|PC_out[13]~52_combout\,
	cout => \PC_Reg|PC_out[13]~53\);

-- Location: LCCOMB_X26_Y2_N26
\BranchTarget[13]~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[13]~26_combout\ = (\PC_Reg|PC_out\(13) & (!\BranchTarget[12]~25\)) # (!\PC_Reg|PC_out\(13) & ((\BranchTarget[12]~25\) # (GND)))
-- \BranchTarget[13]~27\ = CARRY((!\BranchTarget[12]~25\) # (!\PC_Reg|PC_out\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(13),
	datad => VCC,
	cin => \BranchTarget[12]~25\,
	combout => \BranchTarget[13]~26_combout\,
	cout => \BranchTarget[13]~27\);

-- Location: FF_X25_Y2_N25
\PC_Reg|PC_out[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[13]~52_combout\,
	asdata => \BranchTarget[13]~26_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(13));

-- Location: LCCOMB_X25_Y2_N26
\PC_Reg|PC_out[14]~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[14]~54_combout\ = (\PC_Reg|PC_out\(14) & (\PC_Reg|PC_out[13]~53\ $ (GND))) # (!\PC_Reg|PC_out\(14) & (!\PC_Reg|PC_out[13]~53\ & VCC))
-- \PC_Reg|PC_out[14]~55\ = CARRY((\PC_Reg|PC_out\(14) & !\PC_Reg|PC_out[13]~53\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(14),
	datad => VCC,
	cin => \PC_Reg|PC_out[13]~53\,
	combout => \PC_Reg|PC_out[14]~54_combout\,
	cout => \PC_Reg|PC_out[14]~55\);

-- Location: LCCOMB_X26_Y2_N28
\BranchTarget[14]~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[14]~28_combout\ = (\PC_Reg|PC_out\(14) & (\BranchTarget[13]~27\ $ (GND))) # (!\PC_Reg|PC_out\(14) & (!\BranchTarget[13]~27\ & VCC))
-- \BranchTarget[14]~29\ = CARRY((\PC_Reg|PC_out\(14) & !\BranchTarget[13]~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(14),
	datad => VCC,
	cin => \BranchTarget[13]~27\,
	combout => \BranchTarget[14]~28_combout\,
	cout => \BranchTarget[14]~29\);

-- Location: FF_X25_Y2_N27
\PC_Reg|PC_out[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[14]~54_combout\,
	asdata => \BranchTarget[14]~28_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(14));

-- Location: LCCOMB_X25_Y2_N28
\PC_Reg|PC_out[15]~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[15]~56_combout\ = (\PC_Reg|PC_out\(15) & (!\PC_Reg|PC_out[14]~55\)) # (!\PC_Reg|PC_out\(15) & ((\PC_Reg|PC_out[14]~55\) # (GND)))
-- \PC_Reg|PC_out[15]~57\ = CARRY((!\PC_Reg|PC_out[14]~55\) # (!\PC_Reg|PC_out\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(15),
	datad => VCC,
	cin => \PC_Reg|PC_out[14]~55\,
	combout => \PC_Reg|PC_out[15]~56_combout\,
	cout => \PC_Reg|PC_out[15]~57\);

-- Location: LCCOMB_X26_Y2_N30
\BranchTarget[15]~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[15]~30_combout\ = (\PC_Reg|PC_out\(15) & (!\BranchTarget[14]~29\)) # (!\PC_Reg|PC_out\(15) & ((\BranchTarget[14]~29\) # (GND)))
-- \BranchTarget[15]~31\ = CARRY((!\BranchTarget[14]~29\) # (!\PC_Reg|PC_out\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(15),
	datad => VCC,
	cin => \BranchTarget[14]~29\,
	combout => \BranchTarget[15]~30_combout\,
	cout => \BranchTarget[15]~31\);

-- Location: FF_X25_Y2_N29
\PC_Reg|PC_out[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[15]~56_combout\,
	asdata => \BranchTarget[15]~30_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(15));

-- Location: LCCOMB_X25_Y2_N30
\PC_Reg|PC_out[16]~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[16]~58_combout\ = (\PC_Reg|PC_out\(16) & (\PC_Reg|PC_out[15]~57\ $ (GND))) # (!\PC_Reg|PC_out\(16) & (!\PC_Reg|PC_out[15]~57\ & VCC))
-- \PC_Reg|PC_out[16]~59\ = CARRY((\PC_Reg|PC_out\(16) & !\PC_Reg|PC_out[15]~57\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(16),
	datad => VCC,
	cin => \PC_Reg|PC_out[15]~57\,
	combout => \PC_Reg|PC_out[16]~58_combout\,
	cout => \PC_Reg|PC_out[16]~59\);

-- Location: LCCOMB_X26_Y1_N0
\BranchTarget[16]~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[16]~32_combout\ = (\PC_Reg|PC_out\(16) & (\BranchTarget[15]~31\ $ (GND))) # (!\PC_Reg|PC_out\(16) & (!\BranchTarget[15]~31\ & VCC))
-- \BranchTarget[16]~33\ = CARRY((\PC_Reg|PC_out\(16) & !\BranchTarget[15]~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(16),
	datad => VCC,
	cin => \BranchTarget[15]~31\,
	combout => \BranchTarget[16]~32_combout\,
	cout => \BranchTarget[16]~33\);

-- Location: FF_X25_Y2_N31
\PC_Reg|PC_out[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[16]~58_combout\,
	asdata => \BranchTarget[16]~32_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(16));

-- Location: LCCOMB_X25_Y1_N0
\PC_Reg|PC_out[17]~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[17]~60_combout\ = (\PC_Reg|PC_out\(17) & (!\PC_Reg|PC_out[16]~59\)) # (!\PC_Reg|PC_out\(17) & ((\PC_Reg|PC_out[16]~59\) # (GND)))
-- \PC_Reg|PC_out[17]~61\ = CARRY((!\PC_Reg|PC_out[16]~59\) # (!\PC_Reg|PC_out\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(17),
	datad => VCC,
	cin => \PC_Reg|PC_out[16]~59\,
	combout => \PC_Reg|PC_out[17]~60_combout\,
	cout => \PC_Reg|PC_out[17]~61\);

-- Location: LCCOMB_X26_Y1_N2
\BranchTarget[17]~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[17]~34_combout\ = (\PC_Reg|PC_out\(17) & (!\BranchTarget[16]~33\)) # (!\PC_Reg|PC_out\(17) & ((\BranchTarget[16]~33\) # (GND)))
-- \BranchTarget[17]~35\ = CARRY((!\BranchTarget[16]~33\) # (!\PC_Reg|PC_out\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(17),
	datad => VCC,
	cin => \BranchTarget[16]~33\,
	combout => \BranchTarget[17]~34_combout\,
	cout => \BranchTarget[17]~35\);

-- Location: FF_X25_Y1_N1
\PC_Reg|PC_out[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[17]~60_combout\,
	asdata => \BranchTarget[17]~34_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(17));

-- Location: LCCOMB_X25_Y1_N2
\PC_Reg|PC_out[18]~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[18]~62_combout\ = (\PC_Reg|PC_out\(18) & (\PC_Reg|PC_out[17]~61\ $ (GND))) # (!\PC_Reg|PC_out\(18) & (!\PC_Reg|PC_out[17]~61\ & VCC))
-- \PC_Reg|PC_out[18]~63\ = CARRY((\PC_Reg|PC_out\(18) & !\PC_Reg|PC_out[17]~61\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(18),
	datad => VCC,
	cin => \PC_Reg|PC_out[17]~61\,
	combout => \PC_Reg|PC_out[18]~62_combout\,
	cout => \PC_Reg|PC_out[18]~63\);

-- Location: LCCOMB_X26_Y1_N4
\BranchTarget[18]~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[18]~36_combout\ = (\PC_Reg|PC_out\(18) & (\BranchTarget[17]~35\ $ (GND))) # (!\PC_Reg|PC_out\(18) & (!\BranchTarget[17]~35\ & VCC))
-- \BranchTarget[18]~37\ = CARRY((\PC_Reg|PC_out\(18) & !\BranchTarget[17]~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(18),
	datad => VCC,
	cin => \BranchTarget[17]~35\,
	combout => \BranchTarget[18]~36_combout\,
	cout => \BranchTarget[18]~37\);

-- Location: FF_X25_Y1_N3
\PC_Reg|PC_out[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[18]~62_combout\,
	asdata => \BranchTarget[18]~36_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(18));

-- Location: LCCOMB_X25_Y1_N4
\PC_Reg|PC_out[19]~64\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[19]~64_combout\ = (\PC_Reg|PC_out\(19) & (!\PC_Reg|PC_out[18]~63\)) # (!\PC_Reg|PC_out\(19) & ((\PC_Reg|PC_out[18]~63\) # (GND)))
-- \PC_Reg|PC_out[19]~65\ = CARRY((!\PC_Reg|PC_out[18]~63\) # (!\PC_Reg|PC_out\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(19),
	datad => VCC,
	cin => \PC_Reg|PC_out[18]~63\,
	combout => \PC_Reg|PC_out[19]~64_combout\,
	cout => \PC_Reg|PC_out[19]~65\);

-- Location: LCCOMB_X26_Y1_N6
\BranchTarget[19]~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[19]~38_combout\ = (\PC_Reg|PC_out\(19) & (!\BranchTarget[18]~37\)) # (!\PC_Reg|PC_out\(19) & ((\BranchTarget[18]~37\) # (GND)))
-- \BranchTarget[19]~39\ = CARRY((!\BranchTarget[18]~37\) # (!\PC_Reg|PC_out\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(19),
	datad => VCC,
	cin => \BranchTarget[18]~37\,
	combout => \BranchTarget[19]~38_combout\,
	cout => \BranchTarget[19]~39\);

-- Location: FF_X25_Y1_N5
\PC_Reg|PC_out[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[19]~64_combout\,
	asdata => \BranchTarget[19]~38_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(19));

-- Location: LCCOMB_X25_Y1_N6
\PC_Reg|PC_out[20]~66\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[20]~66_combout\ = (\PC_Reg|PC_out\(20) & (\PC_Reg|PC_out[19]~65\ $ (GND))) # (!\PC_Reg|PC_out\(20) & (!\PC_Reg|PC_out[19]~65\ & VCC))
-- \PC_Reg|PC_out[20]~67\ = CARRY((\PC_Reg|PC_out\(20) & !\PC_Reg|PC_out[19]~65\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(20),
	datad => VCC,
	cin => \PC_Reg|PC_out[19]~65\,
	combout => \PC_Reg|PC_out[20]~66_combout\,
	cout => \PC_Reg|PC_out[20]~67\);

-- Location: LCCOMB_X26_Y1_N8
\BranchTarget[20]~40\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[20]~40_combout\ = (\PC_Reg|PC_out\(20) & (\BranchTarget[19]~39\ $ (GND))) # (!\PC_Reg|PC_out\(20) & (!\BranchTarget[19]~39\ & VCC))
-- \BranchTarget[20]~41\ = CARRY((\PC_Reg|PC_out\(20) & !\BranchTarget[19]~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(20),
	datad => VCC,
	cin => \BranchTarget[19]~39\,
	combout => \BranchTarget[20]~40_combout\,
	cout => \BranchTarget[20]~41\);

-- Location: FF_X25_Y1_N7
\PC_Reg|PC_out[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[20]~66_combout\,
	asdata => \BranchTarget[20]~40_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(20));

-- Location: LCCOMB_X25_Y1_N8
\PC_Reg|PC_out[21]~68\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[21]~68_combout\ = (\PC_Reg|PC_out\(21) & (!\PC_Reg|PC_out[20]~67\)) # (!\PC_Reg|PC_out\(21) & ((\PC_Reg|PC_out[20]~67\) # (GND)))
-- \PC_Reg|PC_out[21]~69\ = CARRY((!\PC_Reg|PC_out[20]~67\) # (!\PC_Reg|PC_out\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(21),
	datad => VCC,
	cin => \PC_Reg|PC_out[20]~67\,
	combout => \PC_Reg|PC_out[21]~68_combout\,
	cout => \PC_Reg|PC_out[21]~69\);

-- Location: LCCOMB_X26_Y1_N10
\BranchTarget[21]~42\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[21]~42_combout\ = (\PC_Reg|PC_out\(21) & (!\BranchTarget[20]~41\)) # (!\PC_Reg|PC_out\(21) & ((\BranchTarget[20]~41\) # (GND)))
-- \BranchTarget[21]~43\ = CARRY((!\BranchTarget[20]~41\) # (!\PC_Reg|PC_out\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(21),
	datad => VCC,
	cin => \BranchTarget[20]~41\,
	combout => \BranchTarget[21]~42_combout\,
	cout => \BranchTarget[21]~43\);

-- Location: FF_X25_Y1_N9
\PC_Reg|PC_out[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[21]~68_combout\,
	asdata => \BranchTarget[21]~42_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(21));

-- Location: LCCOMB_X25_Y1_N10
\PC_Reg|PC_out[22]~70\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[22]~70_combout\ = (\PC_Reg|PC_out\(22) & (\PC_Reg|PC_out[21]~69\ $ (GND))) # (!\PC_Reg|PC_out\(22) & (!\PC_Reg|PC_out[21]~69\ & VCC))
-- \PC_Reg|PC_out[22]~71\ = CARRY((\PC_Reg|PC_out\(22) & !\PC_Reg|PC_out[21]~69\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(22),
	datad => VCC,
	cin => \PC_Reg|PC_out[21]~69\,
	combout => \PC_Reg|PC_out[22]~70_combout\,
	cout => \PC_Reg|PC_out[22]~71\);

-- Location: LCCOMB_X26_Y1_N12
\BranchTarget[22]~44\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[22]~44_combout\ = (\PC_Reg|PC_out\(22) & (\BranchTarget[21]~43\ $ (GND))) # (!\PC_Reg|PC_out\(22) & (!\BranchTarget[21]~43\ & VCC))
-- \BranchTarget[22]~45\ = CARRY((\PC_Reg|PC_out\(22) & !\BranchTarget[21]~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(22),
	datad => VCC,
	cin => \BranchTarget[21]~43\,
	combout => \BranchTarget[22]~44_combout\,
	cout => \BranchTarget[22]~45\);

-- Location: FF_X25_Y1_N11
\PC_Reg|PC_out[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[22]~70_combout\,
	asdata => \BranchTarget[22]~44_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(22));

-- Location: LCCOMB_X25_Y1_N12
\PC_Reg|PC_out[23]~72\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[23]~72_combout\ = (\PC_Reg|PC_out\(23) & (!\PC_Reg|PC_out[22]~71\)) # (!\PC_Reg|PC_out\(23) & ((\PC_Reg|PC_out[22]~71\) # (GND)))
-- \PC_Reg|PC_out[23]~73\ = CARRY((!\PC_Reg|PC_out[22]~71\) # (!\PC_Reg|PC_out\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(23),
	datad => VCC,
	cin => \PC_Reg|PC_out[22]~71\,
	combout => \PC_Reg|PC_out[23]~72_combout\,
	cout => \PC_Reg|PC_out[23]~73\);

-- Location: LCCOMB_X26_Y1_N14
\BranchTarget[23]~46\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[23]~46_combout\ = (\PC_Reg|PC_out\(23) & (!\BranchTarget[22]~45\)) # (!\PC_Reg|PC_out\(23) & ((\BranchTarget[22]~45\) # (GND)))
-- \BranchTarget[23]~47\ = CARRY((!\BranchTarget[22]~45\) # (!\PC_Reg|PC_out\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(23),
	datad => VCC,
	cin => \BranchTarget[22]~45\,
	combout => \BranchTarget[23]~46_combout\,
	cout => \BranchTarget[23]~47\);

-- Location: FF_X25_Y1_N13
\PC_Reg|PC_out[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[23]~72_combout\,
	asdata => \BranchTarget[23]~46_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(23));

-- Location: LCCOMB_X25_Y1_N14
\PC_Reg|PC_out[24]~74\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[24]~74_combout\ = (\PC_Reg|PC_out\(24) & (\PC_Reg|PC_out[23]~73\ $ (GND))) # (!\PC_Reg|PC_out\(24) & (!\PC_Reg|PC_out[23]~73\ & VCC))
-- \PC_Reg|PC_out[24]~75\ = CARRY((\PC_Reg|PC_out\(24) & !\PC_Reg|PC_out[23]~73\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(24),
	datad => VCC,
	cin => \PC_Reg|PC_out[23]~73\,
	combout => \PC_Reg|PC_out[24]~74_combout\,
	cout => \PC_Reg|PC_out[24]~75\);

-- Location: LCCOMB_X26_Y1_N16
\BranchTarget[24]~48\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[24]~48_combout\ = (\PC_Reg|PC_out\(24) & (\BranchTarget[23]~47\ $ (GND))) # (!\PC_Reg|PC_out\(24) & (!\BranchTarget[23]~47\ & VCC))
-- \BranchTarget[24]~49\ = CARRY((\PC_Reg|PC_out\(24) & !\BranchTarget[23]~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(24),
	datad => VCC,
	cin => \BranchTarget[23]~47\,
	combout => \BranchTarget[24]~48_combout\,
	cout => \BranchTarget[24]~49\);

-- Location: FF_X25_Y1_N15
\PC_Reg|PC_out[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[24]~74_combout\,
	asdata => \BranchTarget[24]~48_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(24));

-- Location: LCCOMB_X25_Y1_N16
\PC_Reg|PC_out[25]~76\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[25]~76_combout\ = (\PC_Reg|PC_out\(25) & (!\PC_Reg|PC_out[24]~75\)) # (!\PC_Reg|PC_out\(25) & ((\PC_Reg|PC_out[24]~75\) # (GND)))
-- \PC_Reg|PC_out[25]~77\ = CARRY((!\PC_Reg|PC_out[24]~75\) # (!\PC_Reg|PC_out\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(25),
	datad => VCC,
	cin => \PC_Reg|PC_out[24]~75\,
	combout => \PC_Reg|PC_out[25]~76_combout\,
	cout => \PC_Reg|PC_out[25]~77\);

-- Location: LCCOMB_X26_Y1_N18
\BranchTarget[25]~50\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[25]~50_combout\ = (\PC_Reg|PC_out\(25) & (!\BranchTarget[24]~49\)) # (!\PC_Reg|PC_out\(25) & ((\BranchTarget[24]~49\) # (GND)))
-- \BranchTarget[25]~51\ = CARRY((!\BranchTarget[24]~49\) # (!\PC_Reg|PC_out\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(25),
	datad => VCC,
	cin => \BranchTarget[24]~49\,
	combout => \BranchTarget[25]~50_combout\,
	cout => \BranchTarget[25]~51\);

-- Location: FF_X25_Y1_N17
\PC_Reg|PC_out[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[25]~76_combout\,
	asdata => \BranchTarget[25]~50_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(25));

-- Location: LCCOMB_X25_Y1_N18
\PC_Reg|PC_out[26]~78\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[26]~78_combout\ = (\PC_Reg|PC_out\(26) & (\PC_Reg|PC_out[25]~77\ $ (GND))) # (!\PC_Reg|PC_out\(26) & (!\PC_Reg|PC_out[25]~77\ & VCC))
-- \PC_Reg|PC_out[26]~79\ = CARRY((\PC_Reg|PC_out\(26) & !\PC_Reg|PC_out[25]~77\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(26),
	datad => VCC,
	cin => \PC_Reg|PC_out[25]~77\,
	combout => \PC_Reg|PC_out[26]~78_combout\,
	cout => \PC_Reg|PC_out[26]~79\);

-- Location: LCCOMB_X26_Y1_N20
\BranchTarget[26]~52\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[26]~52_combout\ = (\PC_Reg|PC_out\(26) & (\BranchTarget[25]~51\ $ (GND))) # (!\PC_Reg|PC_out\(26) & (!\BranchTarget[25]~51\ & VCC))
-- \BranchTarget[26]~53\ = CARRY((\PC_Reg|PC_out\(26) & !\BranchTarget[25]~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(26),
	datad => VCC,
	cin => \BranchTarget[25]~51\,
	combout => \BranchTarget[26]~52_combout\,
	cout => \BranchTarget[26]~53\);

-- Location: FF_X25_Y1_N19
\PC_Reg|PC_out[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[26]~78_combout\,
	asdata => \BranchTarget[26]~52_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(26));

-- Location: LCCOMB_X25_Y1_N20
\PC_Reg|PC_out[27]~80\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[27]~80_combout\ = (\PC_Reg|PC_out\(27) & (!\PC_Reg|PC_out[26]~79\)) # (!\PC_Reg|PC_out\(27) & ((\PC_Reg|PC_out[26]~79\) # (GND)))
-- \PC_Reg|PC_out[27]~81\ = CARRY((!\PC_Reg|PC_out[26]~79\) # (!\PC_Reg|PC_out\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(27),
	datad => VCC,
	cin => \PC_Reg|PC_out[26]~79\,
	combout => \PC_Reg|PC_out[27]~80_combout\,
	cout => \PC_Reg|PC_out[27]~81\);

-- Location: LCCOMB_X26_Y1_N22
\BranchTarget[27]~54\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[27]~54_combout\ = (\PC_Reg|PC_out\(27) & (!\BranchTarget[26]~53\)) # (!\PC_Reg|PC_out\(27) & ((\BranchTarget[26]~53\) # (GND)))
-- \BranchTarget[27]~55\ = CARRY((!\BranchTarget[26]~53\) # (!\PC_Reg|PC_out\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(27),
	datad => VCC,
	cin => \BranchTarget[26]~53\,
	combout => \BranchTarget[27]~54_combout\,
	cout => \BranchTarget[27]~55\);

-- Location: FF_X25_Y1_N21
\PC_Reg|PC_out[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[27]~80_combout\,
	asdata => \BranchTarget[27]~54_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(27));

-- Location: LCCOMB_X25_Y1_N22
\PC_Reg|PC_out[28]~82\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[28]~82_combout\ = (\PC_Reg|PC_out\(28) & (\PC_Reg|PC_out[27]~81\ $ (GND))) # (!\PC_Reg|PC_out\(28) & (!\PC_Reg|PC_out[27]~81\ & VCC))
-- \PC_Reg|PC_out[28]~83\ = CARRY((\PC_Reg|PC_out\(28) & !\PC_Reg|PC_out[27]~81\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(28),
	datad => VCC,
	cin => \PC_Reg|PC_out[27]~81\,
	combout => \PC_Reg|PC_out[28]~82_combout\,
	cout => \PC_Reg|PC_out[28]~83\);

-- Location: LCCOMB_X26_Y1_N24
\BranchTarget[28]~56\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[28]~56_combout\ = (\PC_Reg|PC_out\(28) & (\BranchTarget[27]~55\ $ (GND))) # (!\PC_Reg|PC_out\(28) & (!\BranchTarget[27]~55\ & VCC))
-- \BranchTarget[28]~57\ = CARRY((\PC_Reg|PC_out\(28) & !\BranchTarget[27]~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(28),
	datad => VCC,
	cin => \BranchTarget[27]~55\,
	combout => \BranchTarget[28]~56_combout\,
	cout => \BranchTarget[28]~57\);

-- Location: FF_X25_Y1_N23
\PC_Reg|PC_out[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[28]~82_combout\,
	asdata => \BranchTarget[28]~56_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(28));

-- Location: LCCOMB_X25_Y1_N24
\PC_Reg|PC_out[29]~84\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[29]~84_combout\ = (\PC_Reg|PC_out\(29) & (!\PC_Reg|PC_out[28]~83\)) # (!\PC_Reg|PC_out\(29) & ((\PC_Reg|PC_out[28]~83\) # (GND)))
-- \PC_Reg|PC_out[29]~85\ = CARRY((!\PC_Reg|PC_out[28]~83\) # (!\PC_Reg|PC_out\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(29),
	datad => VCC,
	cin => \PC_Reg|PC_out[28]~83\,
	combout => \PC_Reg|PC_out[29]~84_combout\,
	cout => \PC_Reg|PC_out[29]~85\);

-- Location: LCCOMB_X26_Y1_N26
\BranchTarget[29]~58\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[29]~58_combout\ = (\PC_Reg|PC_out\(29) & (!\BranchTarget[28]~57\)) # (!\PC_Reg|PC_out\(29) & ((\BranchTarget[28]~57\) # (GND)))
-- \BranchTarget[29]~59\ = CARRY((!\BranchTarget[28]~57\) # (!\PC_Reg|PC_out\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \PC_Reg|PC_out\(29),
	datad => VCC,
	cin => \BranchTarget[28]~57\,
	combout => \BranchTarget[29]~58_combout\,
	cout => \BranchTarget[29]~59\);

-- Location: FF_X25_Y1_N25
\PC_Reg|PC_out[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[29]~84_combout\,
	asdata => \BranchTarget[29]~58_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(29));

-- Location: LCCOMB_X25_Y1_N26
\PC_Reg|PC_out[30]~86\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[30]~86_combout\ = (\PC_Reg|PC_out\(30) & (\PC_Reg|PC_out[29]~85\ $ (GND))) # (!\PC_Reg|PC_out\(30) & (!\PC_Reg|PC_out[29]~85\ & VCC))
-- \PC_Reg|PC_out[30]~87\ = CARRY((\PC_Reg|PC_out\(30) & !\PC_Reg|PC_out[29]~85\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(30),
	datad => VCC,
	cin => \PC_Reg|PC_out[29]~85\,
	combout => \PC_Reg|PC_out[30]~86_combout\,
	cout => \PC_Reg|PC_out[30]~87\);

-- Location: LCCOMB_X26_Y1_N28
\BranchTarget[30]~60\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[30]~60_combout\ = (\PC_Reg|PC_out\(30) & (\BranchTarget[29]~59\ $ (GND))) # (!\PC_Reg|PC_out\(30) & (!\BranchTarget[29]~59\ & VCC))
-- \BranchTarget[30]~61\ = CARRY((\PC_Reg|PC_out\(30) & !\BranchTarget[29]~59\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \PC_Reg|PC_out\(30),
	datad => VCC,
	cin => \BranchTarget[29]~59\,
	combout => \BranchTarget[30]~60_combout\,
	cout => \BranchTarget[30]~61\);

-- Location: FF_X25_Y1_N27
\PC_Reg|PC_out[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[30]~86_combout\,
	asdata => \BranchTarget[30]~60_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(30));

-- Location: LCCOMB_X25_Y1_N28
\PC_Reg|PC_out[31]~88\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \PC_Reg|PC_out[31]~88_combout\ = \PC_Reg|PC_out[30]~87\ $ (\PC_Reg|PC_out\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \PC_Reg|PC_out\(31),
	cin => \PC_Reg|PC_out[30]~87\,
	combout => \PC_Reg|PC_out[31]~88_combout\);

-- Location: LCCOMB_X26_Y1_N30
\BranchTarget[31]~62\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \BranchTarget[31]~62_combout\ = \BranchTarget[30]~61\ $ (\PC_Reg|PC_out\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \PC_Reg|PC_out\(31),
	cin => \BranchTarget[30]~61\,
	combout => \BranchTarget[31]~62_combout\);

-- Location: FF_X25_Y1_N29
\PC_Reg|PC_out[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_Reg|PC_out[31]~88_combout\,
	asdata => \BranchTarget[31]~62_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => \PCSrc~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_Reg|PC_out\(31));

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

ww_PC_debug(0) <= \PC_debug[0]~output_o\;

ww_PC_debug(1) <= \PC_debug[1]~output_o\;

ww_PC_debug(2) <= \PC_debug[2]~output_o\;

ww_PC_debug(3) <= \PC_debug[3]~output_o\;

ww_PC_debug(4) <= \PC_debug[4]~output_o\;

ww_PC_debug(5) <= \PC_debug[5]~output_o\;

ww_PC_debug(6) <= \PC_debug[6]~output_o\;

ww_PC_debug(7) <= \PC_debug[7]~output_o\;

ww_PC_debug(8) <= \PC_debug[8]~output_o\;

ww_PC_debug(9) <= \PC_debug[9]~output_o\;

ww_PC_debug(10) <= \PC_debug[10]~output_o\;

ww_PC_debug(11) <= \PC_debug[11]~output_o\;

ww_PC_debug(12) <= \PC_debug[12]~output_o\;

ww_PC_debug(13) <= \PC_debug[13]~output_o\;

ww_PC_debug(14) <= \PC_debug[14]~output_o\;

ww_PC_debug(15) <= \PC_debug[15]~output_o\;

ww_PC_debug(16) <= \PC_debug[16]~output_o\;

ww_PC_debug(17) <= \PC_debug[17]~output_o\;

ww_PC_debug(18) <= \PC_debug[18]~output_o\;

ww_PC_debug(19) <= \PC_debug[19]~output_o\;

ww_PC_debug(20) <= \PC_debug[20]~output_o\;

ww_PC_debug(21) <= \PC_debug[21]~output_o\;

ww_PC_debug(22) <= \PC_debug[22]~output_o\;

ww_PC_debug(23) <= \PC_debug[23]~output_o\;

ww_PC_debug(24) <= \PC_debug[24]~output_o\;

ww_PC_debug(25) <= \PC_debug[25]~output_o\;

ww_PC_debug(26) <= \PC_debug[26]~output_o\;

ww_PC_debug(27) <= \PC_debug[27]~output_o\;

ww_PC_debug(28) <= \PC_debug[28]~output_o\;

ww_PC_debug(29) <= \PC_debug[29]~output_o\;

ww_PC_debug(30) <= \PC_debug[30]~output_o\;

ww_PC_debug(31) <= \PC_debug[31]~output_o\;

ww_instr_debug(0) <= \instr_debug[0]~output_o\;

ww_instr_debug(1) <= \instr_debug[1]~output_o\;

ww_instr_debug(2) <= \instr_debug[2]~output_o\;

ww_instr_debug(3) <= \instr_debug[3]~output_o\;

ww_instr_debug(4) <= \instr_debug[4]~output_o\;

ww_instr_debug(5) <= \instr_debug[5]~output_o\;

ww_instr_debug(6) <= \instr_debug[6]~output_o\;

ww_instr_debug(7) <= \instr_debug[7]~output_o\;

ww_instr_debug(8) <= \instr_debug[8]~output_o\;

ww_instr_debug(9) <= \instr_debug[9]~output_o\;

ww_instr_debug(10) <= \instr_debug[10]~output_o\;

ww_instr_debug(11) <= \instr_debug[11]~output_o\;

ww_instr_debug(12) <= \instr_debug[12]~output_o\;

ww_instr_debug(13) <= \instr_debug[13]~output_o\;

ww_instr_debug(14) <= \instr_debug[14]~output_o\;

ww_instr_debug(15) <= \instr_debug[15]~output_o\;

ww_instr_debug(16) <= \instr_debug[16]~output_o\;

ww_instr_debug(17) <= \instr_debug[17]~output_o\;

ww_instr_debug(18) <= \instr_debug[18]~output_o\;

ww_instr_debug(19) <= \instr_debug[19]~output_o\;

ww_instr_debug(20) <= \instr_debug[20]~output_o\;

ww_instr_debug(21) <= \instr_debug[21]~output_o\;

ww_instr_debug(22) <= \instr_debug[22]~output_o\;

ww_instr_debug(23) <= \instr_debug[23]~output_o\;

ww_instr_debug(24) <= \instr_debug[24]~output_o\;

ww_instr_debug(25) <= \instr_debug[25]~output_o\;

ww_instr_debug(26) <= \instr_debug[26]~output_o\;

ww_instr_debug(27) <= \instr_debug[27]~output_o\;

ww_instr_debug(28) <= \instr_debug[28]~output_o\;

ww_instr_debug(29) <= \instr_debug[29]~output_o\;

ww_instr_debug(30) <= \instr_debug[30]~output_o\;

ww_instr_debug(31) <= \instr_debug[31]~output_o\;

ww_ALU_debug(0) <= \ALU_debug[0]~output_o\;

ww_ALU_debug(1) <= \ALU_debug[1]~output_o\;

ww_ALU_debug(2) <= \ALU_debug[2]~output_o\;

ww_ALU_debug(3) <= \ALU_debug[3]~output_o\;

ww_ALU_debug(4) <= \ALU_debug[4]~output_o\;

ww_ALU_debug(5) <= \ALU_debug[5]~output_o\;

ww_ALU_debug(6) <= \ALU_debug[6]~output_o\;

ww_ALU_debug(7) <= \ALU_debug[7]~output_o\;

ww_ALU_debug(8) <= \ALU_debug[8]~output_o\;

ww_ALU_debug(9) <= \ALU_debug[9]~output_o\;

ww_ALU_debug(10) <= \ALU_debug[10]~output_o\;

ww_ALU_debug(11) <= \ALU_debug[11]~output_o\;

ww_ALU_debug(12) <= \ALU_debug[12]~output_o\;

ww_ALU_debug(13) <= \ALU_debug[13]~output_o\;

ww_ALU_debug(14) <= \ALU_debug[14]~output_o\;

ww_ALU_debug(15) <= \ALU_debug[15]~output_o\;

ww_ALU_debug(16) <= \ALU_debug[16]~output_o\;

ww_ALU_debug(17) <= \ALU_debug[17]~output_o\;

ww_ALU_debug(18) <= \ALU_debug[18]~output_o\;

ww_ALU_debug(19) <= \ALU_debug[19]~output_o\;

ww_ALU_debug(20) <= \ALU_debug[20]~output_o\;

ww_ALU_debug(21) <= \ALU_debug[21]~output_o\;

ww_ALU_debug(22) <= \ALU_debug[22]~output_o\;

ww_ALU_debug(23) <= \ALU_debug[23]~output_o\;

ww_ALU_debug(24) <= \ALU_debug[24]~output_o\;

ww_ALU_debug(25) <= \ALU_debug[25]~output_o\;

ww_ALU_debug(26) <= \ALU_debug[26]~output_o\;

ww_ALU_debug(27) <= \ALU_debug[27]~output_o\;

ww_ALU_debug(28) <= \ALU_debug[28]~output_o\;

ww_ALU_debug(29) <= \ALU_debug[29]~output_o\;

ww_ALU_debug(30) <= \ALU_debug[30]~output_o\;

ww_ALU_debug(31) <= \ALU_debug[31]~output_o\;
END structure;


