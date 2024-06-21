LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY controller IS
PORT (
 OP, Funct: IN std_logic_vector(5 downto 0);
 MemtoReg, MemWrite, MemRead, Branch, AluSrc,
 RegDst, RegWrite, Jump : OUT std_logic;
 AluControl : OUT std_logic_vector(3 downto 0));
END; -- Controller;

architecture control of controller is 
--signal
    SIGNAL BUS      :std_logic_vector(9 downto 0);
    SIGNAL ALUOP    :std_logic_vector(1 downto 0);
begin
    process(op,ALUOP)
    begin
        case op is 
            when "000000" => BUS <= "1100000100";
            when "100011" => BUS <= "1010101000";
            when "101011" => BUS <= "0X1001X000";
            when "000100" => BUS <= "0X0100X010";
            when "001000" => BUS <= "1010000000";
            when others => BUS <=   "0XXX00XXX1";

        case ALUOP is 
            when "00" =>  AluControl <= "0010";
            when "01" => AluControl  <= "0110";
            when "10" =>
                case Funct is 
                    when "100000" => AluControl <= "0010"
                    when "100010" => AluControl <= "0110"
                    when "100100" => AluControl <= "0000"
                    when "100101" => AluControl <= "0001"
                    when others => AluControl <= "0111"
                end case;
            when others=> AluControl <= "XXXX"
        end case;
    end process;
    --Assignation des sorties
    Jump <= BUS(0);
    ALUOP(0) <= BUS(1);
    ALUOP(1) <= BUS(2);
    MemtoReg <= BUS(3);
    MemWrite <= BUS(4);
    MemRead <= BUS(5);
    JBranch <= BUS(6);
    AluSrc <= BUS(7);
    RegDst <= BUS(8);
    RegWrite <= BUS(9);
    

    --Traitement de ALu control
end control;