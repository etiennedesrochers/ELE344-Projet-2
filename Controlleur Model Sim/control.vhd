LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY controller IS
PORT (
 OP, Funct: IN std_logic_vector(5 downto 0);
 MemtoReg, MemWrite, MemRead, Branch, AluSrc,
 RegDst, RegWrite, Jump : OUT std_logic;
 AluControl : OUT std_logic_vector(3 downto 0));
END controller; -- Controller;

architecture control of controller is 
    SIGNAL bus_s      :std_logic_vector(9 downto 0);
    SIGNAL ALUOP    :std_logic_vector(1 downto 0);
begin
    process(op,ALUOP)
    begin
        case op is 
            when "000000" => bus_s <= "1100000100";
            when "100011" => bus_s <= "1010101000";
            when "101011" => bus_s <= "0X1001X000";
            when "000100" => bus_s <= "0X0100X010";
            when "001000" => bus_s <= "1010000000";
            when others => bus_s <=   "0XXX00XXX1";
        end case;
        case ALUOP is 
            when "00" =>  AluControl <= "0010";
            when "01" => AluControl  <= "0110";
            when "10" =>
                case Funct is 
                    when "100000" => AluControl <= "0010";
                    when "100010" => AluControl <= "0110";
                    when "100100" => AluControl <= "0000";
                    when "100101" => AluControl <= "0001";
                    when others => AluControl <= "0111";
                end case;
            when others=> AluControl <= "XXXX";
        end case;
    end process;
    --Assignation des sorties
    Jump <= bus_s(0);
    ALUOP(0) <= bus_s(1);
    ALUOP(1) <= bus_s(2);
    MemtoReg <= bus_s(3);
    MemWrite <= bus_s(4);
    MemRead <= bus_s(5);
    Branch <= bus_s(6);
    AluSrc <= bus_s(7);
    RegDst <= bus_s(8);
    RegWrite <= bus_s(9);
    

    --Traitement de ALu control
end control;