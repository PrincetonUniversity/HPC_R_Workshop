# Rmpi and doMPI

## Rmpi
Rmpi is a powerful wrapper that allows R to make calls using the 
MPI (Message Passing Interface), which is an API that lets 
processes running on different processors (and even different nodes)
communicate with one another. 

It has a few caveats (memory is not shared across nodes, for example) and
copies of objects may take extra memory, but it can be very, very quick.

Rmpi also has a low-level interface for talking to MPI and the scheduler
but that can be both tedious and requires a fair knowledge of how MPI
works in the first place.

Many R wrappers exist to bridge this gap, and this example uses one:
do MPI.

## Installing Rmpi and doMPI
Getting Rmpi installed can be a minor but not severe challenge. Generally 
you will need to do two things: 1) module load an updated compiler (as a suggestion)
and 2) configure your environment to point to the server's OpenMPI install.

Before invoking R to use `install.packages`, first do the following on the head node:

```shell
module load rh/devtoolset/6
module load openmpi/gcc/2.1.0/64
export MPI_ROOT=/usr/local/openmpi/2.1.0/gcc/x86_64
```

This puts a more up to date GCC on your path, adds the OpenMPI headers, and 
sets an environment variable R needs to find the OpenMPI you just loaded.

Then invoke R and run:

```R
install.packages(c("Rmpi", "doMPI", dependencies = TRUE)
```

You'll then need to pick an R mirror. If you are having issues with this,
and you've loaded the modules you want just run `install.R` on the head node
and the install will happen automatically.

While you're at it `install.packages('HistData')` since we're using
it in the next example.

## The example
This example shows off `doMPI`'s extensiont to R's `foreach` function, which
can divide up a repeated function and avoids using costly `for` loops. By using
`%dopar%` as our operator and invoking Rscript using `srun`, we ensure that the
MPI processes and the allocated nodes/cores are available to `Rmpi`.

Take a look a the SLURM script for more details on how to allocate, and the 
`04_doMPI.R` script for an explanation of how it works, then try running it.
