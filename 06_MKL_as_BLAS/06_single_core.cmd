#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 05:00

# The following line is the reservation for our course
# which you should remove if you adapt these scripts
#SBATCH --reservation=HPCR

module load intel-mkl
 /usr/bin/Rscript test.R

