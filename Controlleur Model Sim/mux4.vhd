LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux4 IS
generic (
    N: integer :=32
);
PORT (
 Input_0, Input_1,Input_2,Input_3 : IN std_logic_vector(N-1 downto 0);
 sel      :  IN std_logic_vector(1 downto 0);
 out1     : OUT std_logic_vector(N-1 downto 0));
END; -- Controller;

architecture rtl of mux4 is

signal intermediaire : std_logic_vector(N-1 downto 0);

begin

    with sel select
    out1<=  Input_0 when "00", 
   Input_1 when "01" ,
   Input_2 when "10",
         Input_3 when others;    
end architecture;

