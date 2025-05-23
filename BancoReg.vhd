library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity BancoReg is
    port(
        clk         : in std_logic;
        
        wr_en       : in std_logic;
        data_in     : in unsigned(15 downto 0);
        data_out    : out unsigned(15 downto 0);
        reg_choose  : in std_logic_vector(2 downto 0);

        rst         : in std_logic
    );
end entity BancoReg;



architecture BancoReg_a of BancoReg is

    component reg16bits 
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
    reg0: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en0,
        data_in  => data_in,
        data_out => data_out0
    );

    reg1: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en1,
        data_in  => data_in,
        data_out => data_out1
    );

    reg2: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en2,
        data_in  => data_in,
        data_out => data_out2
    );

    reg3: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en3,
        data_in  => data_in,
        data_out => data_out3
    );

    reg4: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en4,
        data_in  => data_in,
        data_out => data_out4
    );

    reg5: reg16bits port map (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en5,
        data_in  => data_in,
        data_out => data_out5
    );

    process(clk)
    begin
        if rising_edge(clk) then
            case reg_choose is
                when "000" =>
                    wr_en0 <= wr_en;
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    wr_en3 <= '0';
                    wr_en4 <= '0';
                    wr_en5 <= '0';
                when "001" =>
                    wr_en0 <= '0';
                    wr_en1 <= wr_en;
                    wr_en2 <= '0';
                    wr_en3 <= '0';
                    wr_en4 <= '0';
                    wr_en5 <= '0';
                when "010" =>
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= wr_en;
                    wr_en3 <= '0';
                    wr_en4 <= '0';
                    wr_en5 <= '0';
                when "011" =>
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    wr_en3 <= wr_en;
                    wr_en4 <= '0';
                    wr_en5 <= '0';
                when "100" =>
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    wr_en3 <= '0';
                    wr_en4 <= wr_en;
                    wr_en5 <= '0';
                when "101" =>
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    wr_en3 <= '0';
                    wr_en4 <= '0';
                    wr_en5 <= wr_en;
                when others =>
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    wr_en3 <= '0';
                    wr_en4 <= '0';
                    wr_en5 <= '0';
            end case;
        end if;

        case reg_choose is
            when "000" =>
                data_out <= data_out0;
            when "001" =>
                data_out <= data_out1;
            when "010" =>
                data_out <= data_out2;
            when "011" =>
                data_out <= data_out3;
            when "100" =>
                data_out <= data_out4;
            when "101" =>
                data_out <= data_out5;
            when others =>
                data_out <= (others => '0');
        end case;
    end process;

end architecture BancoReg_a;
