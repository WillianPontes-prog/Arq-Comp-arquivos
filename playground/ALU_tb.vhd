library ieee;
use ieee.std_logic_1164.all;
-- a entidade tem o mesmo nome do arquivo
entity ALU_tb is
end;

architecture a_ALU_tb of ALU_tb is
    component ALU
        port(
        a, b: in std_logic_vector(15 downto 0);
        op: in std_logic_vector(1 downto 0);
        result: out std_logic_vector(15 downto 0);

        zero: out std_logic;
        neg: out std_logic;
        carry: out std_logic 
    );
    end component;
    signal zero,neg,carry: std_logic;
    signal result, a,b: std_logic_vector(15 downto 0);
    signal op: std_logic_vector(1 downto 0);

begin
   -- uut significa Unit Under Test
   uut: ALU port map(   a  => a,
                        b  => b,
                        op => op,
                        result => result,
                        zero => zero,
                        neg => neg,
                        carry => carry
                    );
process
    begin
        op <= "00"; -- ADD

            a <= "0000000001000000";
            b <= "0000001000000001";

            wait for 50 ns;

            a <= "0000000011111111";
            b <= "1100001010100001";

        wait for 50 ns;
        op <= "01"; -- SUB

            a <= "0000000001000000";
            b <= "0000001000000001";

            wait for 50 ns;

            a <= "1100000011111111";
            b <= "0000001010100001";

        wait for 50 ns;
        op <= "10"; -- AND

            a <= "1000000001000000";
            b <= "0000001000000001";

        wait for 50 ns;
            a <= "1100000011111111";
            b <= "0000001010100001";

        wait for 50 ns;
        op <= "11"; -- OR
            a <= "1000000001000000";
            b <= "0000001000000001";

            wait for 50 ns;

            a <= "1100000011111111";
            b <= "0000001010100001";
        wait for 50 ns;
wait;
   end process;
end architecture;