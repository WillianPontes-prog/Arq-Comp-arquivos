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
     -- caso endereco => conteudo
      0  => "00010110000000000", --LD R3 0
      1  => "00011000000000000", --LD R4 0
      2  => "00011010000011110", --LD R5 30
      3  => "00010100000000001", --LD R2 1
      4  => "00111000000000000", --MVA R4
      5  => "01010110000000000", --ADD R3
      6  => "01001000000000000", --RDA R4 
      7  => "00110100000000000", --MVA R2
      8  => "01010110000000000", --ADD R3
      9  => "01000110000000000", --RDA R3
      10 => "00111010000000000", --MVA R5
      11 => "10110110000000000", --CMP R3
      12 => "10010001111111000", --BLE -8
      13 => "00111000000000000", --MVA R4
      14 => "01001010000000000", --RDA R5
      15 => "00000000000000000",
      16 => "00000000000000000",
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