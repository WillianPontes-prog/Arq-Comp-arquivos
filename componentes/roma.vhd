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
      0  => "00010110000000000", --LD R3 0
      1  => "00011000000000000", --LD R4 0
      2  => "00011010000011110", --LD R5 30
      3  => "00111000000000000", --MVA R4
      4  => "01010110000000000", --ADD R3
      5  => "01001000000000000", --RDA R4 
      6  => "01110110000000001", --ADDI R3 1
      7  => "01000110000000000", --RDA R3
      8  => "00111010000000000", --MVA R5
      9  => "10010111111111010", --BLE R3 -6
      10 => "00111010000000000", --MVA R5
      11 => "01001000000000000", --RDA R4
      12 => "00000000000000000",
      13 => "00000000000000000",
      14 => "00000000000000000",
      15 => "00000000000000000",
      16 => "00000000000000000",
      17 => "00000000000000000",
      18 => "00000000000000000",
      19 => "00000000000000000",
      20 => "00000000000000000",
      21 => "00000000000000000",
      22 => "00000000000000000", 
      23 => "00000000000000000", 
      24 => "00000000000000000", 
      25 => "00000000000000000", 
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