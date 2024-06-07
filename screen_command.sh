#!/bin/bash

source conda.sh # CHANGE to path of conda.sh
conda activate BLCA_env # CHANGE if environment name is different

base_filepath=$1
base_filedir="${base_filepath%/*}/"

base_name=$(basename ${1})

# CHANGE -r TAX and -q DB
python3 2.blca_main.py -i $1 -o "$base_filedir$base_name.blca.out" --align muscle -r TAX -q DB
