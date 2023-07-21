#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

input_file=$1
working_dir=$2
DATE=""

shift 2
while getopts d: flag
do
    case "${flag}" in
        d) DATE="--date_cutoff ${OPTARG}";;        
    esac
done

python -W ignore $parent_path/model_pmhcs.py $input_file $working_dir $DATE
python -W ignore $parent_path/tfold_run_alphafold.py --inputs $working_dir/inputs/input.pckl --output_dir $working_dir/outputs
# python $parent_path/collect_results.py $working_dir