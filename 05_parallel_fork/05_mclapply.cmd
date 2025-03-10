#!/bin/bash
#SBATCH --job-name=R-fork        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fail

module purge
module load R/4.4.1  # R/4.4.2 on della (R/4.4.1 on adroit)

srun Rscript 05_mclapply.R
