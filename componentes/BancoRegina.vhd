library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity BancoRegina is
    port(
        clk         : in std_logic;
        
        wr_en       : in std_logic;
        data_in     : in unsigned(15 downto 0);
        data_out    : out unsigned(15 downto 0);
        reg_choose  : in unsigned(2 downto 0);

        rst         : in std_logic
    );
end entity BancoRegina;



architecture BancoReg_a of BancoRegina is

    component regis16bits 
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5  : std_logic;
    signal data_out0, data_out1, data_out2, data_out3, data_out4, data_out5 : unsigned(15 downto 0);

begin
    reg0: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en0,
        data_in  => data_in,
        data_out => data_out0
    );

    reg1: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en1,
        data_in  => data_in,
        data_out => data_out1
    );

    reg2: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en2,
        data_in  => data_in,
        data_out => data_out2
    );

    reg3: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en3,
        data_in  => data_in,
        data_out => data_out3
    );

    reg4: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en4,
        data_in  => data_in,
        data_out => data_out4
    );

    reg5: regis16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en5,
        data_in  => data_in,
        data_out => data_out5
    );

        wr_en0 <= wr_en when reg_choose = "000" else '0';
        wr_en1 <= wr_en when reg_choose = "001" else '0';
        wr_en2 <= wr_en when reg_choose = "010" else '0';
        wr_en3 <= wr_en when reg_choose = "011" else '0';
        wr_en4 <= wr_en when reg_choose = "100" else '0';
        wr_en5 <= wr_en when reg_choose = "101" else '0';
        

        data_out <= data_out0 when reg_choose = "000" else
                    data_out1 when reg_choose = "001" else
                    data_out2 when reg_choose = "010" else
                    data_out3 when reg_choose = "011" else
                    data_out4 when reg_choose = "100" else
                    data_out5 when reg_choose = "101";


end architecture BancoReg_a;
