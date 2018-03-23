#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 05:00



module load intel-mkl
 /usr/bin/Rscript test.R

