-- filepath: vsls:/componentes/opcodes_pkg.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package opcodes_pkg is
    -- Definições de OPCODEs baseadas no issoAquiEosCoiso.txt
    constant OPCODE_NOP    : unsigned(3 downto 0) := "0000";
    constant OPCODE_LD     : unsigned(3 downto 0) := "0001";
    constant OPCODE_JMP    : unsigned(3 downto 0) := "0010";
    constant OPCODE_MOVA   : unsigned(3 downto 0) := "0011";
    constant OPCODE_READA  : unsigned(3 downto 0) := "0100";
    constant OPCODE_ADD    : unsigned(3 downto 0) := "0101";
    constant OPCODE_SUB    : unsigned(3 downto 0) := "0110";
    constant OPCODE_ADDI   : unsigned(3 downto 0) := "0111";
    constant OPCODE_ADDIS  : unsigned(3 downto 0) := "1000";
    constant OPCODE_BLE    : unsigned(3 downto 0) := "1001";
    constant OPCODE_BCS    : unsigned(3 downto 0) := "1010";
    
end package opcodes_pkg;