library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2chan is
    Port ( SEL : in  STD_LOGIC_VECTOR (3 downto 0);
           A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           ZOUT   : out STD_LOGIC_VECTOR (3 downto 0));
end mux_2chan;

architecture Behavioral of mux_2chan is
begin
    ZOUT <=A WHEN (SEL = '0') ELSE B;
end Behavioral;
