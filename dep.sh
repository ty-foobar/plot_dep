#!/bin/bash


# edit this ----

figDir="fig"
plotFileExt="plt"
dataFileExt="dat"
figFileExt="pdf"

# ---- edit this


if [[ $# -ne 1 ]]; then
    echo "Usage: ./dep.sh <dep file name>"
    exit 1
fi
depFile="$1"
> "${depFile}" # clear contents of file
for plotFile in $(ls "${figDir}" | grep ".${plotFileExt}"); do
    baseName="${plotFile%${plotFileExt}}" # Bash string manipulation

    # suppress newline with -n
    echo -n "${figDir}/${baseName}${figFileExt}: " >> "${depFile}"

    # extended regex with -E; only print matching with -o; matches "hoge.dat" or 'hoge.dat'
    dataFiles=$(grep -Eo "[\"'][^\"']+\.${dataFileExt}[\"']" "${figDir}/${plotFile}")

    # remove quotation marks with sed; remove duplicates with sort -u
    dataFiles=$(echo "${dataFiles}" | sed "s/[\"']//g" | sort -u)

    strToWrite="${figDir}/${plotFile}"
    for dataFile in ${dataFiles}; do
        strToWrite="${strToWrite} ${figDir}/${dataFile}"
    done
    echo "${strToWrite}" >> "${depFile}"
done
echo "Wrote: ${depFile}"
