#!/bin/bash

i=50
while [ $i -lt 256 ]
do
    echo "nick@128.46.190.$i"
    ssh -o ConnectTimeout=5 -o BatchMode=yes "nick@128.46.190.$i"
    let i=$i+1
done
