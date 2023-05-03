#!/bin/bash

# usage:
# ./s4_label_breakdown_v2.sh 160719_04_43636464 putamen 12 51
# ./s4_label_breakdown_v2.sh 160719_04_43636464 caudate 11 50
# ./s4_label_breakdown_v2.sh 160719_04_43636464 amygdala 18 54
# ./s4_label_breakdown_v2.sh 160719_04_43636464 thalamus 10 49
# ./s4_label_breakdown_v2.sh 160719_04_43636464 cerebellum_cortex 8 47
# ./s4_label_breakdown_v2.sh 160719_04_43636464 hippocampus 17 53

# input 
subject_id=${1}
label=${2}
left_val=${3}
right_val=${4}

# directories
#main_dir=/Users/badhon/Desktop/CV512_project/Project_proposal/version2
main_dir=/home/rabid/shared/CS512_project
source_dir=${main_dir}/data_dir/Native/${subject_id}
sink_dir=${main_dir}/data_dir/Native/${subject_id}/label_masks/version2
files_dir=${main_dir}/files

if [ ! -d ${sink_dir} ]; then
	mkdir -p ${sink_dir}
fi

# input file
input_nifti=${source_dir}/${subject_id}_FS_labels.nii.gz


left_mask=${sink_dir}/l_${label}.nii.gz
right_mask=${sink_dir}/r_${label}.nii.gz

fslmaths ${input_nifti} -thr ${left_val} ${left_mask}
fslmaths ${left_mask} -uthr ${left_val} ${left_mask}
fslmaths ${left_mask} -bin ${left_mask}

fslmaths ${input_nifti} -thr ${right_val} ${right_mask}
fslmaths ${right_mask} -uthr ${right_val} ${right_mask}
fslmaths ${right_mask} -bin ${right_mask}


fslmaths ${left_mask} -add ${right_mask} ${sink_dir}/${label}_mask.nii.gz
fslmaths ${sink_dir}/${label}_mask.nii.gz -bin ${sink_dir}/${label}_mask.nii.gz