#!/bin/bash
#SBATCH --job-name=R-mkl         # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=2        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fault

module purge
module load R/4.4.0  # R/4.4.1 on della (R/4.4.0 on adroit)

# This sets the intel-mkl to use the GNU interface, which 
# is more compatible with R
export  MKL_INTERFACE_LAYER=GNU,LP64
export  MKL_THREADING_LAYER=GNU

module load intel-mkl/2020.1
LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so srun Rscript test.R
