library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
   port(
      pcIn: in unsigned(15 downto 0);
      pcOut: out unsigned(15 downto 0);
   );
end entity UC;

architecture UC_a of UC is

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

end architecture UC_a;