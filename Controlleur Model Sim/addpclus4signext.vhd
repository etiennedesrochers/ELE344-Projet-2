LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity addpclus4signext is
    port (
        PCPLUS4 : in std_logic_vector(31 downto 0);
        IMMSIGN : in std_logic_vector(31 downto 0);
        PCBranch: OUT std_logic_vector(31 downto 0)
    );
end;

architecture rtl of addpclus4signext is
    signal addSign : unsigned(31 downto 0);
begin
    process(PCPLUS4)
    begin
        addSign <= unsigned(PCPLUS4) + unsigned(IMMSIGN);
    end process;
    PCBranch <=  std_logic_vector(addSign);
end architecture;