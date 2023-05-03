
# get native labels
sink=/home/rabid/shared/CS512_project/data_dir/Native
for folder in */;
do
sink_dir=${sink}/${folder%/}
if [ ! -d ${sink_dir} ]; then
mkdir -p ${sink_dir}
fi

source_file=./${folder%/}/${folder%/}_FS_labels.nii.gz
sink_file=${sink_dir}/${folder%/}_FS_labels.nii.gz

cp ${source_file} ${sink_file}

echo ${sink_dir}
echo ${source_file}
echo
done


# get native files
sink=/home/rabid/shared/CS512_project/data_dir/Native

for folder in */;
do
sink_dir=${sink}/${folder%/}
source_dir=/home/rabid/Master_evaluation/QSM/evaluation_v4/raw_images_dir

if [ ! -d ${sink_dir} ]; then
mkdir -p ${sink_dir}
fi

source_file1=${source_dir}/QSM/${folder%/}_QSM.nii.gz
source_file2=${source_dir}/QSM_mask/${folder%/}_QSM_mask.nii.gz

sink_file1=${sink_dir}/${folder%/}_QSM.nii.gz
sink_file2=${sink_dir}/${folder%/}_QSM_mask.nii.gz


cp ${source_file1} ${sink_file1}
cp ${source_file2} ${sink_file2}

echo ${source_file1}
echo ${source_file2}
echo ${sink_file1}
echo ${sink_file2}
echo
done




# get native -> miitra transformations
sink=/home/rabid/shared/CS512_project/final_transformations/MIITRA

for folder in */;
do
sink_dir=${sink}/${folder%/}
source_dir=/home/rabid/Master_evaluation/QSM/evaluation_v4/final_transformations/MIITRA

if [ ! -d ${sink_dir} ]; then
mkdir -p ${sink_dir}
fi

source_file1=${source_dir}/${folder%/}_MIITRA.nii.gz
source_file2=${source_dir}/${folder%/}_MIITRA_inv.nii.gz

sink_file1=${sink_dir}/${folder%/}_MIITRA.nii.gz
sink_file2=${sink_dir}/${folder%/}_MIITRA_inv.nii.gz


cp ${source_file1} ${sink_file1}
cp ${source_file2} ${sink_file2}

echo ${source_file1}
echo ${source_file2}
echo ${sink_file1}
echo ${sink_file2}
echo
done



# split labels
for folder in */;
do
subject_id=${folder%/}
scripts_dir=/home/rabid/shared/CS512_project/scripts
echo ${subject_id}
${scripts_dir}/s1_mask_breakdown.sh ${subject_id}
echo 
done


# get native->miitra qsm files
sink=/home/rabid/shared/CS512_project/data_dir/MIITRA
for folder in */;
do
sink_dir=${sink}/${folder%/}
source_dir=/home/rabid/Master_evaluation/QSM/evaluation_v4/warped_images/MIITRA

if [ ! -d ${sink_dir} ]; then
mkdir -p ${sink_dir}
fi

source_file1=${source_dir}/QSM/${folder%/}_QSM.nii.gz
source_file2=${source_dir}/QSM_mask/${folder%/}_QSM_mask.nii.gz

sink_file1=${sink_dir}/${folder%/}_QSM.nii.gz
sink_file2=${sink_dir}/${folder%/}_QSM_mask.nii.gz

cp ${source_file1} ${sink_file1}
cp ${source_file2} ${sink_file2}

echo ${source_file1}
echo ${source_file2}
echo ${sink_file1}
echo ${sink_file2}
echo
done


# run cluster code
for folder in */;
do
subject_id=${folder%/}
scripts_dir=/home/rabid/shared/CS512_project/scripts
echo ${subject_id}
${scripts_dir}/s3_cluster_subjectwise_apply_transformation.sh ${subject_id} putamen
echo 
done


# mask multiplication
for folder in */;
do
subject_id=${folder%/}
scripts_dir=/home/rabid/shared/CS512_project/scripts
echo ${subject_id}
${scripts_dir}/s0_qsm_refined.sh ${subject_id}
echo 
done



# split labels 2
for folder in */;
do
subject_id=${folder%/}
scripts_dir=/home/rabid/shared/CS512_project/scripts
echo ${subject_id}
# ${scripts_dir}/s4_label_breakdown_v2.sh ${subject_id} caudate 11 50
# ${scripts_dir}/s4_label_breakdown_v2.sh ${subject_id} thalamus 10 49
# ${scripts_dir}/s4_label_breakdown_v2.sh ${subject_id} amygdala 18 54
# ${scripts_dir}/s4_label_breakdown_v2.sh ${subject_id} cerebellum_cortex 8 47
${scripts_dir}/s4_label_breakdown_v2.sh ${subject_id} hippocampus 17 53
echo 
done



## temporary scripts
img = nib.load('QSM_masked.nii.gz')
data = img.get_fdata()
mask = nib.load('mask.nii.gz')
mask_data = mask.get_fdata()

shifted_data = data + 100

# Assuming we are scaling between 0 to 10000
min_value = np.min(shifted_data)
max_value = np.max(shifted_data)
normalized_data = (shifted_data - min_value) / (max_value - min_value) * 10000
normalized_data = normalized_data*mask_data






# cluster run for all the subjects
cd /home/rabid/shared/CS512_project/data_dir/forKS_v2/MIITRA
for folder in */;
do
subject_id=${folder%/}
scripts_dir=/home/rabid/shared/CS512_project/scripts
echo ${subject_id}
${scripts_dir}/s8_cluster_run.sh ${subject_id}
sleep 0.5
echo 
done



# check the generated files
#!/bin/bash

# Loop through each folder in the current directory
for folder in */; do
# Get the number of files in the folder
#num_files=$(ls -1q "$folder" | wc -l)
# echo $folder $num_files

num_files=$(ls -1q "$folder/downsampled/" | wc -l)
echo $folder $num_files
# Check if there are less than 7 files
if [ "$num_files" -lt 7 ]; then
# Write the folder name to a file
echo "$folder" > missing_down.txt
fi
done


# seperate the downsampled files
cd /home/rabid/shared/CS512_project/data_dir/forKS_v2/MIITRA
for folder in */;
do
subject_id=${folder%/}

source_dir=./${subject_id}/downsampled
sink_dir=./downsampled/${subject_id}
if [ ! -d ${sink_dir} ]; then
mkdir -p ${sink_dir}
fi

cp -r $source_dir $sink_dir
echo ${subject_id} done
done




scripts_dir=/home/rabid/shared/CS512_project/scripts
cd /home/rabid/shared/cs512/cs512_project_gdrive_runs/data_dir/MIITRA/downsampled_data
for file in */;
do 
	echo ${file%/}
	# ${scripts_dir}/s9_QSM_downsample.sh ${file%/}
	sleep 0.5
done



scripts_dir=/home/rabid/shared/cs512/cs512_project_gdrive_runs/scripts
cd /home/rabid/shared/cs512/cs512_project_gdrive_runs/data_dir/MIITRA/downsampled_data
for file in */;
do 
echo ${file%/}
${scripts_dir}/pad_org_img_then_downsample_and_save.sh ${file%/}
sleep 0.5
done


