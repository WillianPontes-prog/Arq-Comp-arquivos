library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucewa is
   port(
        PcIn: in unsigned(15 downto 0);
        instruction: in unsigned(16 downto 0);

        state: in std_logic;

        PcWren: out std_logic;
        PcOut: out unsigned(15 downto 0)
   );
end entity ucewa;

architecture uc_a of ucewa is
   
begin

   PcOut <= "0000" & instruction(11 downto 0) when instruction(16 downto 12) = "11111" else PcIn + 1;

   PcWren <= '1' when state = '1' else '0';

end architecture uc_a;