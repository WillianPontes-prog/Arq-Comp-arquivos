library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cUnit is
   port(
      opCode: in unsigned(4 downto 0);
      pcJumpEnable: in std_logic
   );
end entity cUnit;

architecture UC_a of cUnit is
   
begin

   pcJumpEnable <= '1' when opCode = '11111' else '0'

end architecture UC_a;