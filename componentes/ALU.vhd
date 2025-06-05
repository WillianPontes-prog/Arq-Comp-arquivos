library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUla is
   port(
      a, b: unsigned(15 downto 0);
      op: in unsigned(1 downto 0);
      result: out unsigned(15 downto 0);

      zero: out std_logic;
      neg: out std_logic;
      carry: out std_logic 
   );
end entity ALUla;

architecture ALU_a of ALUla is

   signal alu_result: unsigned(16 downto 0);
   
begin
   alu_result <= (('0' & a) + ('0' & b)) when op = "00" else
                 (('0' & a) - ('0' & b)) when op = "01" else
                 ("0" & a) and ('0' & b) when op = "10" else
                 ("0" & a) or ('0' & b) when op = "11";

   
   result <= alu_result(15 downto 0);

   carry <= alu_result(16) when (op = "00" or op = "01") else '0';
   
   neg <= '1' when alu_result(15) = '1' else '0';
   zero <= '1' when alu_result = "0000000000000000" else '0';

end architecture ALU_a;