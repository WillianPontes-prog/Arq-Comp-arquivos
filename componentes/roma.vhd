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
      3  => "11010110010000000", --SW R3 R1 -- carrega o valor de R3 no endereço 6
      4  => "11000100010000000", --LW R2 R1 -- carrega o valor do endereço 6 em R3
      5  => "01110010000000001", --ADDI R1 1 
      6  => "01000010000000000", --READA R1 
      7  => "01110110000000001", --ADDI R3 1
      8  => "01000110000000000", --READA R3
      9  => "00010000000001010", --LD R0 10 
      10 => "00110000000000000", --MVA R0
      11 => "10110100000000000", --CMP R2
      12 => "10010001111110111", --BLE -9
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