#!/bin/bash
wd=$(pwd)
cd /home/nick/git/Linux
#git pull
ipfile=$(cat LAB_IP.txt)

ipregex='128.46.190.[[:digit:]]{2,3}'
lines=$(echo $ipfile | grep -oE $ipregex)
for l in $lines
do
    if [ "$l" != "128.46.190.255" ]
    then
        #echo $l
        export LAB="nick@$l"
    fi
done
cd $wd
