#!/bin/bash

if [ ${#1} -gt 0 ]
then
    tmpdir='/home/nick/.tmp/'
    file="$1"
    wd=$(pwd)

    ##cp "${wd}/"* "${tmpdir}" | grep -v "omitting directory"
    cp "${wd}/"* "${tmpdir}" 2>/dev/null
    cp "${file}" "${tmpdir}"
    #rsync -t "${wd}/"* "${tmpdir}" 2>/dev/null
    #rsync -t "${file}" "${tmpdir}"
    cd "${tmpdir}"
    cp "${file}" "${file}.bak"
    ##python /home/nick/Documents/abs_path.py --file "${tmpdir}${file}" --pwd "${wd}"
    python /home/nick/Documents/Scripts/file_replace.py --file "${tmpdir}${file}" --search "./" --replace "${wd}" --add_slash True
    chmod +x "${tmpdir}${file}"
    "${tmpdir}${file}"
    cp "${file}.bak" "${file}"
    cd "${wd}"
    
    cp "${tmpdir}"* "${wd}"
    #rsync -u  "${tmpdir}"* "${wd}"
    rm -rf "${tmpdir}"*
fi
