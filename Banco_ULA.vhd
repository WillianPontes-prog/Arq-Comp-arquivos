library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_ula is
    port(
        clk, wr_en, rst: in std_logic;
        data_out: out unsigned(15 downto 0);
        data_in: in unsigned(15 downto 0);
        reg_wr, reg_rd: in unsigned(3 downto 0);
        flag_zero, flag_overflow, flag_sinal: out std_logic;
        ula_op: in unsigned(1 downto 0);
        acumulador: in unsigned(15 downto 0);
    );

end entity;

architecture a_banco_ula of banco_ula is
    component banco_reg is
        port(
            wr_en: in std_logic;
            rst: in std_logic;
            clk: in std_logic;
            data_in: in unsigned(15 downto 0);
            reg_wr: in unsigned(3 downto 0);
            reg_rd: in unsigned(3 downto 0);
            data_out: out unsigned(15 downto 0);
            acum_out: out unsigned(15 downto 0)
        );
    end component;

    component ula is
        port(
            acumulador: in unsigned(15 downto 0);
            dado: in unsigned(15 downto 0);
            saida: out unsigned(15 downto 0);
            op: in unsigned(1 downto 0);
            flag_zero: out std_logic;
            flag_sinal: out std_logic;
            flag_overflow: out std_logic 
        );
    end component;

    component reg16bits is
        port(
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

begin
    banco: banco_reg port map(Bwr_en, rst, clk, Bdata_in, reg_wr, 
                              reg_rd, Bdata_out, Bacum_out);

    ula: ula port map(acumulador, ula_in, ula_out, ula_op, Uflag_zero, 
                      Uflag_sinal, Uflag_overflow);

    acum: reg16bits port map(clk, Arst, Awr_en, Adata_in, Adata_out);
    