library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cUnit is
   port(
      pcIn: in unsigned(15 downto 0);
      pcOut: out unsigned(15 downto 0)
   );
end entity cUnit;

architecture UC_a of cUnit is

   signal PC_result: unsigned(15 downto 0);
   
begin
   PC_result <= pcIn + 1;

   pcOut <= PC_result;

end architecture UC_a;