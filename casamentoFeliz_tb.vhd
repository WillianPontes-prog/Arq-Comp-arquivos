library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity casamentoFeliz_tb is
end entity;

architecture tb of casamentoFeliz_tb is

    -- Component under test
    component casamentoFeliz
        port(
            clk                 : in std_logic;
            wr_en               : in std_logic;
            reset               : in std_logic;
            data_in             : in unsigned(15 downto 0);
            data_out            : out unsigned(15 downto 0);
            reg_choose          : in std_logic_vector(2 downto 0);
            acumulator_out      : out unsigned(15 downto 0);
            op                  : in std_logic_vector(1 downto 0);
            imm_data            : in unsigned(15 downto 0);
            choose_accumulator  : in std_logic;
            acc_wr_en           : in std_logic;
            choose_banco_in     : in std_logic
        );
    end component;

    signal clk                 : std_logic := '0';
    signal wr_en               : std_logic := '0';
    signal reset               : std_logic := '0';
    signal data_in             : unsigned(15 downto 0) := (others => '0');
    signal data_out            : unsigned(15 downto 0);
    signal reg_choose          : std_logic_vector(2 downto 0) := (others => '0');
    signal acumulator_out      : unsigned(15 downto 0);
    signal op                  : std_logic_vector(1 downto 0) := (others => '0');
    signal imm_data            : unsigned(15 downto 0) := (others => '0');
    signal choose_accumulator  : std_logic := '0';
    signal acc_wr_en           : std_logic := '0';
    signal choose_banco_in     : std_logic := '0';

    -- Clock process
    constant clk_period : time := 10 ns;
begin

    uut: casamentoFeliz
        port map (
            clk                 => clk,
            wr_en               => wr_en,
            reset               => reset,
            data_in             => data_in,
            data_out            => data_out,
            reg_choose          => reg_choose,
            acumulator_out      => acumulator_out,
            op                  => op,
            imm_data            => imm_data,
            choose_accumulator  => choose_accumulator,
            acc_wr_en           => acc_wr_en,
            choose_banco_in     => choose_banco_in
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- Escreve 5 no registrador 0
        data_in <= to_unsigned(5, 16);
        reg_choose <= "000";
        wr_en <= '1';
        choose_banco_in <= '1'; -- Escreve do data_in
        wait for clk_period;
        wr_en <= '0';
        wait for clk_period;

        -- Escreve 10 no registrador 1
        data_in <= to_unsigned(10, 16);
        reg_choose <= "001";
        wr_en <= '1';
        choose_banco_in <= '1';
        wait for clk_period;
        wr_en <= '0';
        wait for clk_period;

        
        reg_choose <= "000"; -- Seleciona reg0 para a entrada da ALU
        choose_accumulator <= '0'; -- alu_b recebe imm_data
        imm_data <= to_unsigned(10, 16); 
        op <= "00"; -- Soma
        acc_wr_en <= '1'; -- Escreve no acumulador
        wait for clk_period;
        acc_wr_en <= '0';
        wait for clk_period;
        reg_choose <= "000"; -- Seleciona reg0 
        choose_banco_in <= '0'; -- Usa saída do acumulador como entrada do banco
        wr_en <= '1'; -- Escreve no banco
        wait for clk_period;
        wr_en <= '0';
        wait for clk_period;
        -- Fim do teste
        wait for 200 ns;
        assert false report "Fim da simulação" severity failure;
    end process;

end architecture;