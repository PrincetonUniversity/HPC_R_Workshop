#!/bin/bash
#SBATCH --job-name=R-iris        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=4G                 # total memory per node (4G per cpu-core is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --array=1-3              # job array with index values 1, 2, 3
#SBATCH --mail-type=all          # send email on job start, end and fail

module purge
module load R/4.4.1  # R/4.4.2 on della (R/4.4.1 on adroit)

Rscript 03_iris.R $SLURM_ARRAY_TASK_ID
