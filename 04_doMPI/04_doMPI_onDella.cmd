#!/bin/bash
#SBATCH --job-name=R-mpi         # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks-per-node=2      # total number of tasks per node
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fail

# This is a somewhat inane setup, as it specifies 
# two nodes and four processes between them. In general,
# one allocates all of the CPU-cores on a node before requesting
# multiple nodes.

# If your processes are memory light, you can just specify
# -ntasks for total number of tasks, and the scheduler will slot
# you in wherever it has room. Note though there is not a shared pool of 
# memory bridging the nodes.

module purge
module load R/4.4.2
module load openmpi/gcc/4.1.6

# srun passes parameters that Rmpi uses to see the processes that 
# have been started for it.

srun Rscript 04_doMPI.R
