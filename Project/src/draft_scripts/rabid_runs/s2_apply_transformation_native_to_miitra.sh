#!/bin/bash
ANTSPATH=/share/apps/ANTs.OLD/bin

# usage: 
# ./s2_apply_transformation_native_to_miitra.sh 160719_04_43636464 left_caudate

# inputs
subject_id=${1}
label_name=${2}
template_name="MIITRA"


# directories
main_dir=/home/rabid/shared/CS512_project/
scripts_dir=${main_dir}/scripts
template_dir=${main_dir}/reference_dir

source_dir=${main_dir}/data_dir/Native/${subject_id}/label_masks/version2
sink_dir=${main_dir}/data_dir/${template_name}/${subject_id}/label_masks/version2
transform_files_dir=${main_dir}/final_transformations/${template_name}/${subject_id}

if [ ! -d ${sink_dir} ]; then
	mkdir -p ${sink_dir}
fi

cd ${main_dir}


# file selection
raw_movingImage=${source_dir}/${label_name}_mask.nii.gz
outputImage=${sink_dir}/${label_name}_mask.nii.gz
fixedImage=${template_dir}/${template_name}.nii.gz
transformationFile=${transform_files_dir}/${subject_id}_${template_name}.nii.gz


# apply transformations
${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 1 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}