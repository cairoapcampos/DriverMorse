## Morse Driver Tool Box (V.1.1)

Script para automatizar compilações de módulos do Kernel Linux

### Instruções de Utilização ![status](https://img.shields.io/readthedocs/pip.svg)

1- Certifique-se que exista na pasta de compilação o arquivo Makefile e o modulo.c.

2- Clone o repositório para a pasta onde será compilado o módulo de kernel:

`git clone https://github.com/cairoapcampos/DriverToolkit.git`

2- Mova os arquivos para a pasta de compilação:

`mv DriverToolkit/* .`

3- Remova a pasta vazia

`rm -R DriverToolkit`

4- Dê permissão de execução para o script:

`chmod +x DriverToolkit.sh`

5- Execute o script:

`./DriverToolkit.sh`

6- Em um outro terminal, executar o comando abaixo para ver o que está sendo escrito na serial do Arduino:


`minicom -b 9600 -D /dev/ttyUSB0`
