#!/bin/bash

# AUTHOR : Robson Ferreira
# TEAM   : DevOps  
#------------------------------------------------------------
# DESCRIPTION:
# Check Disk Space 
#
#-------------------------------------------------------------
# EXAMPLE:
#    ./health_check.sh
#-------------------------------------------------------------
# HISTORY:
# v1.0 - 02/17/2020 - Robson Ferreira: Script created.    
#-------------------------------------------------------------

#---| VARIABLES:

DATE=$(date +%m/%d/%Y)

#---| FUNCTIONS:

check_disk()
{
    echo "----------| CHECK DISK"
    echo " "
    echo "Disk Size: $(df -h --total | tail -n1 | awk '{print $2}')" 
    echo "Used:      $(df -h --total | tail -n1 | awk '{print $3}')"
    echo "Available: $(df -h --total | tail -n1 | awk '{print $4}')"
    echo "Use%:      $(df -h --total | tail -n1 | awk '{print $5}')"
    echo ""
    echo LOGS:
    echo "/var:  $(df -h /var | tail -n1 | awk '{print $5}') used"
    echo "/opt:  $(df -h /opt | tail -n1 | awk '{print $5}') used"
    echo ""
}

check_cpu()
{
    echo "----------| CHECK CPU"
    echo " " 
    lscpu | head -n4 | tail -n1
    top | head -n1 | awk '{print $10" "$11" "$12" "$13" "$14 }'
    echo ""
}

check_memory()
{
    echo "----------| CHECK MEMORY"
    echo " "
    free -h
    echo ""
}

check_network()
{
    echo "----------| CHECK NETWORK"
    echo " "
    echo "Interface: "$(ifconfig | grep inet | head -n1)
    echo "DNS: " 
    grep -i nameserver /etc/resolv.conf
    echo ""
}

check_process()
{
    echo "----------| CHECK PROCESS"
    echo " "
    ps aux | grep -i java | awk '{print "User:"$1 " PID:"$2" "$17}' | head -n1
    echo ""
    }

#---| BODY OF SCRIPT:

clear
echo ""
echo "DATE: " $DATE
echo ""
check_cpu
check_memory
check_disk
check_process
check_network

#---| FOOTER

exit 0