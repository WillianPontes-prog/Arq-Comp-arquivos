ghdl -a ./componentes/opcodes_pkg.vhd
ghdl -a ./componentes/ALUla.vhd
ghdl -a ./componentes/BancoRegina.vhd
ghdl -a ./componentes/IRado.vhd
ghdl -a ./componentes/regis16bits.vhd
ghdl -a ./componentes/roma.vhd
ghdl -a ./componentes/ucewa.vhd
ghdl -a ./componentes/somador.vhd
ghdl -a ./componentes/stateMachine.vhd
ghdl -a ./componentes/flagRegister.vhd

ghdl -e ALUla
ghdl -e BancoRegina
ghdl -e IRado
ghdl -e regis16Bits
ghdl -e roma
ghdl -e ucewa
ghdl -e somador
ghdl -e stateMachine
ghdl -e flagRegister



ghdl -a ./currentProject/XicoXavier.vhd
ghdl -e XicoXavier

ghdl -a ./currentProject/XicoXavier_tb.vhd
ghdl -e XicoXavier_tb

ghdl -r XicoXavier_tb --wave=XicoXavier_tb.ghw

echo "Pressione ENTER para sair..."
read