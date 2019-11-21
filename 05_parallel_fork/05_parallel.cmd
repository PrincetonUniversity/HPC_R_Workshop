#!/bin/bash
#SBATCH --job-name=R-fork        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=10              # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on start, end and fault
#SBATCH --mail-user=<YourNetID>@princeton.edu

module load openmpi/gcc/2.1.0/64 

srun Rscript 05_parallel.R
