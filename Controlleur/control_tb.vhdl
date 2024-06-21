LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;

ENTITY control_tb IS
  GENERIC (TAILLE : integer := 32);
END control_tb;

architecture control_tb_arc of control_tb is
   signal OP, Funct: IN std_logic_vector(5 downto 0);
   signal MemtoReg, MemWrite, MemRead, Branch, AluSrc,RegDst, RegWrite, Jump : OUT std_logic;
   signal AluControl : OUT std_logic_vector(3 downto 0));

   Control1 : Entity work.controller
        PORT MAP (std_logic_vector(OP),std_logic_vector(Funct),std_logic(MemtoReg),std_logic(MemWrite),std_logic(MemRead),
        std_logic(Branch),std_logic(AluSrc),std_logic(RegDst),std_logic(RegWrite),std_logic(Jump),std_logic_vector(AluControl));
end control_tb_arc;


process 
begin
    OP <= "0000000";
    Funct <= "100000"
    wait 20 ns;
end process;