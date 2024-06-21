LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_path IS
PORT (
    CLK,RESET,MemToReg,Branch,AluSrc,
    RegDstRegWrite,Jump,MemReadIn,MemWriteIn     : IN std_logic;
    AluControl                                   : IN std_logic_vector(3 downto 0);
    Instruction,ReadData                         : IN std_logic_vector(31 downto 0);
    MemReadOut, MemWriteOut                      : OUT std_logic;
    PC,AluResult,WriteData                       : OUT std_logic_vector(31 downto 0)
);
end;

architecture rtl of data_path is
    signal PC_NEXT              : std_logic_vector(31 downto 0);
    signal PC_O                 : std_logic_vector(31 downto 0);
    signal PC_PLUS_4            : std_logic_vector(31 downto 0);
    signal Instruction_Shift_l2 : std_logic_vector(27 downto 0);
    signal PC_JUMP              : std_logic_vector(31 downto 0);
begin
    
    PC_entity : Entity work.PC
    PORT MAP (CLK,RESET,PC_NEXT,PC_O);
    
    PCPlus4_inst: entity work.PC_Plus4
    PORT MAP(PC_O,PC_PLUS_4);

    --SHIFT LEFT 2
    Instruction_Shift_l2 <= (Instruction(25 downto 0)) & ("00");
    --Combine les signaux de PCPLUS 4 et instruction shift left 2
    PC_JUMP <= (PC_PLUS_4(31 downto 28) &(Instruction_Shift_l2));

    --Additionneur pcplus 4 et signImmsh
    
    PC <= PC_O;
end architecture;
