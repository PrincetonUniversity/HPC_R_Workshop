# MKL as BLAS

R's BLAS (Basic Linear Algebra Subprogram) is usually 
mantained as a dynamically linked library that can be swapped
out. (In fact, you can do this on your local machine too, though
being careful when you move around .so files.)

The cluster install does not allow for this. (Otherwise
swapping BLASes would turn into a compatibility nightmare.)
Instead what you will need to do is take advantage of the fact
that R will load the first BLAS it finds, so you can happily use
the LD_PRELOAD to get access to the Intel Math Kernel Library's 
multithreading version of the BLAS functions.

This means that when you run a job without ANY other parallelization
allocating 2-4 cores (`#SBATCH -c 3`, for example) will yield 
improvements on BLAS functions, especially matrix operations and 
things like linear discriminant analysis.

It is not always as extreme as you might think, because our R 
is compiled with OpenBLAS, which has the similar fucntionality.

## Examples

There are two examples in this folder that both run `test.R`, which
is adapted from a benchmark written by the folks at Microsft Open R
(which uses MKL by default and is available for install on your 
home machines). 

You can see the basic setup, which loads the module for intel-mkl and
then preloads the approprate linked library when invoking Rscript.

That's it. If you run the two scripts, you will get improved performance.
They are fairly short, but you can see that functions that can use a threading BLAS get much improved performance.
  
The one caveat (and what makes this a sometimes solution), is that 
efficiency drops off precipitously beyond 2-4 cores, as the MKL can 
only sub in for so much. You should attempt some short tests of your 
code if possible to determine the optimum core count that trades efficiency
for the right number of cores, otherwise you'll waste more time in
the queue than you gain by tying up cores that you're barely touching.

(For example, the script in this uses 2 cores at roughly 70% efficiency
and makes minimal gains when adding one more to 3.) 
