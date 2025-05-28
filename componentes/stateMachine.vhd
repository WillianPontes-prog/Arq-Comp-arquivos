library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine is
   port(
        SM_clk: in std_logic;
        SM_rst: in std_logic;
        
        SM_out: out std_logic
   );
end entity stateMachine;


architecture stateMachine_a of stateMachine is

    signal sig_out: std_logic := '0';


begin


    process(SM_clk)
    
    begin
        if rising_edge(SM_clk) then
         sig_out <= not sig_out;
      end if;
    end process;
    
    SM_out <= sig_out;
    
end architecture stateMachine_a;
