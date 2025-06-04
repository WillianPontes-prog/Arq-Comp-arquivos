library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity primeiroPrograma is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        data_out    : out unsigned(16 downto 0)
    );
end entity primeiroPrograma;

architecture primeiroPrograma_a of primeiroPrograma is

    component ucewa
        port(
        PcIn: in unsigned(15 downto 0);
        instruction: in unsigned(16 downto 0);

        state: in std_logic;

        PcWren: out std_logic;
        PcOut: out unsigned(15 downto 0)
        );
    end component;

    component regis16bits 
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component roma
        port (
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(16 downto 0)
        );
    end component;


    component stateMachine
        port (
            SM_clk: in std_logic;
            SM_rst: in std_logic;
            SM_out: out std_logic
        );
    end component;

    signal pcIn, pcOut : unsigned(15 downto 0);
    signal dataRom : unsigned(16 downto 0);
    signal currentState :  std_logic;
    signal pc_wren : std_logic;

begin

    state_machine: stateMachine
        port map (
            SM_clk => clk,
            SM_rst => reset,
            SM_out => currentState
        );

    pc: regis16bits
        port map (
            clk      => clk,
            rst      => reset,
            wr_en    => pc_wren,  
            data_in  => pcIn, 
            data_out => pcOut
        );

    control_unit: ucewa
        port map (
            pcIn  => pcOut,
            pcOut => pcIn,
            instruction => dataRom,
            state => currentState,
            PcWren => pc_wren
        );

    rom_unit: roma
        port map (
            clk      => clk,
            endereco => pcOut(6 downto 0),
            dado     => dataRom
        );

    data_out <= dataRom;

end architecture primeiroPrograma_a;