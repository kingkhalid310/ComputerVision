#!/bin/bash
# usage: 
# ./s7_downsample_qsm.sh 160719_04_43636464

subject_id=$1

main_dir=/home/rabid/shared/CS512_project
source_dir=${main_dir}/data_dir/forKS_v2/MIITRA/${subject_id}/downsampled
sink_dir=${source_dir}

cd ${sink_dir}
for file in *;
do
	input=${file}
	downsampledInput1=${input%2.nii.gz}4.nii.gz
	fslmaths ${input} -subsamp2 ${downsampledInput1}
	fslmaths ${downsampledInput1} -bin ${downsampledInput1}

	downsampledInput2=${input%2.nii.gz}8.nii.gz
	fslmaths ${downsampledInput1} -subsamp2 ${downsampledInput2}
	fslmaths ${downsampledInput2} -bin ${downsampledInput2}
	echo "Done for ${input}"
done


# move the QSM again to overwrite the binarized QSM
echo "Overwrite the QSM downsampled file"

input=${subject_id}_QSM_masked_down_by_2.nii.gz
downsampledInput1=${input%2.nii.gz}4.nii.gz
fslmaths ${input} -subsamp2 ${downsampledInput1}

downsampledInput2=${input%2.nii.gz}8.nii.gz
fslmaths ${downsampledInput1} -subsamp2 ${downsampledInput2}
echo "All done..."