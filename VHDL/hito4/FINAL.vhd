----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:51 04/18/2018 
-- Design Name: 
-- Module Name:    FINAL - Behavioral 
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

entity FINAL is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Zout : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC);
end FINAL;

architecture FINAL of FINAL is

 
 Type estados is (inic, estd_b, estd_ba, estd_bad, estd_badd);
 Signal estado_actual, estado_siguiente: estados;
 Signal NP, BTNA, BTNB, BTNC, BTND, BTNA2, BTNB2, BTNC2, BTND2 : std_logic;
 Signal PULSO_BTNA, PULSO_BTNB, PULSO_BTNC, PULSO_BTND: std_logic;
 
begin

--REGISTRO DE BOTON
---------------------------------
	P_D1: Process (RESET, CLK)
	begin

	if (RESET = '1') then
		BTNA <= '0';
		BTNB <= '0';
		BTNC <= '0';
		BTND <= '0';
	elsif (CLK'event and CLK='1') then
		BTNA <= A;
		BTNB <= B;
		BTNC <= C;
		BTND <= D;
	end if;

	end process;

	P_D2: Process (RESET, CLK)
	begin

	if (RESET = '1') then
		BTNA2 <= '0';
		BTNB2 <= '0';
		BTNC2 <= '0';
		BTND2 <= '0';
	elsif (CLK'event and CLK='1') then
		BTNA2 <= BTNA;
		BTNB2 <= BTNB;
		BTNC2 <= BTNC;
		BTND2 <= BTND;
	end if;

	end process; 

	
	PULSO_BTNA <= '1' when (BTNA = '1' and BTNA2 = '0') else '0';
	PULSO_BTNB <= '1' when (BTNB = '1' and BTNB2 = '0') else '0';
	PULSO_BTNC <= '1' when (BTNC = '1' and BTNC2 = '0') else '0';
	PULSO_BTND <= '1' when (BTND = '1' and BTND2 = '0') else '0';
	
	NP <= '1' when (PULSO_BTNA = '0' and PULSO_BTNB = '0' and PULSO_BTNC = '0' 
	and PULSO_BTND = '0') else '0';
	
--------------------

	P_Secuencial: Process (CLK, RESET)
	begin
		if (RESET = '1') then
			estado_actual <= inic; 
		elsif (CLK'event and CLK='1') then
			estado_actual <= estado_siguiente;
		end if;
	end process;


	P_Comb: Process (estado_actual, PULSO_BTNA, PULSO_BTNB, PULSO_BTNC, PULSO_BTND, NP)
	begin
	case estado_actual is
		when inic => 
			if (NP = '1') then
				estado_siguiente <= inic;
			else
				if (PULSO_BTNB = '1') then
					estado_siguiente <= estd_b;
				else
					estado_siguiente <= inic;
				end if;
			end if;
		
		when estd_b =>
			if (NP = '1') then
				estado_siguiente <= estd_b;
			else
				if (PULSO_BTNA = '1') then
					estado_siguiente <= estd_ba;
				else
					estado_siguiente <= inic;
				end if;
			end if;
		
		when estd_ba =>
			if (NP = '1') then
				estado_siguiente <= estd_ba;
			else 
				if (PULSO_BTND = '1') then
					estado_siguiente <= estd_bad;
				else
					estado_siguiente <= inic;
				end if;
			end if;
		
		when estd_bad =>
			if (NP = '1') then
				estado_siguiente <= estd_bad;
			else
				if (PULSO_BTND = '1') then
					estado_siguiente <= estd_badd;
				else
					estado_siguiente <= inic;
				end if;
			end if;
		
		when (estd_badd) =>
			if NP = '1' then
				estado_siguiente <= estd_badd;
			else
				if (PULSO_BTNC = '1') then
					estado_siguiente <= inic;
				else
					estado_siguiente <= inic;
				end if;
			end if;
	
		when others => 
			estado_siguiente <= inic;
		end case;
		
	end process;


	P_Salidas: Process (estado_actual)
	begin
		case estado_actual is
			when inic =>
				Zout <= '0' ;
			when estd_b =>
				Zout <= '0' ;
			when estd_ba =>
				Zout <= '0' ;
			when estd_bad =>
				Zout <= '0' ;
			when estd_badd =>
				Zout <= '1' ;
			when others =>
				Zout <= '0' ;
		end case;
	end process;
	
end FINAL;