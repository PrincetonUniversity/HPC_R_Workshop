# Using R with NVBLAS

## When to use NVBLAS

This takes a bit more setup, and it is probably only worth it
if you are doing heavy matrix or vector operations. Then the GPU really,
really shines. 

There are packages that use CUDA to handle matrices and vectors 
with the GPU directly, but they are in a sufficient state of flux
that all operations aren't supported or they use the OpenCL interface
and have much worse performance than CUDA native.

The other advantage of using NVBLAS is that you can just write R. No
packages, nothing special, just do your calls as you normally would.

It is worth noting that the NVBLAS is slower at non-matrix operations
than Intel MKL, so this is also a sometimes fix.


# Setup

By default, the SLURM script for this example looks for a file called `nvblas.conf`
located in your home directory. I have included a sample file with comments for your
use.

Just copy it to your home directory and you're good to go. No libraries to install
or add. Note the commentary in the `.cmd` file for why things are set up as they
happen to be. Note that the directory for the CPU BLAS (intel-mkl) in `nvblas.conf` must point to the module that you load. Likewise, you should point `CUDA_ROOT` in `nvidia.cmd` to the CUDA install that you have module loaded. You can find these by printing the `LD_LIBRARY_PATH` variable in the shell, i.e. `print $LD_LIBRARY_PATH`.

Here are the commands you need to run to launch the job:

```
$ cd HPC_R_Workshop/07_NVBLAS
$ cp nvblas.conf ~
# edit 07_NVBLAS.cmd to include your email address
$ sbatch 07_NVBLAS.cmd
```
