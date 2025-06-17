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
      0  => "00010110000000101", --LD R3 5 -- valor pra gravar
      1  => "00010100000000000", --LD R2 0 -- reg pra regravar
      2  => "00010010000000110", --LD R1 6 -- valor do endereço
      3  => "11010110010000000", --SW R3 R1 -- carrega o valor de R3 bo endereço 6
      4  => "00000000000000000", 
      5  => "11000100010000000", --LW R2 R1 -- carrega o valor do endereço 6 em R3
      6  => "00000000000000000", 
      7  => "00000000000000000", 
      8  => "00000000000000000",
      9  => "00000000000000000", 
      10 => "00000000000000000", 
      11 => "00000000000000000", 
      12 => "00000000000000000", 
      13 => "00000000000000000", 
      14 => "00000000000000000", 
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