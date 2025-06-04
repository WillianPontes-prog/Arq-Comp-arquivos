library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- a entidade tem o mesmo nome do arquivo
entity primeiroPrograma_tb is
end;

architecture a_primeiroPrograma_tb of primeiroPrograma_tb is
    component primeiroPrograma
        port(
            clk: in std_logic;
            reset: in std_logic;
            data_out    : out unsigned(16 downto 0)
    );
    end component;

    signal Oclk: std_logic := '0';
    signal Oreset: std_logic := '0';
    signal Odata_out: unsigned(16 downto 0);

begin
   -- uut significa Unit Under Test
   uut: primeiroPrograma port map(   
                    clk => Oclk,
                    reset => Oreset,
                    data_out => Odata_out
                    );
process
    begin
        Oclk <= '0';
        Oreset <= '1';
        wait for 10 ns;
        Oreset <= '0';
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0'; 
        wait for 10 ns; 
        Oclk <= '1';
        wait for 10 ns;
        Oclk <= '0';
        wait for 10 ns;
        Oclk <= '1';

        
wait;
   end process;
end architecture;
