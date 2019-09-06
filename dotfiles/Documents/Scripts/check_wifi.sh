#!/bin/bash


out=$(rfkill list all | grep yes)

# If wifi is not hard-blocked
if [ ${#out} -gt 0 ]
then
    echo " "
    echo "rfkill output:"
    rfkill list all
    echo " "
else
    echo " "
    echo "lspci output:"
    lspci -k | grep "Network controller: Intel Corporation Centrino Advanced-N"
    lspci -k | grep "Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN"
    lspci -k | grep "Kernel driver in use: iwlwifi"
    lspci -k | grep "Kernel modules: iwlwifi"
    echo " "
    ping -c 5 www.google.com
    echo " "
    #while true
    #do
    #    ping -c 5 www.google.com
    #    sleep 5
    #done
fi
