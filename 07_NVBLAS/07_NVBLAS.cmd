#!/bin/bash
#SBATCH -N 1 
#SBATCH -c 3

# This is how you request a GPU using the 'generic resource' flag.
# The number is how many per node (up to 4), but again using the GPU
# to buttress your BLAS you'll probably get no benefit beyond 1.
#SBATCH --gres=gpu:1
#SBATCH -t 00:05:00

# Load the CUDA toolkit and libraries
module load cudatoolkit


# Standard MKL configuration for R and OpenMP threading
module load intel-mkl
export MKL_INTERFACE_LAYER=GNU,LP64
export MKL_THREADING_LAYER=GNU

# CUDA config
# - Set the path to your nvblas file
export NVBLAS_CONFIG_FILE=$HOME/nvblas.conf
# - Set the path to your cuda libs for the PRELOAD later
CUDA_DIR=/usr/local/cuda-8.0

# Preload the path to libnvblas.so, no need for the MKL preload
# since nvblas.conf handles that for us.
LD_PRELOAD="$CUDA_DIR/lib64/libnvblas.so" /usr/bin/Rscript test.R
