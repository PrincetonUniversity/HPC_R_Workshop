#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2 
#SBATCH -t 05:00


export  MKL_INTERFACE_LAYER=GNU,LP64
export  MKL_THREADING_LAYER=GNU

module load intel-mkl
LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so /usr/bin/Rscript test.R

