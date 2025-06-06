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
   type mem is array (0 to 127) of unsigned(16 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudo
      0  => "00010110000000101", --LD R3 5
      1  => "00011000000001000", --LD R4 8
      2  => "00111000000000000", --MVA R4
      3  => "01010110000000000", --ADD A R3
      4  => "01001010000000000", --RDA R5
      5  => "00100000000010100", --JMP 20
      6  => "00000000001000000",
      7  => "11111000000000011",
      8  => "00000000000000000",
      9  => "00011010000000000", --LD R5 0
      10 => "00000000000000000",
      11 => "00000000000000000",
      12 => "00000000000000000",
      13 => "00000000000000000",
      14 => "00000000000000000",
      15 => "00000000000000000",
      16 => "00000000000000000",
      17 => "00000000000000000",
      18 => "00000000000000000",
      19 => "00000000000000000",
      20 => "00111010000000000", --MVA R5
      21 => "01000110000000000", --RDA R3
      22 => "00100000000000010", --JMP 2
      23 => "00010110000000000", --LD R3 0
      -- abaixo: casos omissos => (zero em todos os bits)
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;