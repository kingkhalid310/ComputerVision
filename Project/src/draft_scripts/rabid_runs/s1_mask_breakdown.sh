#!/bin/bash

# usage: 
# ./s1_mask_breakdown.sh 160719_04_43636464

# input 
subject_id=${1}

# directories
# main_dir=/Users/badhon/Desktop/CV512_project/Project_proposal/version2
main_dir=/home/rabid/shared/CS512_project
source_dir=${main_dir}/data_dir/Native/${subject_id}
sink_dir=${main_dir}/data_dir/Native/${subject_id}/label_masks
files_dir=${main_dir}/files

if [ ! -d ${sink_dir} ]; then
	mkdir -p ${sink_dir}
fi

# input file
input_nifti=${source_dir}/${subject_id}_FS_labels.nii.gz

# label files
label_names_file=${files_dir}/label_name.txt
label_val_file=${files_dir}/label_val.txt

echo $label_names_file
echo $label_val_file



while read -r label_name && read -r x <&3; do
  #echo "$label_name $x"
  fslmaths "$input_nifti" -thr "$x" -bin "${sink_dir}/${label_name}_mask.nii.gz"
  echo "For ${subject_id} Binary mask saved as ${label_name}_mask.nii.gz"
done < "$label_names_file" 3< "$label_val_file"
