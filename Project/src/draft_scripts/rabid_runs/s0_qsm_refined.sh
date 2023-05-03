#!/bin/bash

# usage: 
# ./s0_qsm_refined.sh 160719_04_43636464

subject_id=${1}

main_dir=/home/rabid/shared/CS512_project
source_dir=/home/rabid/shared/CS512_project/data_dir/MIITRA


nifti_image=${source_dir}/${subject_id}/${subject_id}_QSM.nii.gz
nifti_mask=${source_dir}/${subject_id}/${subject_id}_QSM_mask.nii.gz

fslmaths $nifti_mask -bin $nifti_mask

# Extract the filename without the extension
filename=$(basename "${nifti_image}" .nii.gz)

# Multiply the image and mask
fslmaths "${nifti_image}" -mul "${nifti_mask}" "${source_dir}/${subject_id}/${filename}_masked.nii.gz"

echo "Masked image saved as ${filename}_masked.nii.gz"
