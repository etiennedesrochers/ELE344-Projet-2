LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mips is
    port (
        clk                     : in std_logic;
        reset                   : in std_logic;
        ReadData                : in std_logic_vector (31 downto 0);
        Instruction             : in std_logic_vector (31 downto 0);
        MemRead                 : out std_logic;
        MemWrite                : out std_logic;
        PC                      : out std_logic_vector(31 downto 0);
        WriteData               : out std_logic_vector(31 downto 0);
        AluResult               : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of mips is
  signal SignalDeControl : std_logic_vector(3 downto 0);
begin

    controller_inst: entity work.controller
    port map (
      OP         => Instruction(31 downto 25),
      Funct      => Instruction(),
      MemtoReg   => MemtoReg,
      MemWrite   => MemWrite,
      MemRead    => MemRead,
      Branch     => Branch,
      AluSrc     => AluSrc,
      RegDst     => RegDst,
      RegWrite   => RegWrite,
      Jump       => Jump,
      AluControl => AluControl
    );
end architecture;