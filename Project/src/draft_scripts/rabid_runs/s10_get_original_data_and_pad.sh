#!/bin/bash
# usage: 
# ./s10_get_original_data_and_pad.sh 160719_04_43636464


#input
subject_id=${1}

main_dir=/home/rabid/shared/cs512/cs512_project_gdrive_runs
source_dir=${main_dir}/data_dir/MIITRA/downsampled_data/${subject_id}/downsampled
sink_dir=${main_dir}/data_dir_2/${subject_id}


if [ ! -d ${sink_dir} ]; then
	mkdir -p ${sink_dir}
fi

##### dimension 256x256x256
# old
dim=2
suffix="_mask_down_by_${dim}.nii.gz"
# new
dim=256
suffix_new="_dim${dim}.nii.gz"

# labels
label_name="amygdala"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="hippocampus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="thalamus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="caudate"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="putamen"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}



##### dimension 128x128x128
# old
dim=4
suffix="_mask_down_by_${dim}.nii.gz"
# new
dim=128
suffix_new="_dim${dim}.nii.gz"

# labels
label_name="amygdala"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="hippocampus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="thalamus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="caudate"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="putamen"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}



##### dimension 64x64x64
# old
dim=8
suffix="_mask_down_by_${dim}.nii.gz"
# new
dim=64
suffix_new="_dim${dim}.nii.gz"

# labels
label_name="amygdala"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="hippocampus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="thalamus"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="caudate"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}

label_name="putamen"
old_file=${source_dir}/${label_name}${suffix}
new_file=${sink_dir}/${label_name}${suffix_new}
cp ${old_file} ${new_file}





# QSM masked files
# 
prefix_old=${subject_id}
dim_old=2
suffix_old="_masked_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=256
suffix_new="_masked_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}

# 
prefix_old=${subject_id}
dim_old=4
suffix_old="_masked_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=128
suffix_new="_masked_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}

# 
prefix_old=${subject_id}
dim_old=8
suffix_old="_masked_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=64
suffix_new="_masked_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}





# QSM mask files
# 
prefix_old=${subject_id}
dim_old=2
suffix_old="_mask_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=256
suffix_new="_mask_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}


# 
prefix_old=${subject_id}
dim_old=4
suffix_old="_mask_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=128
suffix_new="_mask_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}

# 
prefix_old=${subject_id}
dim_old=8
suffix_old="_mask_down_by_${dim_old}.nii.gz"

prefix_new=QSM
dim_new=64
suffix_new="_mask_dim${dim_new}.nii.gz"

QSM_old=$source_dir/${prefix_old}${suffix_old}
QSM_new=${sink_dir}/${prefix_new}${suffix_new}




