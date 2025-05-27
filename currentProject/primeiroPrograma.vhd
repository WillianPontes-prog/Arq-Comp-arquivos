library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity primeiroPrograma is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        data_out    : out unsigned(15 downto 0);
    );
end entity primeiroPrograma;

architecture primeiroPrograma_a of primeiroPrograma is

    component cUnit
        port(
            pcIn  : in unsigned(15 downto 0);
            pcOut : out unsigned(15 downto 0)
        );
    end component;

    component reg16bits 
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal pcIn, pcOut : unsigned(15 downto 0);

begin

    pc: reg16bits
        port map (
            clk      => clk,
            rst      => reset,
            wr_en    => '1',  
            data_in  => pcIn, 
            data_out => pcOut
        );
    control_unit: cUnit
        port map (
            pcIn  => pcOut,
            pcOut => pcIn
        );

end architecture primeiroPrograma_a;