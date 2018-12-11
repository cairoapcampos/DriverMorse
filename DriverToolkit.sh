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
   echo "### 6 - Listar o driver entre os módulos instalados  #"
   echo "### 7 - Remover módulo do Kernel                     #"
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
       0) exit ;;
       *) echo " "
          echo "Opção Invalida! Retornando ao Menu..."
          sleep 3
          clear
          menu ;;
   esac

}

Compile() {
echo " "
make
echo " "
echo "Compilação finalizada!"
echo " "
echo "Voltando ao Menu principal..."
sleep 3
clear
menu
}

CompileClean() {
echo " "
make clean
echo " "
echo "Limpeza de Compilação finalizada!!!"
echo " "
echo "Voltando ao Menu principal..."
sleep 3
clear
menu
}

ListDir(){
echo " "
ls
echo " "
echo "Voltando ao Menu principal..."
sleep 3
clear
menu
}

UpModuleKernel() {
echo " "
upmodule=$(find . -iname '*.ko' | cut -d/ -f 2)
sudo insmod $upmodule
sudo dmesg
echo " "
echo "Voltando ao Menu principal..."
sleep 5
clear
menu
}

MsgKernelLog() {
echo " "
sudo dmesg
echo " "
echo "Voltando ao Menu principal..."
sleep 5
clear
menu
}

LsModule(){
echo " "
listmodule=$(find . -iname '*.ko' | cut -d/ -f 2 | cut -d. -f 1)
lsmod | grep $listmodule
echo " "
echo "Voltando ao Menu principal..."
sleep 3
clear
menu
}

RmModuleKernel(){
rmodule=$(find . -iname '*.ko' | cut -d/ -f 2 | cut -d. -f 1)
sudo rmmod $rmodule
sudo dmesg
echo " "
echo "Voltando ao Menu principal..."
sleep 5
clear
menu
}

menu
