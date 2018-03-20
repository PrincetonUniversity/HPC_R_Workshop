#!/bin/bash
# serial job using 1 node and 1 processor,
# and runs for 1 minute (max).
# The script passes a series of parameters to sbatch 
# as if on the commandline, all marked by SBATCH.

#SBATCH -N 1   # node count
#SBATCH --ntasks-per-node=1  # task count
#SBATCH -t 00:01:00
# sends mail when process begins, and
# when it ends. Make sure you define your email
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
# Edit this line to get an email when the job begins and ends! 
#SBATCH --mail-user=yourNetID@princeton.edu


Rscript Hello.R
