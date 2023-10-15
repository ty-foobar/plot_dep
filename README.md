# plot_dep

## Summary

The Bash script *dep.sh* outputs a rule for GNU Make describing the dependencies of plotting scripts such as gnuplot and Python scripts. It is similar in effect to what the `-MM` option achieves for `gcc` and `g++` compilers.

The dependencies will be of the following form:

```
fig: src data1 data2 data3 ...
```

*dep.sh* will work for most scripts meeting the following conditions (see [Limitations](https://github.com/ty-foobar/plot_dep#limitations)):

1. A single `fig` is created from a single `src` and they have the same base name (e.g. `%.pdf: %.plt data1 ...`).
2. File names in the scripts are placed between either `"` or `'`.

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
3. File names NOT used for plotting appear as part of comments and are placed between `"` or `'` (e.g. `# ... 'data5.dat'...`).

Regarding the 3rd limitation, comments such as the following will work:

- `# ... ".dat"...` or `# ... '.dat'...` as file names with an empty base name will not match.
- `# ... "data1.dat"...` or `# ... 'data1.dat'...` when *data1.dat* is used for plotting within the script.
- `# ... data5.dat...` or `# ... <data5.dat>...`, where file names are not placed between `"` or `'`.

---

## License

This software is licensed under the MIT License (see [LICENSE](https://github.com/ty-foobar/plot_dep/blob/main/LICENSE)).
