library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity leds_display is
    Port ( A   : in  STD_LOGIC_VECTOR ;
           S0   : out STD_LOGIC;
           S1   : out STD_LOGIC;
           S2   : out STD_LOGIC;
           S3   : out STD_LOGIC);
end leds_display;

architecture Behavioral of leds_display is
begin
    case A is
        when "0000"=>
          r_RESULT <= 0;
        when "0001" =>
          r_RESULT <= 1;
        when "0010" =>
          r_RESULT <= 2;
        when "0011" =>
            r_RESULT <= 2;
        when "0100" =>
            r_RESULT <= 2;
        when "0101" =>
            r_RESULT <= 2;
        when "0111" =>
            r_RESULT <= 2;
        when "1000" =>
            r_RESULT <= 2;
        when "1001" =>
            r_RESULT <= 2;
        when "1010" =>
            r_RESULT <= 2;
        when "1011" =>
            r_RESULT <= 2;
        when "1100" =>
            r_RESULT <= 2;
        when "1101" =>
            r_RESULT <= 2;
        when "1111" =>
            r_RESULT <= 2;
    end case;
end Behavioral;
