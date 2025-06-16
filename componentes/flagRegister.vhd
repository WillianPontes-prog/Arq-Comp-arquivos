library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flagRegister is
    port(
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        zeroIn: in std_logic;
        negIn: in std_logic;
        carryIn: in std_logic;

        zeroOut: out std_logic;
        negOut: out std_logic;
        carryOut: out std_logic
    );
end entity;

architecture a_regis16Bits of flagRegister is
    signal registroZ: std_logic := '0';
    signal registroN: std_logic := '0';
    signal registroC: std_logic := '0';


begin
    process(clk, rst, wr_en)
    begin
        if rst='1' then
            registroZ <= '0';
            registroN <= '0';
            registroC <= '0';
        elsif wr_en='1' then
            if rising_edge(clk) then
                registroZ <= zeroIn;
                registroN <= NegIn;
                registroC <= carryIn;

            end if;
        end if;
    end process;

    zeroOut <= registroZ;
    negOut <= registroN;
    carryOut <= registroC;

end architecture;