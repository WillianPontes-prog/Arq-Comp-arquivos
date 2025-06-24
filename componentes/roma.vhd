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
      0  => "00010110000000101", --LD R3 5 
      1  => "11100110000010110", --ORI R3 22 
      2  => "01000010000000000", --RDA R1 
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