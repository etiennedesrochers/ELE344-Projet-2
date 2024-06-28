LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC IS
PORT (
    Clk,RESET   : IN std_logic;
    PC_IN       : IN std_logic_vector(31 downto 0);
    PC_OUT      : OUT std_logic_vector(31 downto 0)
);
end;

architecture rtl of PC is
    signal PC_Value : std_logic_vector(31 downto 0);
begin
    process (Clk,RESET)
    begin
        if RESET = '1' then
            PC_Value <= (others=>'0');
        elsif rising_edge(CLK) then 
            PC_Value <= PC_IN;
        end if;             
    end process;
    PC_OUT <= PC_Value;
end architecture;