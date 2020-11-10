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
and 2) configure your environment to point to the server's OpenMPI install. Here is the installation procedure:

### Della

```shell
$ module load rh/devtoolset/8 openmpi/gcc/3.1.5/64
$ export MPI_ROOT=/usr/local/openmpi/3.1.5/gcc/x86_64
$ R
> install.packages(c('doMPI', 'HistData'), repo='https://cloud.r-project.org/')
```

If you are using Rmpi on Della and you find that jobs hang then add this line to the end of your R script:

```
Rmpi::mpi.quit()
```

### Adroit

```shell
$ module load rh/devtoolset/8 openmpi/gcc/3.1.5/64
$ export MPI_ROOT=/usr/local/openmpi/3.1.5/gcc/x86_64
$ R
> install.packages(c('doMPI', 'HistData'), repo='https://cloud.r-project.org/')
```

Note that you should take care to run SLURM scripts using the same version of openmpi
that you used while compiling Rmpi. Equally note that versions available will vary slightly
across the clusters.

## The example
This example shows off `doMPI`'s extension to R's `foreach` function, which
can divide up a repeated function and avoids using costly `for` loops. By using
`%dopar%` as our operator and invoking Rscript using `srun`, we ensure that the
MPI processes and the allocated nodes/cores are available to `Rmpi`.

Take a look a the SLURM script for more details on how to allocate, and the
`04_doMPI.R` script for an explanation of how it works, then try running it.
