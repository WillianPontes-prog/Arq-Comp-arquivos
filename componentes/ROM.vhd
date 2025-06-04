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
      0  => "00000000000000010",
      1  => "00000100000000000",
      2  => "11111000000000101",
      3  => "00000000000000000",
      4  => "10000000000000000",
      5  => "00000000000000010",
      6  => "11110000001000001",
      7  => "00000000001000000",
      8  => "11111000000000011",
      9  => "00000000000000000",
      10 => "00000000000000000",
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