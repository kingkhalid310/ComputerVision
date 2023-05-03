#!/bin/bash

ANTSPATH=/share/apps/ANTs.OLD/bin
# usage example:
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 left_caudate_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 right_caudate_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 left_thalamus_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 right_thalamus_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 left_putamen_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 right_putamen_mask
# ./s3_cluster_subjectwise_apply_transformation.sh 190813_08_79978444 putamen


# input
subject_id=${1}
label_name=${2}


# directories
main_dir=/home/rabid/shared/CS512_project
scripts_dir=${main_dir}/scripts
job_dir=${main_dir}/job_dir

if [ ! -d ${job_dir} ]; then
	mkdir -p ${job_dir}
fi

cd ${job_dir}

# submit cluster job
jobIDs=""

JOB=`qsub -<<EOJ
	#!/bin/bash
	#PBS -N LabelApplyTrans-${subject_id}
	#PBS -j oe
	#PBS -v ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=3,OMP_NUM_THREADS=3,OMP_THREAD_LIMIT=3,LD_LIBRARY_PATH=$LD_LIBRARY_PATH,ANTSPATH=$ANTSPATH
	#PBS -l mem=10GB
	#PBS -l nodes=3:CPU:ppn=3
	source /home/mrniaz/.bash_profile
	bash ${scripts_dir}/s2_apply_transformation_native_to_miitra.sh  ${subject_id} ${label_name}
EOJ
`

jobIDs="${jobIDs} ${JOB}"
echo ${jobIDs}


