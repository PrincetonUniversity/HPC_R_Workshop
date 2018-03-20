#!/bin/bash
# array job using 1 nodes and 1 processor,
# and runs for five minutes max per task.
#SBATCH -N 1   # node count
#SBATCH --ntasks-per-node=1
#SBATCH -t 00:05:00
#SBATCH --array=0-5
# sends mail when process begins, and
# when it ends. Make sure you define your email


Rscript array.R
