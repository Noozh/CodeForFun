--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: hito4_synthesis.vhd
-- /___/   /\     Timestamp: Mon Apr 23 13:09:22 2018
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm hito4 -w -dir netgen/synthesis -ofmt vhdl -sim hito4.ngc hito4_synthesis.vhd 
-- Device	: xc3s100e-4-cp132
-- Input file	: hito4.ngc
-- Output file	: C:\Xilinx\14.7\hito4\netgen\synthesis\hito4_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: hito4
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity hito4 is
  port (
    clk : in STD_LOGIC := 'X'; 
    BTN_A : in STD_LOGIC := 'X'; 
    BTN_B : in STD_LOGIC := 'X'; 
    BTN_C : in STD_LOGIC := 'X'; 
    BTN_D : in STD_LOGIC := 'X'; 
    Reset : in STD_LOGIC := 'X'; 
    LED : out STD_LOGIC 
  );
end hito4;

architecture Structure of hito4 is
  signal BTN_A_IBUF_1 : STD_LOGIC; 
  signal BTN_B_IBUF_3 : STD_LOGIC; 
  signal BTN_C_IBUF_5 : STD_LOGIC; 
  signal BTN_REG1_A_6 : STD_LOGIC; 
  signal BTN_REG1_B_7 : STD_LOGIC; 
  signal BTN_REG1_C_8 : STD_LOGIC; 
  signal BTN_REG2_A_9 : STD_LOGIC; 
  signal BTN_REG2_B_10 : STD_LOGIC; 
  signal BTN_REG2_C_11 : STD_LOGIC; 
  signal LED_OBUF_13 : STD_LOGIC; 
  signal Reset_IBUF_15 : STD_LOGIC; 
  signal clk_BUFGP_17 : STD_LOGIC; 
  signal estado_sig_mux0005_0_113_27 : STD_LOGIC; 
  signal estado_sig_mux0005_0_117_28 : STD_LOGIC; 
  signal estado_sig_or0000 : STD_LOGIC; 
  signal estado_actual : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal estado_sig : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal estado_sig_mux0005 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
begin
  BTN_REG2_A : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_A_IBUF_1,
      Q => BTN_REG2_A_9
    );
  BTN_REG2_B : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_B_IBUF_3,
      Q => BTN_REG2_B_10
    );
  BTN_REG2_C : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_C_IBUF_5,
      Q => BTN_REG2_C_11
    );
  BTN_REG1_A : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_REG2_A_9,
      Q => BTN_REG1_A_6
    );
  BTN_REG1_B : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_REG2_B_10,
      Q => BTN_REG1_B_7
    );
  BTN_REG1_C : FDC
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => BTN_REG2_C_11,
      Q => BTN_REG1_C_8
    );
  estado_sig_0 : LD
    generic map(
      INIT => '1'
    )
    port map (
      D => estado_sig_mux0005(0),
      G => estado_sig_or0000,
      Q => estado_sig(0)
    );
  estado_sig_1 : LD
    generic map(
      INIT => '0'
    )
    port map (
      D => estado_sig_mux0005(1),
      G => estado_sig_or0000,
      Q => estado_sig(1)
    );
  estado_sig_2 : LD
    generic map(
      INIT => '0'
    )
    port map (
      D => estado_sig_mux0005(2),
      G => estado_sig_or0000,
      Q => estado_sig(2)
    );
  estado_sig_3 : LD
    generic map(
      INIT => '0'
    )
    port map (
      D => estado_sig_mux0005(3),
      G => estado_sig_or0000,
      Q => estado_sig(3)
    );
  estado_actual_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => estado_sig(3),
      Q => estado_actual(3)
    );
  estado_actual_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => estado_sig(1),
      Q => estado_actual(1)
    );
  estado_actual_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => clk_BUFGP_17,
      D => estado_sig(0),
      PRE => Reset_IBUF_15,
      Q => estado_actual(0)
    );
  estado_actual_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_17,
      CLR => Reset_IBUF_15,
      D => estado_sig(2),
      Q => estado_actual(2)
    );
  estado_sig_mux0005_3_1 : LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => BTN_REG2_B_10,
      I1 => BTN_REG1_B_7,
      I2 => estado_actual(2),
      O => estado_sig_mux0005(3)
    );
  estado_sig_mux0005_2_1 : LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => BTN_REG2_A_9,
      I1 => BTN_REG1_A_6,
      I2 => estado_actual(1),
      O => estado_sig_mux0005(2)
    );
  estado_sig_mux0005_0_113 : LUT4
    generic map(
      INIT => X"F5C4"
    )
    port map (
      I0 => BTN_REG1_B_7,
      I1 => estado_actual(3),
      I2 => BTN_REG2_B_10,
      I3 => estado_actual(2),
      O => estado_sig_mux0005_0_113_27
    );
  estado_sig_mux0005_0_117 : LUT4
    generic map(
      INIT => X"F8FA"
    )
    port map (
      I0 => estado_actual(1),
      I1 => BTN_REG2_A_9,
      I2 => estado_sig_mux0005_0_113_27,
      I3 => BTN_REG1_A_6,
      O => estado_sig_mux0005_0_117_28
    );
  estado_sig_or00001 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => estado_actual(2),
      I1 => estado_actual(3),
      I2 => estado_actual(0),
      I3 => estado_actual(1),
      O => estado_sig_or0000
    );
  BTN_A_IBUF : IBUF
    port map (
      I => BTN_A,
      O => BTN_A_IBUF_1
    );
  BTN_B_IBUF : IBUF
    port map (
      I => BTN_B,
      O => BTN_B_IBUF_3
    );
  BTN_C_IBUF : IBUF
    port map (
      I => BTN_C,
      O => BTN_C_IBUF_5
    );
  Reset_IBUF : IBUF
    port map (
      I => Reset,
      O => Reset_IBUF_15
    );
  LED_OBUF : OBUF
    port map (
      I => LED_OBUF_13,
      O => LED
    );
  estado_sig_mux0005_1_1 : LUT4
    generic map(
      INIT => X"4440"
    )
    port map (
      I0 => BTN_REG2_C_11,
      I1 => BTN_REG1_C_8,
      I2 => estado_actual(0),
      I3 => estado_sig_mux0005_0_117_28,
      O => estado_sig_mux0005(1)
    );
  estado_sig_mux0005_0_2 : LUT4
    generic map(
      INIT => X"F5C4"
    )
    port map (
      I0 => BTN_REG1_C_8,
      I1 => estado_actual(0),
      I2 => BTN_REG2_C_11,
      I3 => estado_sig_mux0005_0_117_28,
      O => estado_sig_mux0005(0)
    );
  LED1 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => estado_actual(2),
      I1 => estado_actual(3),
      I2 => estado_actual(0),
      I3 => estado_actual(1),
      O => LED_OBUF_13
    );
  clk_BUFGP : BUFGP
    port map (
      I => clk,
      O => clk_BUFGP_17
    );

end Structure;

