ghdl -a ./componentes/ALUla.vhd
ghdl -a ./componentes/BancoRegina.vhd
ghdl -a ./componentes/IRado.vhd
ghdl -a ./componentes/regis16bits.vhd
ghdl -a ./componentes/roma.vhd
ghdl -a ./componentes/somador.vhd
ghdl -a ./componentes/stateMachine.vhd

ghdl -e ALUla
ghdl -e BancoRegina
ghdl -e IRado
ghdl -e regis16Bits
ghdl -e roma
ghdl -e somador
ghdl -e stateMachine

echo "Pressione ENTER para sair..."
read