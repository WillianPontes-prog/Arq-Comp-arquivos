library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUla is
   port(
      a, b: unsigned(15 downto 0);
      op: in unsigned(1 downto 0);
      signedON: in std_logic;

      result: out unsigned(15 downto 0);

      zero: out std_logic;
      neg: out std_logic;
      carry: out std_logic 
   );
end entity ALUla;

architecture ALU_a of ALUla is

   signal alu_result: unsigned(16 downto 0); 
   signal alu_result_signed: signed(16 downto 0); 

begin

   alu_result <= (('0' & a) + ('0' & b)) when op = "00" else
                 (('0' & a) - ('0' & b)) when op = "01" else
                 ("0" & a) and ('0' & b) when op = "10" else
                 ("0" & a) or ('0' & b) when op = "11";

   alu_result_signed <= (signed('0' & a) + signed('0' & b)) when op = "00" else
                        (signed('0' & a) - signed('0' & b)) when op = "01" else
                        (signed("0" & a) and signed('0' & b)) when op = "10" else
                        (signed("0" & a) or  signed('0' & b)) when op = "11";

   result <= alu_result(15 downto 0) when signedON = '0' else
             unsigned(alu_result_signed(15 downto 0));

   carry <= alu_result(16) when (op = "00" or op = "01") else '0';

   neg <= alu_result(15) when signedON = '0' else alu_result_signed(15);

   zero <= '1' when (alu_result(15 downto 0) = "0000000000000000" and signedON = '0') or
                   (alu_result_signed(15 downto 0) = "0000000000000000" and signedON = '1')
            else '0';

end architecture ALU_a;