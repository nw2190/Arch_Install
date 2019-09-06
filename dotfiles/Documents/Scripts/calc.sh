#!/bin/bash
if ! [ ${#2} -gt 0 ]
then
    scale=4
else
    scale=$2
fi

echo "scale=${scale}; $1" | bc -l
