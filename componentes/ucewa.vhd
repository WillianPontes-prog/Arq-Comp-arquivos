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
         choosePCIn: out unsigned(1 downto 0); 
         bancoChooseImm: out std_logic;
         bancoWren: out std_logic;
         bancoChoose: out unsigned(2 downto 0); 

         aluChoose: out unsigned(1 downto 0); -- 1: ADD 2: SUB, 3: AND, 4: OR
         aluSrcA: out std_logic;
         signedON: out std_logic; 

         accChoose: out unsigned(1 downto 0); -- 0: Imm, 1: Banco, 2: ALU
         accWren: out std_logic;

         iRegisterWren: out std_logic;

         immOut: out unsigned(15 downto 0)
   );
end entity ucewa;

architecture uc_a of ucewa is

   signal opcode: unsigned(3 downto 0);
   signal operand1: unsigned(2 downto 0);
   signal immInstruction: unsigned(9 downto 0);

   begin

      opcode <= instruction(16 downto 13);
      operand1 <= instruction(12 downto 10);
      immInstruction <= instruction(9 downto 0);

      iRegisterWren <= '1' when state = "00" else '0';

      pcWren <= '1' when (state = "01" and opcode /= OPCODE_BLE) or opcode = OPCODE_JMP or (opcode = OPCODE_BLE and state = "10" and (zero = '1' or neg = '1')) or (opcode = OPCODE_BCS and carry = '1' and state = "01") else '0';
      choosePCIn <= "01" when opcode = OPCODE_JMP else "10" when opcode = OPCODE_BLE and state = "10" else
                    "00"; 

      immOut <= "000000" & immInstruction when  opcode /= OPCODE_ADDIS 
                                          and    opcode /= OPCODE_BLE 
                                          and    opcode /= OPCODE_BCS 
                  else "111111" & immInstruction;

      signedON <= '1' when  opcode = OPCODE_ADDIS 
                                          or    opcode = OPCODE_BLE 
                                          or    opcode = OPCODE_BCS 
                  else '0';

      bancoChooseImm <= '1' when opcode = OPCODE_LD and state = "01" else '0';
      bancoWren <= '1' when state = "01" and (opcode = OPCODE_READA or opcode = OPCODE_LD) else '0';
      bancoChoose <= operand1;

      aluChoose <=   "00" when opcode = OPCODE_ADD or opcode = OPCODE_ADDI or opcode = OPCODE_ADDIS or (opcode = OPCODE_BLE and state = "10") else
                     "01" when opcode = OPCODE_SUB or (opcode = OPCODE_BLE and state = "01") else
                     "00";  

      aluSrcA <= '1' when opcode = OPCODE_BLE and state = "10" else 
                  '0';

      accChoose <= "00" when opcode = OPCODE_ADDI or (opcode = OPCODE_BLE and state = "01") else
                     "01" when opcode = OPCODE_MOVA else
                     "10";
                     
      accWren <= '1' when (state = "01" or state = "10") and opcode /= OPCODE_READA and opcode /= OPCODE_JMP else '0';

      

end architecture uc_a;