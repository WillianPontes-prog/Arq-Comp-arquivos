library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucewa is
   port(
        instruction: in unsigned(16 downto 0);
        state: in unsigned(1 downto 0);

        pcWren: out std_logic;
        pcChooseImm: out std_logic;

        bancoChooseImm: out std_logic;
        bancoWren: out std_logic;
        bancoReset: out std_logic;
        bancoChoose: out unsigned(2 downto 0);

        aluChoose: out unsigned(1 downto 0); -- 1: ADD 2: SUB, 3: AND, 4: OR

        accChoose: out unsigned(1 downto 0); -- 0: Imm, 1: Banco, 2: ALU
        accWren: out std_logic;

        iRegisterWren: out std_logic;
        iRegisterReset: out std_logic;

        immOut: out unsigned(15 downto 0)
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

      pcWren <= '1' when state = "01" or opcode = "0010" else '0';
      pcChooseImm <= '1' when opcode = "0010" else '0';

      immOut <= "000000" & immInstruction;

      bancoChooseImm <= '1' when opcode = "0001" and state = "01" else '0';
      bancoWren <= '1' when state = "01" and (opcode = "0100" or opcode = "0001") else '0';
      bancoChoose <= operand1;

      aluChoose <= "00" when opcode = "0101" or opcode = "0111" else
                     "01" when opcode = "0110" else
                     "00";  

      accChoose <= "00" when opcode = "0111" else
                     "01" when opcode = "0011" else
                     "10";
      accWren <= '1' when state = "01" and not opcode = "0100" and not opcode = "0010" else '0';


end architecture uc_a;