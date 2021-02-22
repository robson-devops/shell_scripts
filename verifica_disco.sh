#!/bin/bash

# AUTHOR : Robson Ferreira
# TEAM   : devops  
#------------------------------------------------------------
# DESCRIPTION:
# Verifica espaço em disco.
#
#-------------------------------------------------------------
# EXEMPLO DE USO:
#    ./verifica_disco.sh
#-------------------------------------------------------------
# HISTÓRICO:
# v1.0 - 22/02/2020 - Robson Ferreira: Criação do script.    
#-------------------------------------------------------------

DATE=$(date +%d/%m/%Y)

verifica_disco()
{
    clear
    echo " -- INFORMAÇÕES DE CONSUMO DO DISCO -- "
    echo "TAMANHO:    $(df -h --total | tail -n1 | awk '{print $2}')" 
    echo "USADO:      $(df -h --total | tail -n1 | awk '{print $3}')"
    echo "DISPONÍVEL: $(df -h --total | tail -n1 | awk '{print $4}')"
    echo "USADO(%):   $(df -h --total | tail -n1 | awk '{print $5}')"
    echo " --------------------------------------"
}

echo "DATA: " $DATE
verifica_disco

exit 0