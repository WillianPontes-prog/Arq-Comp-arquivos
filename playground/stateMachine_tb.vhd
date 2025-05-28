library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- a entidade tem o mesmo nome do arquivo
entity stateMachine_tb is
end;

architecture a_stateMachine_tb of stateMachine_tb is
    component stateMachine
        port(
            SM_clk: in std_logic;
            SM_rst: in std_logic;
            SM_out: out std_logic
    );
    end component;

    signal SM_clk: std_logic := '0';
    signal SM_rst: std_logic := '0';
    signal SM_out: std_logic;

begin
   -- uut significa Unit Under Test
   sm: stateMachine port map(   
                    SM_clk => SM_clk,
                    SM_rst => SM_rst,
                    SM_out => SM_out
                    );
process
    begin
        SM_clk <= '1';
        wait for 10 ns;
        SM_clk <= '0';
        wait for 10 ns;
        SM_clk <= '1';
        wait for 10 ns;
        SM_clk <= '0';
        SM_rst <= '1'; 
        wait for 10 ns;
        SM_rst <= '0'; 
        SM_clk <= '1';
        wait for 10 ns;
        SM_clk <= '0';
        wait for 10 ns;
        SM_clk <= '1';

        
wait;
   end process;
end architecture;
