#!/bin/bash

# Check if one or two args have been provided
if ! [ ${#2} -gt 0 ]
then
    search="$1"
    directory='./'
else
    # Add trailing slash to directory if necessary
    if ! [ ${1: -1} == '/' ]
    then
	directory="$1"/
    else
	directory="$1"
    fi
    search="$2"
fi


# Determine whether file is readable or not
function readable() {
    # Avoid TeX related files
    if [[ ${f: -4} == ".aux" || ${f: -4} == ".toc" || ${f: -4} == ".nav" || ${f: -4} == ".out" || ${f: -4} == ".log" ]]
    then
	return 0
    fi

    # Avoid backup files
    if [ ${f: -1} == "~" ]
    then
       return 0
    fi
    
    # Avoid binary files
    out=`file -bL --mime "$f" | grep text`
    if [ ${#out} -gt 0 ]
    then
	return 1
    else
	return 0
    fi
    }
#function readable() {
#    f=$1
#    if [[ ${f: -4} == ".pdf" || ${f: -4} == ".zip" || ${f: -4} == ".doc" || ${f: -4} == ".npy" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -4} == ".mat" || ${f: -4} == ".tar" || ${f: -4} == ".png" || ${f: -4} == ".PNG" || ${f: -4} == ".svg" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -4} == ".jpg" || ${f: -4} == ".JPG" || ${f: -5} == ".jpeg" || ${f: -5} == ".JPEG" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -4} == ".wma" || ${f: -4} == ".WMA" || ${f: -4} == ".wav" || ${f: -4} == ".WAV" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -4} == ".m4a" || ${f: -4} == ".M4A" || ${f: -4} == ".mp3" || ${f: -4} == ".MP3" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -4} == ".mp4" || ${f: -4} == ".MP4" ]]
#    then
#	return 0
#    fi
#    if [[ ${f: -5} == ".docx" ||  ${f: -5} == ".DOCX" || ${f: -5} == ".pptx" || ${f: -5} == ".PPTX" ]]
#    then
#	return 0
#    fi
#    if [ ${f: -7} == ".tar.gz" ]
#    then
#	return 0
#    fi
#
#    return 1
#}



# Iterate through file list to find matches
find "${directory}" |
    {
	while read f
	do
	    # Avoid directories
	    #if [ ! -d "$f" ]
	    if ! [ -d "$f" ]
	    then
		tmp=$( readable "$f" )
		readability=$?
		if [ "${readability}" == 1 ]
		then
		    #out=`cat -n "$f"*|grep --color=auto "$2"`
		    out=`cat -n "$f"|grep "${search}"`
		    if [ "${#out}" -gt 0 ]
		    then
			echo " "
			echo " "
			echo "### "
			echo "##  $f"
			echo "### "
			echo " "
			cat -n "$f"|grep --color=auto "${search}"
		    fi
		fi
	    fi
	done

	echo " "
    }
