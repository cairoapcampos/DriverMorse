## DriverMorse (V.1.1)

Script para automatizar a compilação do módulo Morse para o Kernel Linux

### Instruções de Utilização ![status](https://img.shields.io/readthedocs/pip.svg)

1- Clone o repositório para a pasta onde será compilado o módulo de kernel:

`git clone https://github.com/cairoapcampos/DriverMorse.git`

2- Entre na pasta do código do driver:

`cd DriverMorse`

3- Dê permissão de execução para o script DriverToolkit.sh`:

`chmod +x DriverToolkit.sh`

4- Execute o script:

`./DriverToolkit.sh`

5- Em um outro terminal, executar o comando abaixo para ver o que está sendo escrito na serial do Arduino:

`minicom -b 9600 -D /dev/ttyUSB0`
