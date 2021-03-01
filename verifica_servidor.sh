#!/bin/bash

# AUTOR : Robson Ferreira
# TIME  : DevOps  
#------------------------------------------------------------
# BREVE DESCRIÇÃO:
# Verifica a saúde do servidor, consultando:
#   . Espaço em disco
#   . Consumo de CPU
#   . Consumo de memória
#   . Informação da rede 
#   . Processos em execução
#
#-------------------------------------------------------------
# EXEMPLO:
#    ./verifica_servidor.sh
#-------------------------------------------------------------
# HISTÓRICO DE MUDANÇAS:
# v1.0 - 17/02/2020 - Robson Ferreira: Criação do script.
# v1.1 - 01/03/2021 - Robson Ferreira: Melhoria nas funções.    
#-------------------------------------------------------------

#---| DEFINIÇÃO DAS VARIÁVEIS:

DATE=$(date +%m/%d/%Y)

#---| FUNÇÕES:

verifica_disco()
{
    echo "----------| CONSUMO DO DISCO |------------------------------"
    echo " "
    echo "Tamanho: $(df -h --total | tail -n1 | awk '{print $2}')" 
    echo "Usado:      $(df -h --total | tail -n1 | awk '{print $3}')"
    echo "Disponível: $(df -h --total | tail -n1 | awk '{print $4}')"
    echo "Uso%:      $(df -h --total | tail -n1 | awk '{print $5}')"
    echo ""
    echo LOGS:
    echo "/var:  $(df -h /var | tail -n1 | awk '{print $5}') used"
    echo "/opt:  $(df -h /opt | tail -n1 | awk '{print $5}') used"
    echo ""
}

verifica_cpu()
{
    echo "----------| CONSUMO DE CPU |------------------------------"
    echo " " 
    lscpu | head -n4 | tail -n1
    top | head -n1 | awk '{print $10" "$11" "$12" "$13" "$14 }'
    echo ""
}

verifica_memoria()
{
    echo "----------| CONSUMO DE MEMÓRIA |------------------------------"
    echo " "
    free -h
    echo ""
}

verifica_rede()
{
    echo "----------| INFORMAÇÕES DA REDE |------------------------------"
    echo " "
    echo "Interface: "$(ifconfig | grep inet | head -n1)
    echo "DNS: " 
    grep -i nameserver /etc/resolv.conf
    echo ""
}

verifica_processos()
{
    echo "----------| PROCESSO EM EXECUÇÃO |------------------------------"
    echo " "
    ps aux | grep -i java | awk '{print "User:"$1 " PID:"$2" "$17}' | head -n1
    echo ""
    }

#---| CORPO DO SCRIPT:

clear
echo " "
echo "DATA DA VERIFICAÇÃO: " $DATE
echo " "
verifica_cpu
verifica_memoria
verifica_disco
verifica_processos
verifica_rede

#---| RODAPÉ DO SCRIPT

exit 0