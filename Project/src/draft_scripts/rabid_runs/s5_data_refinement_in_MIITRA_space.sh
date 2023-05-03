#!/bin/bash

# usage:
# ./s5_data_refinement_in_MIITRA_space.sh 160719_04_43636464

# input
subject_id=${1}
template_name=MIITRA


# directories
main_dir=/home/rabid/shared/CS512_project
source_dir=${main_dir}/data_dir/Native/${subject_id}
sink_dir=${main_dir}/data_dir/forKS_v2/${template_name}/${subject_id}
sink_dir_down=${sink_dir}/downsampled
files_dir=${main_dir}/files
scripts_dir=${main_dir}/scripts
template_dir=${main_dir}/reference_dir
transform_files_dir=${main_dir}/final_transformations/${template_name}/${subject_id}

if [ ! -d ${sink_dir} ]; then
	mkdir -p ${sink_dir}
fi

if [ ! -d ${sink_dir_down} ]; then
	mkdir -p ${sink_dir_down}
fi

cd ${main_dir}


# copy brain mask to the sink dir 
brain_mask_file_source=${main_dir}/data_dir/${template_name}/${subject_id}/${subject_id}_QSM_mask.nii.gz
brain_mask_file_sink=${sink_dir}/${subject_id}_QSM_mask.nii.gz

cp ${brain_mask_file_source} ${brain_mask_file_sink}

fslmaths ${brain_mask_file_sink} -bin ${brain_mask_file_sink} # binarize the mask 

echo "Brain mask is now in ${sink_dir}"
echo


# bring QSM files to sink dir
QSM_file_source=${main_dir}/data_dir/${template_name}/${subject_id}/${subject_id}_QSM.nii.gz
QSM_file_sink=${sink_dir}/${subject_id}_QSM_masked.nii.gz

cp ${QSM_file_source} ${QSM_file_sink}

fslmaths ${QSM_file_sink} -mul ${brain_mask_file_sink} ${QSM_file_sink}

echo "QSM is now in ${sink_dir}"
echo 

## apply transformations to the labels
fixedImage=${template_dir}/${template_name}.nii.gz
transformationFile=${transform_files_dir}/${subject_id}_${template_name}.nii.gz

# bring putamen label to MIITRA space
label=putamen
label_file_source=${source_dir}/label_masks/version2/${label}_mask.nii.gz
label_file_sink=${sink_dir}/${label}_mask.nii.gz

raw_movingImage=${label_file_source}
outputImage=${label_file_sink}

${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 0 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}

echo "${label} is now in MIITRA space in ${sink_dir}"
echo


# bring amygdala label to MIITRA space
label=amygdala
label_file_source=${source_dir}/label_masks/version2/${label}_mask.nii.gz
label_file_sink=${sink_dir}/${label}_mask.nii.gz

raw_movingImage=${label_file_source}
outputImage=${label_file_sink}

${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 0 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}

echo "${label} is now in MIITRA space in ${sink_dir}"
echo

# bring caudate label to MIITRA space
label=caudate
label_file_source=${source_dir}/label_masks/version2/${label}_mask.nii.gz
label_file_sink=${sink_dir}/${label}_mask.nii.gz

raw_movingImage=${label_file_source}
outputImage=${label_file_sink}

${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 0 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}

echo "${label} is now in MIITRA space in ${sink_dir}"
echo

# bring thalamus label to MIITRA space
label=thalamus
label_file_source=${source_dir}/label_masks/version2/${label}_mask.nii.gz
label_file_sink=${sink_dir}/${label}_mask.nii.gz

raw_movingImage=${label_file_source}
outputImage=${label_file_sink}

${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 0 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}

echo "${label} is now in MIITRA space in ${sink_dir}"
echo

# bring hippocampus label to MIITRA space
label=hippocampus
label_file_source=${source_dir}/label_masks/version2/${label}_mask.nii.gz
label_file_sink=${sink_dir}/${label}_mask.nii.gz

raw_movingImage=${label_file_source}
outputImage=${label_file_sink}

${ANTSPATH}/antsApplyTransforms \
-d 3 --float 1 --verbose 0 \
-n GenericLabel \
-i ${raw_movingImage} \
-o ${outputImage} \
-r ${fixedImage} \
-t ${transformationFile}

echo "${label} is now in MIITRA space in ${sink_dir}"
echo


# move to the sink folder and pad all the images
echo "Starting padding and downsampling..."
cd ${sink_dir}
for file in *;
do
	input=${file}
	c3d $input -pad 66x36x66vox 66x36x66vox 0 -o $input

	downsampledInput=${sink_dir_down}/${input%.nii.gz}_down_by_2.nii.gz
	fslmaths ${input} -subsamp2 ${downsampledInput}
	fslmaths ${downsampledInput} -bin ${downsampledInput}
	echo "Done for ${input}"
done


# move the QSM again to overwrite the binarized QSM
echo "Overwrite the QSM downsampled file"
input=${subject_id}_QSM_masked.nii.gz
downsampledInput=${sink_dir_down}/${input%.nii.gz}_down_by_2.nii.gz
fslmaths ${input} -subsamp2 ${downsampledInput}
echo "All done..."


