#!/bin/bash

# Retrieve file from URL
wget -q -O .TMP "$1"

## Convert to txt format
#html2text -o .TMP.txt .TMP
html2text .TMP >> .TMP.txt 

## Make case insensitive and add 2 line before/after match
grep --color=auto -i -A 2 -B 2 "$2" .TMP.txt

## Remove temporary files
rm .TMP
rm .TMP.txt
