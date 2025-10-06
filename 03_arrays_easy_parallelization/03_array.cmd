#!/bin/bash
#SBATCH --job-name=R-array       # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=4G                 # total memory per node (4G is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --array=0-5              # job array with index values 0, 1, 2, 3, 4, 5
#SBATCH --mail-type=all          # receive email on start, end, and fail

module purge
module load R/4.5.1

Rscript array.R
