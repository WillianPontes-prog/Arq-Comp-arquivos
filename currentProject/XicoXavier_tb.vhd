library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- a entidade tem o mesmo nome do arquivo
entity XicoXavier_tb is
end;

architecture ateste_tb of XicoXavier_tb is
    component XicoXavier is   
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        estado       : out unsigned(1 downto 0);
        instructionOut : out unsigned(16 downto 0);
        BancoRegData : out unsigned(15 downto 0);
        ulaOut    : out unsigned(15 downto 0);  
        pc_out         : out unsigned(15 downto 0)
    );       -- aqui vai seu componente a testar
    end component;
                                -- 100 ns é o período que escolhi para o clock
    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';

    signal   clk, reset  : std_logic;
    signal  estado      : unsigned(1 downto 0);
    signal  instructionOut : unsigned(16 downto 0);
    signal  BancoRegData : unsigned(15 downto 0);
    signal  ulaOut    : unsigned(15 downto 0);
    signal  pc_out         : unsigned(15 downto 0);

begin
    uut: XicoXavier port map (
        clk         => clk,
        reset       => reset,
        estado      => estado,
        instructionOut => instructionOut,
        BancoRegData => BancoRegData,
        ulaOut      => ulaOut,
        pc_out          => pc_out
    );  -- aqui vai a instância do seu componente
    
    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        reset <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 500 us;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;
    clk_proc: process
    begin                       -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
   
end architecture ateste_tb;