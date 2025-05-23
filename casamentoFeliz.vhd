library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity casamentoFeliz is
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
end entity casamentoFeliz;

architecture casamentoFeliz_a of casamentoFeliz is

    component reg16bits 
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component ALU
        port(
            a      : in std_logic_vector(15 downto 0);
            b      : in std_logic_vector(15 downto 0);
            op     : in std_logic_vector(1 downto 0);
            result : out std_logic_vector(15 downto 0);
            zero   : out std_logic;
            neg    : out std_logic;
            carry  : out std_logic
        );
    end component;

    component BancoReg
        port(        
            clk         : in std_logic;
            wr_en       : in std_logic;
            data_in     : in unsigned(15 downto 0);
            data_out    : out unsigned(15 downto 0);
            reg_choose  : in std_logic_vector(2 downto 0);
            rst         : in std_logic
        );
    end component;

    -- Sinais para interligação
    signal banco_data_in : unsigned(15 downto 0);
    signal alu_a, alu_b, alu_result : std_logic_vector(15 downto 0);
    signal alu_zero, alu_neg, alu_carry : std_logic;
    signal reg_wr_en, banco_wr_en : std_logic;
    signal banco_reg_choose : std_logic_vector(2 downto 0);
    signal alu_op : std_logic_vector(1 downto 0);

    signal BancoToReg: unsigned(15 downto 0);
    signal acc_data_in, acc_data_out : unsigned(15 downto 0);
    

begin

    -- Instância do registrador de 16 bits
    u_acumulador: reg16bits
        port map (
            clk      => clk,
            rst      => reset, 
            wr_en    => acc_wr_en,
            data_in  => acc_data_in,
            data_out => acc_data_out
        );

    -- Instância do Banco de Registradores
    u_banco: BancoReg
        port map (
                clk         => clk,
        
                wr_en       => wr_en,
                data_in     => banco_data_in,
                data_out    => BancoToReg,
                reg_choose  => reg_choose,

                rst         => reset
        );

    -- Instância da ALU
    u_alu: ALU
        port map (
            a      => alu_a,
            b      => alu_b,
            op     => alu_op,
            result => alu_result,
            zero   => alu_zero,
            neg    => alu_neg,
            carry  => alu_carry
        );

    -- Exemplo de conexão entre os componentes (ajuste conforme sua lógica)
    alu_a <= std_logic_vector(BancoToReg);
    acc_data_in <= unsigned(alu_result);
    alu_op <= op;

    process(choose_banco_in, data_in, alu_result)
    begin
        if choose_banco_in = '1' then
            banco_data_in <= data_in;
        else
            banco_data_in <= unsigned(alu_result);
        end if;
    end process;

    process(choose_accumulator, acc_data_in, imm_data)
    begin
        if choose_accumulator = '1' then
            alu_b <= std_logic_vector(acc_data_in);
        else
            alu_b <= std_logic_vector(imm_data);
        end if;
    end process;


end architecture casamentoFeliz_a;