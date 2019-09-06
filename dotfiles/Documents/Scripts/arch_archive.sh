#!/bin/bash

package_name=$1

# Get first letter/character of package name
index=${package_name:0:1}

# Specify Arch Archive base directory and specified subdirectory
base="https://archive.archlinux.org/packages/"
subdir="$base$index"

# Retrieve subdirectory listings
wget -q -O .TMP "$subdir"

## Convert to txt format
#html2text --ignore-tables .TMP >> .TMP.txt
text=$(html2text --ignore-tables .TMP)



function list_packages() {
    text=$1

    # Set line end to only space/delimiter
    IFS=$'\n'

    # Define regular expression strings for comparison
    regex="\[([[:alnum:][:space:]_\-\/\&.]*)\]"
    alt_regex="\[([[:alnum:][:space:]_\/\&.]*)-([[:alnum:][:space:]_\/\&.]*)\]"

    
    # Specify whether or not to indent files with repeated prefixes
    INDENT=0

    # Iterate through lines and reformat
    for line in $text
    do
        if [[ $line =~ $regex ]]
        then
            filebase="${BASH_REMATCH[0]}"        
            name=${filebase:1:-2}
            echo "$name"
            prevname="$name"
        elif [[ $line =~ $alt_regex ]]
        then
            filebase="${BASH_REMATCH[0]}"        
            name=${filebase:1:-2}

            suffix=${name#"$prevname"}
            if [ "${#suffix}" -gt 0 ]
            then
                if [ $INDENT == 1 ]
                then
                    echo "  $name"
                else
                    echo "$name"
                fi
            else
                echo "$name"
            fi
        fi
    done
    
    return 1
}


listings=$(list_packages "$text" | grep "$package_name")

for line in $listings
do
    echo "-------------------------------------------"
    echo "$line"
    echo "$subdir/$line/"
done
if [ ${#line} -gt 0 ]
then
    echo "-------------------------------------------"
else
    echo "No packages matching search string found."
fi

## Remove temporary file
rm .TMP

