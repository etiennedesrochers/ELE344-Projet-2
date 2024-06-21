LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux IS
PORT (
 in1, in2 : IN std_logic_vector(31 downto 0);
 sel      :  IN std_logic;
 out1     : OUT std_logic_vector(31 downto 0));
END; -- Controller;

architecture rtl of mux is

signal intermediaire : std_logic_vector(31 downto 0);

begin

    PROCESS (sel, in1, in2, out1)

    BEGIN
        
        case sel is
        
            when '0' => intermediaire <= in1;
           when others => intermediaire<=in2;
        
        end case;

    END PROCESS; 

out1 <= intermediaire;

end architecture;

