#!/bin/bash


# edit this ----

figDir="fig"
plotFileExt="plt"
dataFileExt="dat"
figFileExt="pdf"

# ---- edit this

check_args() {
    numArgs="$1"
    if [[ ${numArgs} -ne 1 ]]; then
        echo "Usage: ./dep.sh <dep file name>"
        exit 1
    fi
}

check_dir() {
    dir_="$1"
    if [ ! -d "${dir_}" ]; then
        echo "ERROR: Dir. '${dir_}' does not exist"
        exit 1
    fi
}

check_args "$#"
check_dir "${figDir}"

depFile="$1"
> "${depFile}" # clear contents of file

# only grep non-hidden files ending in, e.g., ".plt"
for plotFile in $(ls "${figDir}" | grep "\.${plotFileExt}\$"); do

    # extended regex with -E; only print matching with -o; matches, e.g., "hoge.dat" or 'hoge.dat'
    dataFiles=$(grep -Eo "[\"'][^\"']+\.${dataFileExt}[\"']" "${figDir}/${plotFile}")

    # remove quotation marks with sed; remove duplicates with sort -u
    dataFiles=$(echo "${dataFiles}" | sed "s/[\"']//g" | sort -u)

    prereq="${figDir}/${plotFile}"
    for dataFile in ${dataFiles}; do
        prereq="${prereq} ${figDir}/${dataFile}"
    done
    baseName="${plotFile%.${plotFileExt}}" # Bash string manipulation
    target="${figDir}/${baseName}.${figFileExt}"
    echo "${target}: ${prereq}" >> "${depFile}"
done
echo "Wrote: ${depFile}"
