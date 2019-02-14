----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    11:45:17 04/23/2018
-- Design Name:
-- Module Name:    hito3 - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity hito4 is
    Port ( Reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           BTN_A : in  STD_LOGIC;
           BTN_B : in  STD_LOGIC;
           BTN_C : in  STD_LOGIC;
           BTN_D : in  STD_LOGIC;
           LED : out  STD_LOGIC);
end hito4;



architecture Behavioral of hito4 is
        signal BTN_REG2_A : std_logic;
        signal BTN_REG2_B : std_logic;
        signal BTN_REG2_C : std_logic;
        signal BTN_REG2_D : std_logic;
        signal BTN_REG1_A : std_logic;
        signal BTN_REG1_B : std_logic;
        signal BTN_REG1_C : std_logic;
        signal BTN_REG1_D : std_logic;
        signal PULSO_BTN_A : STD_LOGIC;
        signal PULSO_BTN_B : STD_LOGIC;
        signal PULSO_BTN_C : STD_LOGIC;
        signal PULSO_BTN_D : STD_LOGIC;
        signal NO_BTN : std_logic;

        type estados is (INIT, det_C ,det_CA, det_CAB, det_CABB);
        signal estado_actual: estados ;
        signal estado_sig: estados ;

begin
	P_BIEST_1: PROCESS (Reset, Clk)
	begin
		if Reset = '1' then
			BTN_REG2_A <= '0';
			BTN_REG2_B <= '0';
			BTN_REG2_C <= '0';
			BTN_REG2_D <= '0';
		elsif Clk'event and Clk = '1' then
			BTN_REG2_A <= BTN_A;
			BTN_REG2_B <= BTN_B;
			BTN_REG2_C <= BTN_C;
			BTN_REG2_D <= BTN_D;
		end if;
	end process;

	P_BIEST_2: PROCESS (Reset, Clk)
	begin
		if Reset = '1' then
			BTN_REG1_A <= '0';
			BTN_REG1_B <= '0';
			BTN_REG1_C <= '0';
			BTN_REG1_D <= '0';
		elsif Clk'event and Clk = '1' then
			BTN_REG1_A <= BTN_REG2_A ;
			BTN_REG1_B <= BTN_REG2_B ;
			BTN_REG1_C <= BTN_REG2_C ;
			BTN_REG1_D <= BTN_REG2_D ;
		end if;
	end process;

	PULSO_BTN_A <= '1'  when (BTN_REG1_A = '1' and BTN_REG2_A = '0') else '0';
	PULSO_BTN_B <= '1'  when (BTN_REG1_B = '1' and BTN_REG2_B = '0') else '0';
	PULSO_BTN_C <= '1'  when (BTN_REG1_C = '1' and BTN_REG2_C = '0') else '0';
	PULSO_BTN_D <= '1'  when (BTN_REG1_D = '1' and BTN_REG2_D = '0') else '0';

    NO_BTN <= '1' when (PULSO_BTN_A = '0' and PULSO_BTN_B = '0' and PULSO_BTN_C = '0'
	and PULSO_BTN_D = '0') else '0';

COMB: process (estado_actual,PULSO_BTN_A, PULSO_BTN_B, PULSO_BTN_C, PULSO_BTN_D, NO_BTN)
 --estado_actual <= INIT
begin
	case estado_actual is 	when INIT =>
		if NO_BTN = '1' then
			estado_sig <= estado_actual;
		else
			if PULSO_BTN_C = '1' then
				estado_sig <= det_C;
			else
				estado_sig <= INIT;
			end if;
		end if;
		LED <= '0';
	when  det_C =>
		if NO_BTN = '1' then
			estado_sig <= estado_actual;
		else
			if PULSO_BTN_A = '1' then
				estado_sig <= det_CA;
			elsif PULSO_BTN_C ='1' then
				estado_sig <= det_C;
			else
				estado_sig <= INIT;
			end if;
		end if;
		LED <= '0';
	when  det_CA =>
		if NO_BTN = '1' then
			estado_sig <= estado_actual;
		else
			if PULSO_BTN_B = '1' then
				estado_sig <= det_CAB;
			elsif PULSO_BTN_C ='1' then
				estado_sig <= det_C;
			else
				estado_sig <= INIT;
			end if;
		end if;
		LED <= '0';
	when  det_CAB =>
		if NO_BTN = '1' then
			estado_sig <= estado_actual;
		else
			if PULSO_BTN_B = '1' then
				estado_sig <= det_CABB;
			elsif PULSO_BTN_C ='1' then
				estado_sig <= det_C;
			else
				estado_sig <= INIT;
			end if;
		end if;
		LED <= '0';
	when det_CABB =>
        if NO_BTN = '1' then
            estado_sig <= det_CABB;
        else
            if (PULSO_BTN_C = '1') then
                estado_sig <= det_C;
            else
                estado_sig <= INIT;
            end if;
        end if;
		LED <= '1';
    when others =>
        LED <= '0';
	end case;
end process;

sec: process (Reset, clk)
begin
	if Reset = '1' then
 		estado_actual <= init;
	elsif clk'event and clk='1' then
		estado_actual <= estado_sig;
	end if;
end process;

end Behavioral;
