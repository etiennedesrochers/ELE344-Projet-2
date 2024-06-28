LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_path IS
PORT (
    CLK,RESET,MemToReg,Branch,AluSrc,
    RegDst,RegWrite,Jump,MemReadIn,MemWriteIn     : IN std_logic;
    AluControl                                   : IN std_logic_vector(3 downto 0);
    Instruction,ReadData                         : IN std_logic_vector(31 downto 0);
    MemReadOut, MemWriteOut                      : OUT std_logic;
    PC,AluResult,WriteData                       : OUT std_logic_vector(31 downto 0)
);
end;

architecture rtl of data_path is
    signal PC_NEXT              : std_logic_vector(31 downto 0);
    signal PC_NEXT_BR           : std_logic_vector(31 downto 0);
    signal PC_O                 : std_logic_vector(31 downto 0);
    signal PC_PLUS_4            : std_logic_vector(31 downto 0);
    signal Instruction_Shift_l2 : std_logic_vector(27 downto 0);
    signal PC_JUMP              : std_logic_vector(31 downto 0);
    signal IMMSIGN              : std_logic_vector(31 downto 0);
    signal PCBRANCH             : std_logic_vector(31 downto 0);
    signal READDATA1            : std_logic_vector(31 downto 0);
    signal READDATA2            : std_logic_vector(31 downto 0);
    signal WRITEREGISTER        : std_Logic_vector(31 downto 0);
    signal RESULTALU            : std_Logic_vector(31 downto 0);
    signal REGISTERDEST         : std_logic_vector(31 downto 0);
    signal MUX4_VAL             : std_logic_vector(31 downto 0);
    signal Instruction_Extend   : std_logic_vector(31 downto 0);
    signal Instruction_Extend32 : std_logic_vector(31 DOWNTO 0);    
    signal RESULT               : std_logic_vector(31 downto 0);
    signal SignImmSh            : std_logic_vector(31 downto 0);
    signal Zero                 : std_logic;
    signal Cout                 : std_logic;
    signal PCSrc                : std_logic;

begin                   
    
    PC_entity : Entity work.PC
    PORT MAP (CLK,RESET,PC_NEXT,PC_O);
    
    PCPlus4_inst: entity work.PC_Plus4
    PORT MAP(PC_O,PC_PLUS_4);

    --SHIFT LEFT 2
    Instruction_Shift_l2 <= (Instruction(25 downto 0)) & ("00");
    --SHIFT LEFT 16 to 32
    Instruction_Shift_l2 <= (Instruction(15 downto 0)) & (others =>'0');
    --Combine les signaux de PCPLUS 4 et instruction shift left 2
    PC_JUMP <= (PC_PLUS_4(31 downto 28) &(Instruction_Shift_l2));

    PCSrc <= Branch and Zero;
    --Additionneur pcplus 4 et signImmsh
    SignImmSh <= (IMMSIGN(29 downto 0)) & (others => '0');
    addpclus4signext_inst: entity work.addpclus4signext
    PORT MAP(PCPLUS4 => PC_PLUS_4,IMMSIGN => SignImmSh,PCBranch => PCBRANCH);

    --mutiplexeur pour pcnextbr (1)
   mux_inst: entity work.mux
    port map(
        Input_0 => PC_PLUS_4,
        Input_1 => PCBRANCH,
        sel => PCSrc,
        out1 => PC_NEXT_BR
   );
    --multiplexeur pour pc next (2)
    mux2_inst: entity work.mux
     port map(
        Input_0 => PC_NEXT_BR,
        Input_1 => PC_JUMP,
        sel => JUMP,
        out1 => PC_NEXT
    );
    --Multiplexeur pour la valeur de write register (WRITEREGISTER)
    mux3_inst: entity work.mux
     port map(
        Input_0 => Instruction(20 downto 16),
        Input_1 => Instruction(15 downto 11),
        sel => RegDst,
        out1 => WRITEREGISTER
    );
    --Registre 
    RegFile_inst: entity work.RegFile
     port map(
        clk => clk,
        we => RegWrite,
        ra1 => Instruction(25 downto 21),
        ra2 => Instruction(20 downto 16),
        wa => WRITEREGISTER,
        wd => RESULT,
        rd1 => READDATA1,
        rd2 => READDATA2
    );

    
    
    
    mux4_inst: entity work.mux
     port map(
        Input_0 => READDATA2,
        Input_1 => Instruction_Shift_l2,
        sel => AluSrc,
        out1 => MUX4_VAL
    );
    --alu 
    UAL_inst: entity work.UAL
     generic map(
        N => 32
    )
     port map(
        ualControl => AluControl,
        srcA => READDATA1,
        srcB => MUX4_VAL,
        result => RESULTALU,
        cout => cout,
        zero => zero
    );
    mux5_inst: entity work.mux
    port map (
        Input_0  => RESULTALU,
        Input_1  => ReadData,
        sel  => MemToReg,
        out1 => RESULT
    );
    PC <= PC_O;
    WriteData<= READDATA2;
    AluResult <= RESULTALU;
    MemReadOut <= MemReadIn;
    MemWriteOut <= MemWriteIn;
end architecture;
