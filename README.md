# plot_dep

## Summary

The Bash script *dep.sh* outputs a rule for GNU Make describing the dependencies for gnuplot (or gnuplot-style) scripts, where file names are surrounded by either `"` or `'`. It is similar in effect to what the `-MM` option achieves for `gcc` and `g++` compilers.

All other files in the repository are for demonstration purposes.

## Usage

1. Open *dep.sh* and edit the lines surrounded by the "edit this" comments.
2. Run `make`.

## Limitations

The Bash script *dep.sh* uses regular expressions to search for the names of data files used for plotting within each gnuplot script. *dep.sh* currently fails to produce the correct dependencies in the following cases:

1. There is a file name containing `"` or `'` (e.g. `"data1".dat`).
2. A file name NOT used for plotting appears as part of a comment and is surrounded by `"` or `'` (e.g. `# ... 'data5.dat'...`).

Regarding the 2nd limitation, the following comments will work:

- `# ... ".dat"...` or `# ... '.dat'...` as *dep.sh* will not match file names with an empty base name.
- `# ... "data1.dat"...` or `# ... 'data1.dat'...` when *data1.dat* is used for plotting in the gnuplot script.
- `# ... data5.dat...` or `# ... <data5.dat>...`, where file names are not surrounded by `"` or `'`.
