LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;
-- vsim -gui work.control_tb -do "add wave -r *;run 500ns"
ENTITY control_tb IS
  GENERIC (TAILLE : integer := 32);
END control_tb;

architecture control_tb_arc of control_tb is
   signal OP, Funct:  std_logic_vector(5 downto 0);
   signal MemtoReg, MemWrite, MemRead, Branch, AluSrc,RegDst, RegWrite, Jump :  std_logic;
   signal AluControl :  std_logic_vector(3 downto 0);
BEGIN
   Control1 : Entity work.controller
        PORT MAP (std_logic_vector(OP),std_logic_vector(Funct),(MemtoReg),(MemWrite),(MemRead),(Branch),(AluSrc),(RegDst),(RegWrite),(Jump),(AluControl));



process 
begin
   --ALUOP 00
   OP <= "100011"; 
   Funct <= "000000";

   ASSERT AluControl /= "0010" report "Erreur ALUCOntrol incorrect"; 
   wait for 20 ns;
   --ALUOP 01
   OP <= "000100"; 
   Funct <= "000000";
   ASSERT AluControl /= "0110" report "Erreur ALUCOntrol incorrect"; 
   wait for 20 ns;
   --ALUOP 10
   OP <= "000000"; 
      --FUNCT 100000
      Funct <= "100000";
      ASSERT AluControl /= "0010" report "Erreur ALUCOntrol incorrect"; 
      wait for 20 ns;
      --FUNCT 100010
      Funct <= "100010";
      ASSERT AluControl /= "0110" report "Erreur ALUCOntrol incorrect"; 
      wait for 20 ns;
      --FUNCT 100100
      Funct <= "100100";
      ASSERT AluControl /= "0000" report "Erreur ALUCOntrol incorrect"; 
      wait for 20 ns;
      --FUNCT 100101
      Funct <= "100101";
      ASSERT AluControl /= "0001" report "Erreur ALUCOntrol incorrect"; 
      wait for 20 ns;
      --FUNCT 101010
      Funct <= "101010";
      ASSERT AluControl /= "0111" report "Erreur ALUCOntrol incorrect"; 
      wait for 20 ns;
end process;
end control_tb_arc;