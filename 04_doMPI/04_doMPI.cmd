#!/bin/bash
#SBATCH -N 2
#SBATCH -n 4 
#SBATCH -t 00:05:00

# This is a somewhat inane setup, as it specifies 
# two nodes and four processes between them. But it 
# serves to demonstrate that MPI can work beyond the boundaries
# of nodes.

# If your processes are memory light, you can just specify
# -n for total number of tasks, and the scheduler will slot
# you in wherever it has room. Note though there is not a shared pool of 
# memory bridging the nodes. 

module load openmpi/gcc/2.1.0/64 


# srun passes parameters that Rmpi uses to see the processes that 
# have been started for it.
# You can also use mpirun -np 1 and spawn processes manually yourself
# but that interface can be more difficult to work with.
srun Rscript 04_doMPI.R
