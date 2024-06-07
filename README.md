# BLCA in Parallel

Multiscreen workflow for running Bayesian LCA-based Taxonomic Classification Method [BLCA](https://github.com/qunfengdong/BLCA) in parallel.
- - -

## Introduction

The BLCA multiscreen workflow allows for an input file to be split and put through BLCA in parallel with multiple screen sessions, vastly reducing processing time. 

Results are organized in an output folder, with both individual (split file) results and a large, combined output for the entire file.

## Setting up the environment

This workflow is best run using a conda environment.

`conda create --name BLCA_env python=3.6 biopython blast pyfasta muscle=3.8 clustalo -c conda-forge -c bioconda`

Once this is set up, change the `source` command at the top of the following two files:
- `blca_multiscreen.sh`
- `screen_command.sh`

The command should be updated to:

`source <path to conda.sh>`

You may need to change the environment name in the activation command. The default assumes the environment is set up as `BLCA_env`.

Additionally, you may need to update the path to `screen_command.sh` depending on how you choose to organize script files.

## Preparing required files

Follow the steps outlined in the README of the [BLCA repository](https://github.com/qunfengdong/BLCA) to set up the database using your desired method.

Then, update the `python3` command in `screen_command.sh`:
- change the `-r` flag to point to the reference taxonomy file for the database
- change the `-q` flag to represent the reference BLAST database
- if `2.blca_main.py`, the BLCA script provided by [the BLCA repository](https://github.com/qunfengdong/BLCA), is not located in the same directory as the script files, update its path

**All lines in both `blca_multiscreen.sh` and `screen_command.sh` that may require a change in command are marked with comments starting with "CHANGE" for convenience.**

## Running BLCA

`./blca_multiscreen.sh <absolute-path-to-input-file> <num-to-split>`

_Note_: The name of the file must not contain periods (`.`).

By default, the workflow runs and waits until all tasks finish. If you'd like to continue using your terminal without waiting or opening a new terminal window, consider running the workflow in the background (for example, by spawning a new screen session).

While the screens are running, you will see `Waiting for all tasks to finish...`.

Once the tasks are complete, you will see `Tasks complete. All files are located in <path to BLCA_output folder>`.

> If the workflow has not been run in a screen session: when the task screens are running, you may see the status of the screens by running `screen -ls` in a new terminal. Screens are numbered according to split file / task. Regardless of how the workflow has been run, the script will capture screen output in log files, as explained in the section below.

## Interpreting output files
All files are organized according to the structure below.

Example of a `BLCA_output` folder:
```
.
├── files
│   └── ...                        
├── logs
│   └── ...                              
├── BLCA_log.txt                        
├── combined.fa.blastn                  
├── combined.fa.blca.out               
```

### `files`
Folder that contains all files generated by the workflow -- this includes split files, blastn files, and individual output files. These are numbered according to split file / task.

### `logs`
Folder that contains logs generated in screen that contain all output to stdout received during an individual session. These are numbered according to split file / task.

### `BLCA_log.txt`
Summary text file that contains information about which input file was processed, how many sequences were processed by BLCA, and the output of files generated by BLCA.

### `combined.fa.blastn`, `combined.fa.blca.out`
Output generated by BLCA. These are the results of putting the input file through BLCA (concatenation of individual split file results).

- - -

## License 
GNU 

## Acknowledgements
Thank you to the authors of [BLCA](https://github.com/qunfengdong/BLCA): Xiang Gao, Huaiying Lin, Kashi Revanna, and Qunfeng Dong.

Gao X, Lin H, Revanna K, Dong Q. [A Bayesian taxonomic classification method for 16S rRNA gene sequences with improved species-level accuracy](https://pubmed.ncbi.nlm.nih.gov/28486927/). BMC Bioinformatics. 2017 May 10;18(1):247. doi: 10.1186/s12859-017-1670-4. PMID: 28486927; PMCID: PMC5424349.