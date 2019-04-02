#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2 
#SBATCH -t 05:00

# This uses the class reservation and will only work for our 
# class today, in the future, remove this from your SBATCH
# SBATCH -p class

# This sets the intel-mkl to use the GNU interface, which 
# is more compatible with R
export  MKL_INTERFACE_LAYER=GNU,LP64
export  MKL_THREADING_LAYER=GNU

module load intel-mkl
LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so /usr/bin/Rscript test.R

