library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XicoXavier is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        estado       : out unsigned(1 downto 0);
        instructionOut : out unsigned(16 downto 0);
        BancoRegData : out unsigned(15 downto 0);
        ulaOut    : out unsigned(15 downto 0);  
        pc_out         : out unsigned(15 downto 0)
    );  
end entity XicoXavier;

architecture XicoXavier_a of XicoXavier is

    component ucewa
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
            clk,rst: in std_logic;
         estado: out unsigned(1 downto 0)
        );
    end component;

    component somador
        port (
            pcIn: in unsigned(15 downto 0);
            pcOut: out unsigned(15 downto 0)
        );
    end component;

    component IRado
        port (
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;
            data_in: in unsigned(16 downto 0);
            data_out: out unsigned(16 downto 0)
        );
    end component;

    component ALUla 
        port (
            a, b: unsigned(15 downto 0);
            op: in unsigned(1 downto 0);
            signedON: in std_logic;

            result: out unsigned(15 downto 0);

            zero: out std_logic;
            neg: out std_logic;
            carry: out std_logic
        );
    end component;

    component BancoRegina
        port (
        clk         : in std_logic;
        
        wr_en       : in std_logic;
        data_in     : in unsigned(15 downto 0);
        data_out    : out unsigned(15 downto 0);
        reg_choose  : in unsigned(2 downto 0);

        rst         : in std_logic
        );
    end component;

    component flagRegister
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
    end component;

    signal pcIn, pcOut: unsigned(15 downto 0);
    signal somadorOut: unsigned(15 downto 0);

    signal pcWren: std_logic;

    signal irIn, irOut: unsigned(16 downto 0);
    signal irWren: std_logic;

    signal currentState: unsigned(1 downto 0);

    signal bancoRegDataOut, accumulatorDataOut, ALUOut, bancoRegDataIn: unsigned(15 downto 0);

    signal ALUop: unsigned(1 downto 0);

    signal flagZ, flagN, flagC: std_logic;  
    signal flagZOut, flagNOut, flagCOut: std_logic;  

    signal bancoWren: std_logic;  

    signal bancoRegChoose: unsigned(2 downto 0);  
    signal choosePc: unsigned(1 downto 0);
    signal bancoChooseImm: std_logic;

    signal accChoose: unsigned(1 downto 0);
    signal accWren: std_logic;
    signal immOut: unsigned(15 downto 0);

    signal accIn: unsigned(15 downto 0);
    signal endereco: unsigned(6 downto 0);


    signal AluSrcA: std_logic; 
    signal SignedON: std_logic;  

    signal alu_a : unsigned(15 downto 0);
    

begin

    pc: regis16bits port map (
        clk      => clk,
        rst      => reset,
        wr_en    => pcWren,  
        data_in  => pcIn,  
        data_out => pcOut  
    );

    pc_somador: somador port map (
        pcIn => pcOut,
        pcOut => somadorOut  
    );

    rom: roma port map (
        clk => clk,
        endereco => endereco,  
        dado => irIn  
    );

    instruction_register: IRado port map (
        clk => clk,
        rst => reset,
        wr_en => irWren,  
        data_in => irIn,  
        data_out => irOut  
    );

    state_machine: stateMachine port map (
        clk => clk,
        rst => reset,
        estado => currentState  
    );

    alu_ut: ALUla port map (
        a => alu_a,  
        b => accumulatorDataOut,  
        op => ALUop, 
        result => ALUOut, 
        zero => flagZ,  
        neg => flagN,  
        carry => flagC,  
        signedON => SignedON
    );

    banco_regs: BancoRegina port map (
        clk => clk,
        wr_en => bancoWren,  
        data_in => bancoRegDataIn,  
        data_out => bancoRegDataOut,  
        reg_choose => bancoRegChoose,  
        rst => reset
    );

    uc: ucewa port map (
        instruction => irOut,
        state => currentState,

        pcWren => pcWren,
        choosePCIn => choosePc,

        bancoChooseImm => bancoChooseImm,
        bancoWren   => bancoWren,
        bancoChoose => bancoRegChoose,

        aluChoose => ALUop,
        aluSrcA => AluSrcA,
        signedON => SignedON,

        accChoose => accChoose,
        accWren => accWren,

        iRegisterWren => irWren,

        immOut => immOut,

        zero => flagZOut,
        neg => flagNOut,
        carry => flagCOut
    );

    accumulator: regis16bits port map (
        clk => clk,
        rst => reset,
        wr_en => accWren,  
        data_in => accIn,  -- Input from lower bits of data_out
        data_out => accumulatorDataOut  -- Output to lower bits of data_out
    );

    flags: flagRegister port map (
        clk => clk,
        rst => reset,
        wr_en => '1',  
        zeroIn => flagZ,  
        negIn => flagN,  
        carryIn => flagC,  

        zeroOut => flagZOut,  
        negOut => flagNOut,  
        carryOut => flagCOut  
    );

    pcIn <= immOut when choosePc = "01" else somadorOut when choosePc = "00" else AluOut;
    bancoRegDataIn <= immOut when bancoChooseImm = '1' else accumulatorDataOut;

    accIn <= immOut when accChoose = "00" else
             bancoRegDataOut when accChoose = "01" else
             ALUOut;
    endereco <=  pcOut(6 downto 0);
    
    alu_a <= bancoRegDataOut when AluSrcA = '0' else
             pcOut;

    estado <= currentState;
    ulaOut <= ALUOut;
    pc_out <= pcOut;
    BancoRegData <= bancoRegDataOut;
    instructionOut <= irOut;


end architecture XicoXavier_a;