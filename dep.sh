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

# only grep non-hidden files ending in, for example, ".plt"
for plotFile in $(ls "${figDir}" | grep "\.${plotFileExt}\$"); do

    # extended regex with -E; only print matching with -o; matches "hoge.dat" or 'hoge.dat'
    dataFiles=$(grep -Eo "[\"'][^\"']+\.${dataFileExt}[\"']" "${figDir}/${plotFile}")

    # remove quotation marks with sed; remove duplicates with sort -u
    dataFiles=$(echo "${dataFiles}" | sed "s/[\"']//g" | sort -u)

    prereq="${figDir}/${plotFile}"
    for dataFile in ${dataFiles}; do
        prereq="${prereq} ${figDir}/${dataFile}"
    done
    baseName="${plotFile%${plotFileExt}}" # Bash string manipulation
    target="${figDir}/${baseName}${figFileExt}"
    echo "${target}: ${prereq}" >> "${depFile}"
done
echo "Wrote: ${depFile}"
