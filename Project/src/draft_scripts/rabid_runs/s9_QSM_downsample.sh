#!/bin/bash
# usage: 
# ./s9_QSM_downsample.sh 160719_04_43636464

subject_id=${1}

main_dir=/home/rabid/shared/cs512/cs512_project_gdrive_runs
source_dir=/home/rabid/shared/CS512_project/data_dir/MIITRA/${subject_id}
sink_dir=${main_dir}/data_dir/MIITRA/downsampled_data/${subject_id}/downsampled


input=${sink_dir}/${subject_id}_QSM_down_by_2.nii.gz
downsampledInput1=${sink_dir}/${subject_id}_QSM_down_by_4.nii.gz
fslmaths ${input} -subsamp2 ${downsampledInput1}
