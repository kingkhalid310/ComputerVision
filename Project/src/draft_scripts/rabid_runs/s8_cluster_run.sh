#!/bin/bash

ANTSPATH=/share/apps/ANTs.OLD/bin
# usage example:
# ./s8_cluster_run.sh 160719_04_43636464


# input
subject_id=${1}

# directories
main_dir=/home/rabid/shared/CS512_project
scripts_dir=${main_dir}/scripts
files_dir=${main_dir}/files
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
	#PBS -v ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=2,OMP_NUM_THREADS=2,OMP_THREAD_LIMIT=2,LD_LIBRARY_PATH=$LD_LIBRARY_PATH,ANTSPATH=$ANTSPATH
	#PBS -l mem=10GB
	#PBS -l nodes=2:CPU:ppn=2
	source /home/mrniaz/.bash_profile
	bash ${scripts_dir}/s7_downsample_qsm.sh ${subject_id}
EOJ
`

jobIDs="${jobIDs} ${JOB}"
echo ${jobIDs}


