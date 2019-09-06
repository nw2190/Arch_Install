#!/bin/bash

# Check if an argument has been provided
if ! [ ${#1} -gt 0 ]
then
    filename="*"
else
    filename="$1"
fi


# Determine whether working directory is in "/home/nick" of "/media/Backup/Research"
function basecheck() {
    base=$1
    alt_base=$2
    alt_prefix=$3
    filename=$4
    wd="$(pwd)""/"
    short_wd=${wd#"$base"}
    alt_short_wd=${wd#"${alt_base}"}
    if [ ! "${short_wd}" = "${wd}" ]; then
        if [ ! "$filename" = "*" ]; then
            echo "${short_wd}$filename"
        else
            echo "${short_wd}"
        fi
        return 1
    elif [ ! "${alt_short_wd}" = "${wd}" ]; then
        if [ ! "$filename" = "*" ]; then
            echo "${alt_prefix}${alt_short_wd}$filename"
        else
            echo "${alt_prefix}${alt_short_wd}"
        fi
        return 1
    else
        return 0
    fi
}


base="/home/nick/"
alt_base="/media/Backup/Research/"
alt_prefix="Research/"
dest=$( basecheck "${base}" "${alt_base}" "${alt_prefix}" "${filename}" )
basetest=$?
	    
if [ ${basetest} == 1 ]; then
    #echo "rsync -vu $filename $LAB:$dest"
    rsync -vu $filename $LAB:$dest
else
    echo "[*] Failed to identify base directory."
fi
