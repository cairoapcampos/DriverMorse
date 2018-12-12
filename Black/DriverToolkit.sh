#!/bin/bash

clear

menu() {
   echo "######################################################"
   echo "#####             Driver Tool kit V.1.0          #####"
   echo "######################################################"
   echo "### 1 - Compilar Módulo                              #"
   echo "### 2 - Limpar Compilação                            #"
   echo "### 3 - Listar conteúdo do diretório de compilação   #"
   echo "### 4 - Subir módulo para o Kernel                   #"
   echo "### 5 - Exibir mensagens de log do Kernel            #"
   echo "### 6 - Listar o driver                              #"
   echo "### 7 - Remover módulo do Kernel                     #"
   echo "### 8 - Escrever uma mensagem em código Morse        #"
   echo "### 0 - Exit/Sair                                    #"
   echo "######################################################"
   echo " "
   echo -n "Escolha uma das opções acima:"
   read opcao
   case $opcao in
       1) Compile ;;
       2) CompileClean ;;
       3) ListDir;;
       4) UpModuleKernel ;;
       5) MsgKernelLog ;;
       6) LsModule;;
       7) RmModuleKernel;;
       8) WriteMsg;;
       0) exit ;;
       *) echo " "
          echo "Opção Invalida! Retornando ao Menu..."
          sleep 3
          clear
          menu ;;
   esac

}

Compile() {
InitFunct
make
echo " "
echo "Compilação finalizada!"
RtMenu
}

CompileClean() {
InitFunct
make clean
echo " "
echo "Limpeza de Compilação finalizada!!!"
RtMenu
}

ListDir(){
InitFunct
ls
RtMenu
}

UpModuleKernel() {
InitFunct
upmodule=$(find . -iname '*.ko' | cut -d/ -f 2)
sudo insmod $upmodule
sudo dmesg
RtMenu
}

MsgKernelLog() {
InitFunct
sudo dmesg
RtMenu
}

LsModule(){
InitFunct
listmodule=$(find . -iname '*.ko' | cut -d/ -f 2 | cut -d. -f 1)
echo "Listando o driver entre os módulos instalados:"
echo " "
lsmod | grep $listmodule
echo " "
echo "Listando o driver em /dev:"
echo " "
ls /dev/morse*
RtMenu
}

RmModuleKernel(){
InitFunct
rmodule=$(find . -iname '*.ko' | cut -d/ -f 2 | cut -d. -f 1)
sudo rmmod $rmodule
sudo dmesg
RtMenu
}

WriteMsg(){
InitFunct
sudo chmod 666 /dev/morse0
echo " "
echo -n "Digite sua mensagem:"
read msg
echo "$msg" > /dev/morse0
RtMenu
}

InitFunct(){
clear
echo " "
}

RtMenu(){
echo " "
echo -n "Deseja voltar ao Menu principal? Digite \"s\" para sim: "
read aswr
if [ $aswr = s ]
then
    clear
    menu

else
    echo
    echo "Opção Errada!"
    RtMenu

fi
}

menu
