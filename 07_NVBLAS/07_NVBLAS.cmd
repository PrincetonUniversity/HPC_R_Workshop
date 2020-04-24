#!/bin/bash
#SBATCH --job-name=R-nvblas      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=3        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:tesla_v100:1  # number of gpus per node
#SBATCH --mem=4G                 # total memory per node (4G per cpu-core is default)
#SBATCH --time=00:00:30          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fault
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --reservation=hpcr       # REMOVE THIS LINE AFTER THE WORKSHOP

# Load the CUDA toolkit and libraries
module load cudatoolkit/9.2

# Standard MKL configuration for R and OpenMP threading
module load intel-mkl
export MKL_INTERFACE_LAYER=GNU,LP64
export MKL_THREADING_LAYER=GNU

# CUDA config
# - Set the path to your nvblas file
export NVBLAS_CONFIG_FILE=$HOME/nvblas.conf
# - Set the path to your cuda libs for the PRELOAD later
CUDA_DIR=/usr/local/cuda-9.2

# Preload the path to libnvblas.so, no need for the MKL preload
# since nvblas.conf handles that for us.
LD_PRELOAD="$CUDA_DIR/lib64/libnvblas.so" srun Rscript test.R
