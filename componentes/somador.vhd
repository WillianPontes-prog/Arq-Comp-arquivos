library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
   port(
        pcIn: in unsigned(15 downto 0);
        pcOut: out unsigned(15 downto 0)
   );
end entity somador;

architecture somador_a of somador is
   
begin

    pcOut <= pcIn + 1;

end architecture somador_a;