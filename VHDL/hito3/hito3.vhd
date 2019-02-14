----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:41 04/18/2018 
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

entity hito3 is
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           A : in  STD_LOGIC;
			  LED : out STD_LOGIC);
end hito3;

architecture Behavioral of hito3 is
	signal BTN_REG2 : std_logic; 
	signal BTN_REG1 : std_logic;
	signal q_t : std_logic;
	signal PULSO_BTN0 : STD_LOGIC;
	
	
begin
	
	P_BIEST_1: PROCESS (Reset, Clk)
	begin
		if Reset = '1' then
			BTN_REG2 <= '0';
		elsif Clk'event and Clk = '1' then
			BTN_REG2 <= A;
		end if;
	end process;
	
	P_BIEST_2: PROCESS (Reset, Clk)
	begin
		if Reset = '1' then
			BTN_REG1 <= '0';
		elsif Clk'event and Clk = '1' then
			BTN_REG1 <= BTN_REG2 ;
		end if;
	end process;
	
	PULSO_BTN0 <= '1' when (BTN_REG1 = '1' and BTN_REG2 = '0') else '0';
	
	P_BIEST_T: PROCESS (Reset, Clk)
	
	begin
		if Reset = '1' then
			q_t <= '0';
		elsif Clk'event and Clk = '1' then
			if PULSO_BTN0 = '1' then
				q_t <= not (q_t);
			end if;
		end if;

	end process; 
	
	LED <= q_t;
	
	

end Behavioral;

