library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
   port(
      a, b: in std_logic_vector(15 downto 0);
      op: in std_logic_vector(1 downto 0);
      result: out std_logic_vector(15 downto 0);

      zero: out std_logic;
      neg: out std_logic;
      carry: out std_logic 
   );
end entity ALU;

architecture ALU_a of ALU is

   signal alu_result: std_logic_vector(16 downto 0);
   
begin
   alu_result <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b)) when op = "00" else
                 std_logic_vector(unsigned('0' & a) - unsigned('0' & b)) when op = "01" else
                 ('0' & a) and ('0' & b) when op = "10" else
                 ('0' & a) or ('0' & b) when op = "11";

   
   result <= alu_result(15 downto 0);

   carry <= alu_result(16) when (op = "00" or op = "01") else '0';
   
   neg <= '1' when alu_result(15) = '1' else '0';
   zero <= '1' when alu_result = "0000000000000000" else '0';

end architecture ALU_a;