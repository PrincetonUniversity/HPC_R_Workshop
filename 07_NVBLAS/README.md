# Using R with NVBLAS

### When to use NVBLAS

This takes a bit more setup, and it is probably only worth it
if you are doing heavy matrix operations. Then the GPU really,
really shines. 

There are packages that use CUDA to handle matrices and vectors 
with the GPU directly, but they are in a sufficient state of flux
that all operations aren't supported or they use the OpenCL interface
and have much worse performance than CUDA native.

The other advantage of using [NVBLAS](https://docs.nvidia.com/cuda/nvblas/) is that you can just write R. No
packages, nothing special, just do your calls as you normally would.

It is worth noting that the NVBLAS is slower at non-matrix operations
than Intel MKL, so this is also a sometimes fix.


### Setup

By default, the Slurm script for this example looks for a file called `nvblas.conf`
located in your home directory. A sample file is included with comments for your
use.

Just copy it to your home directory and you're good to go. No libraries to install
or add. Note the commentary in the `.cmd` file for why things are set up as they
happen to be. Note that the directory for the CPU BLAS (intel-mkl) in `nvblas.conf` must point to the module that you load.

Here are the commands you need to run to launch the job:

```
$ cd HPC_R_Workshop/07_NVBLAS
$ cp nvblas.conf ~/
$ sbatch 07_NVBLAS.cmd
```
