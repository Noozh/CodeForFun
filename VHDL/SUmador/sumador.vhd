     library IEEE;
     use IEEE.STD_LOGIC_1164.all;
     use IEEE.NUMERIC_STD.all;

     ENTITY sum IS
       PORT (a : IN std_logic_vector(3 DOWNTO 0);
             b : IN std_logic_vector(3 DOWNTO 0);
             salida : OUT std_logic_vector(4 DOWNTO 0));
     END sum;

     ARCHITECTURE synth OF sum IS
     BEGIN
       PROCESS (a, b) IS
           BEGIN
             salida <= std_logic_vector(UNSIGNED(a) + UNSIGNED(b));
           END PROCESS;
     END synth;
