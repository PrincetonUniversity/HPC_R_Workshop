#!/bin/bash
#SBATCH --job-name=R-nvblas      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=3        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem=4G                 # total memory per node (4G per cpu-core is default)
#SBATCH --time=00:00:30          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fail

module purge
module load R/4.3.0

# Standard MKL configuration for R and OpenMP threading
module load intel-mkl/2021.1.1
export MKL_INTERFACE_LAYER=GNU,LP64
export MKL_THREADING_LAYER=GNU

# CUDA config
# Set the path to your nvblas file
export NVBLAS_CONFIG_FILE=$(pwd)/nvblas.conf

# Preload the path to libnvblas.so, no need for the MKL preload
# since nvblas.conf handles that for us.
LD_PRELOAD="/usr/lib64/libnvblas.so" Rscript test.R
