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
module load openmpi/gcc/2.1.0/64  # on della use openmpi/gcc/2.0.2/64
export MPI_ROOT=/usr/local/openmpi/2.1.0/gcc/x86_64
```

This adds the OpenMPI headers, and
sets an environment variable R needs to find the OpenMPI you just loaded.

We also need to avoid a pitfall where Rmpi tries to run an MPI process on the head node, which causes issues, so we will be installing Rmpi via source
and the shell command line.

```shell
wget https://cran.r-project.org/src/contrib/Rmpi_0.6-9.tar.gz
R CMD INSTALL --no-test-load Rmpi_0.6-9.tar.gz
```

Then you can `Rscript install.R` from the `04_doMPI` and the remaining packages
will install.


## The example
This example shows off `doMPI`'s extension to R's `foreach` function, which
can divide up a repeated function and avoids using costly `for` loops. By using
`%dopar%` as our operator and invoking Rscript using `srun`, we ensure that the
MPI processes and the allocated nodes/cores are available to `Rmpi`.

Take a look a the SLURM script for more details on how to allocate, and the
`04_doMPI.R` script for an explanation of how it works, then try running it.
