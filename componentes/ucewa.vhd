library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucewa is
   port(
        instruction: in unsigned(16 downto 0);
        state: in unsigned(1 downto 0);

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

   signal opCode: unsigned(3 downto 0);
   signal operand1: unsigned(2 downto 0);
   signal immInstruction: unsigned(9 downto 0);

   begin

      opcode <= instruction(16 downto 13);
      operand1 <= instruction(12 downto 10);
      immInstruction <= instruction(9 downto 0);

      iRegisterWren <= '1' when state = "00" else '0';

      pcWren <= '1' when (state = "10" and (opcode /= "1001" or (opCode = "1001" and neg = '0'))) or opcode = "0010" or (opcode = "1001" and (neg = '1') and state = "10") else '0';
      
      pcChoose <= "01" when opcode = "0010" else 
                  "10" when opcode = "1001" and neg = '1' and state = "10" else
                  "00";

      immOut <= "000000" & immInstruction when  opcode /= "1000" 
                                          and    opcode /= "1001" 
                                          and    opcode /= "1010" 
                  else "111111" & immInstruction;

      signedON <= '1' when  opcode = "1000" 
                      or    opcode = "1001" 
                      or    opcode = "1010" 
                  else '0';

      bancoChooseImm <= '1' when opcode = "0001" and state = "01" else '0';
      bancoWren <= '1' when state = "01" and (opcode = "0100" or opcode = "0001") else '0';
      bancoChoose <= operand1;

      aluChoose <=   "00" when opcode = "0101" or opcode = "0111" or (opcode = "1001")else
                     "01" when opcode = "0110" or opcode = "1011" else
                     "00";  

      accChoose <=   "00" when (opcode = "0111" and state = "01") or (opCode = "1001") else --imm
                     "01" when opcode = "0011" else -- banco
                     "10";--alu

      accWren <= '1' when (state = "01" and opcode /= "0100" and opcode /= "0010") else '0';

      wrEn_flag <= '1' when state = "01" and opcode = "1011" else '0';

      ALUchooseA <= '1' when opcode = "1001" else '0'; -- 0: banco, 1: PC

end architecture uc_a;