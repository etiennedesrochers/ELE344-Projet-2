LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux IS
generic (
    N: integer :=32
);
PORT (
 Input_0, Input_1 : IN std_logic_vector(N-1 downto 0);
 sel      :  IN std_logic;
 out1     : OUT std_logic_vector(N-1 downto 0));
END; -- Controller;

architecture rtl of mux is

signal intermediaire : std_logic_vector(N-1 downto 0);

begin

    PROCESS (sel, Input_0, Input_1)

    BEGIN
        
        case sel is
            when '0' => intermediaire <= Input_0;
            when others => intermediaire<=Input_1;
        end case;

    END PROCESS; 

out1 <= intermediaire;

end architecture;

