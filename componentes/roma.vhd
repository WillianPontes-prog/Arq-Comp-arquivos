library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity roma is
   port( clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         dado     : out unsigned(16 downto 0) 
   );
end entity;
architecture a_rom of roma is

      -- Aliases para os opcodes
   constant OPCODE_NOP    : unsigned(3 downto 0) := "0000";
   constant OPCODE_LD     : unsigned(3 downto 0) := "0001";
   constant OPCODE_JMP    : unsigned(3 downto 0) := "0010";
   constant OPCODE_MOVA   : unsigned(3 downto 0) := "0011";
   constant OPCODE_READA  : unsigned(3 downto 0) := "0100";
   constant OPCODE_ADD    : unsigned(3 downto 0) := "0101";
   constant OPCODE_SUB    : unsigned(3 downto 0) := "0110";
   constant OPCODE_ADDI   : unsigned(3 downto 0) := "0111";
   constant OPCODE_BLE    : unsigned(3 downto 0) := "1001";
   constant OPCODE_BCS    : unsigned(3 downto 0) := "1010";
   constant OPCODE_CMP    : unsigned(3 downto 0) := "1011";
   constant OPCODE_LW    : unsigned(3 downto 0)  := "1100";
   constant OPCODE_SW    : unsigned(3 downto 0)  := "1101";
   constant OPCODE_ORI    : unsigned(3 downto 0) := "1110";
   constant OPCODE_MOV    : unsigned(3 downto 0) := "1111";

   constant NOP : unsigned(16 downto 0) := "00000000000000000"; -- NOP

   constant regPontRam : unsigned(2 downto 0) := "000"; -- R0
   constant regComp   : unsigned(2 downto 0) := "001"; -- R1
   constant regCompRaizPraBaixo : unsigned(2 downto 0) := "010"; -- R2
   constant regTrue  : unsigned(2 downto 0) := "011"; -- R3
   constant regFalse : unsigned(2 downto 0) := "100"; -- R4
   constant regPrimo : unsigned(2 downto 0) := "101"; -- R5

   type mem is array (0 to 127) of unsigned(16 downto 0);
   constant conteudo_rom : mem := (
      0  => OPCODE_LD & regPontRam & "0000000010",         
      1  => OPCODE_LD & regComp & "0000100000",            
      2  => OPCODE_LD & regCompRaizPraBaixo & "0000000110",
      3  => OPCODE_LD & regTrue & "0000000001",            
      4  => OPCODE_LD & regFalse & "0000000000",   

      5  => OPCODE_SW & regFalse & regFalse & "0000000",
      6  => OPCODE_SW & regFalse & regTrue & "0000000",

      7  => OPCODE_SW & regPontRam & regPontRam & "0000000",
      8  => OPCODE_ADDI & regPontRam & "0000000001",
      9  => OPCODE_READA & regPontRam & "0000000000",
      10 => OPCODE_MOVA & regComp & "0000000000",
      11 => OPCODE_CMP & regPontRam & "0000000000",
      12 => OPCODE_BLE & "111" & "1111111011",

      13 => OPCODE_LD & regPrimo & "0000000010",

      14 => OPCODE_MOV & regPontRam & regPrimo & "0000000", --praca

      15 => OPCODE_MOVA & regPrimo & "0000000000",
      16 => OPCODE_ADD & regPontRam & "0000000000",
      17 => OPCODE_READA & regPontRam & "0000000000",
      18 => OPCODE_SW & regFalse & regPontRam & "0000000",
      19 => OPCODE_ORI & regPontRam & "0000011111", --para validação ORI para saida do loop
      20 => OPCODE_CMP & regComp & "0000000000",
      21 => OPCODE_BCS & "000" & "0000000010",
      22 => OPCODE_JMP & "000" & "0000001111",
      23 => OPCODE_ADDI & regPrimo & "0000000001",
      24 => OPCODE_READA & regPrimo & "0000000000",
      25 => OPCODE_MOVA & regPrimo & "0000000000",
      26 => OPCODE_CMP & regCompRaizPraBaixo & "0000000000",
      27 => OPCODE_BCS & "000" & "0000000010", 
      28 => OPCODE_JMP & "000" & "0000001110", --praca
      29 => NOP,

      30 => OPCODE_LD & regPontRam & "0000000010",
      31 => OPCODE_LD & regComp & "0000100000",

      32 => OPCODE_LW & regCompRaizPraBaixo & regPontRam & "0000000",
      33 => OPCODE_ADDI & regPontRam & "0000000001",
      34 => OPCODE_READA & regPontRam & "0000000000",
      35 => OPCODE_MOVA & regComp & "0000000000",
      36 => OPCODE_CMP & regPontRam & "0000000000",
      37 => OPCODE_BLE & "111" & "1111111011",
      others => NOP 
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;