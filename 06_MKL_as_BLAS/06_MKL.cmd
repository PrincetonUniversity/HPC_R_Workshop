#!/bin/bash
#SBATCH --job-name=R-mkl        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=2        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on start, end and fault
#SBATCH --mail-user=<YourNetID>@princeton.edu

# This sets the intel-mkl to use the GNU interface, which 
# is more compatible with R
export  MKL_INTERFACE_LAYER=GNU,LP64
export  MKL_THREADING_LAYER=GNU

module load intel-mkl
LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so Rscript test.R
