library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.opcodes_pkg.all;

entity ucewa is
   port(
         instruction: in unsigned(16 downto 0);
         state: in unsigned(1 downto 0);
         zero: in std_logic;
         neg: in std_logic;
         carry: in std_logic;

        pcWren: out std_logic;
        pcChoose: out unsigned(1 downto 0); -- 0: +1, 1: Imm, 2:ALU

        bancoChooseImm: out std_logic;
        bancoWren: out std_logic;
        bancoChoose: out unsigned(2 downto 0);

         aluChoose: out unsigned(1 downto 0); -- 1: ADD 2: SUB, 3: AND, 4: OR

         accChoose: out unsigned(1 downto 0); -- 0: Imm, 1: Banco, 2: ALU
         accWren: out std_logic;

         iRegisterWren: out std_logic;

         immOut: out unsigned(15 downto 0);

         signedON: out std_logic;

         wrEn_flag: out std_logic;

         zero: in std_logic;
         neg: in std_logic;
         carry: in std_logic;

         ALUchooseA: out std_logic -- 0: banco, 1: PC
   );
end entity ucewa;

architecture uc_a of ucewa is

   -- Aliases para os opcodes
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
   constant OPCODE_CMP    : unsigned(3 downto 0) := "1011";

   signal opCode: unsigned(3 downto 0);
   signal operand1: unsigned(2 downto 0);
   signal immInstruction: unsigned(9 downto 0);

   begin

      opcode <= instruction(16 downto 13);
      operand1 <= instruction(12 downto 10);
      immInstruction <= instruction(9 downto 0);

      iRegisterWren <= '1' when state = "00" else '0';

      pcWren <= '1' when (state = "10" and (opcode /= OPCODE_BLE or (opcode = OPCODE_BLE and neg = '0')))
                  or opcode = OPCODE_JMP
                  or (opcode = OPCODE_BLE and (neg = '1') and state = "10")
                  else '0';
   
   pcChoose <= "01" when opcode = OPCODE_JMP else 
               "10" when opcode = OPCODE_BLE and neg = '1' and state = "10" else
               "00";

   immOut <= "000000" & immInstruction when  opcode /= OPCODE_ADDIS 
                                       and    opcode /= OPCODE_BLE 
                                       and    opcode /= OPCODE_BCS 
             else "111111" & immInstruction;

   signedON <= '1' when  opcode = OPCODE_ADDIS 
                       or opcode = OPCODE_BLE 
                       or opcode = OPCODE_BCS 
                else '0';

   bancoChooseImm <= '1' when opcode = OPCODE_LD and state = "01" else '0';
   bancoWren <= '1' when state = "01" and (opcode = OPCODE_READA or opcode = OPCODE_LD) else '0';
   bancoChoose <= operand1;

   aluChoose <=   "00" when opcode = OPCODE_ADD or opcode = OPCODE_ADDI or opcode = OPCODE_BLE else
                  "01" when opcode = OPCODE_SUB or opcode = OPCODE_CMP else
                  "00";  

   accChoose <=   "00" when (opcode = OPCODE_ADDI and state = "01") or (opcode = OPCODE_BLE) else --imm
                  "01" when opcode = OPCODE_MOVA else -- banco
                  "10";--alu

   accWren <= '1' when (state = "01" and opcode /= OPCODE_READA and opcode /= OPCODE_JMP) else '0';

   wrEn_flag <= '1' when state = "01" and (opcode = OPCODE_CMP or opcode = OPCODE_ADD or opcode = OPCODE_ADDI or opcode = OPCODE_ADDIS or opcode = OPCODE_SUB) else '0';

   ALUchooseA <= '1' when opcode = OPCODE_BLE else '0'; -- 0: banco, 1: PC

end architecture uc_a;