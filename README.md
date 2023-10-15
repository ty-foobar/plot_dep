# plot_dep

## Summary

The Bash script *dep.sh* outputs a rule for GNU Make describing the dependencies for plotting scripts where file names are surrounded by either `"` or `'` (such as in gnuplot and Python). It is similar in effect to what the `-MM` option achieves for `gcc` and `g++` compilers.

This repository contains other files for a demonstration using gnuplot scripts.

## Usage

- Using the demo files:
    1. Run `make`.

- General usage:
    1. Open *dep.sh* and edit the lines surrounded by the "edit this" comments.
    2. Run `./dep.sh <dep file name>`.

## Limitations

The Bash script *dep.sh* uses regular expressions to search for the names of data files used for plotting within each script. *dep.sh* currently fails to produce the correct dependencies in the following cases:

1. File names contain string substitutions (e.g. `sprintf("data%d.dat",1)`).
2. File names contain `"` or `'` (e.g. `"data1".dat`).
3. File names NOT used for plotting appear as part of comments and are surrounded by `"` or `'` (e.g. `# ... 'data5.dat'...`).

Regarding the 3rd limitation, the following comments will work:

- `# ... ".dat"...` or `# ... '.dat'...` as file names with an empty base name will not match.
- `# ... "data1.dat"...` or `# ... 'data1.dat'...` when *data1.dat* is used for plotting within the script.
- `# ... data5.dat...` or `# ... <data5.dat>...`, where file names are not surrounded by `"` or `'`.
