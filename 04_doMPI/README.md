# Rmpi and doMPI

### Rmpi
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
doMPI.

### Installing Rmpi and doMPI

Getting Rmpi installed is somewhat harder than most R packages. Generally
you will need to do two things: 1) load an MPI library module and 2) set an environment variable which specifies the base path of the MPI library. Here is the installation procedure:

q#### Della

```shell
$ module load openmpi/gcc/4.1.0
$ export MPI_ROOT=/usr/local/openmpi/4.1.0/gcc
$ R
> install.packages(c('doMPI', 'HistData'), repo='https://cloud.r-project.org/')
```

If you are using Rmpi on Della and you find that jobs hang then add this line to the end of your R script:

```
Rmpi::mpi.quit()
```

#### Adroit

```shell
$ module load openmpi/gcc/4.1.0
$ export MPI_ROOT=/usr/local/openmpi/4.1.0/gcc
$ R
> install.packages(c('doMPI', 'HistData'), repo='https://cloud.r-project.org/')
> q()
```

Next, submit the job:

```bash
$ cd HPC_R_Workshop/04_doMPI
$ sbatch 04_doMPI_onAdroit.cmd
```

After the job runs, inspect the output:

```
$ cat slurm-*.out
Loading required package: foreach
Loading required package: foreach
Loading required package: foreach
Loading required package: iterators
Loading required package: iterators
Loading required package: foreach
Loading required package: iterators
Loading required package: iterators
  parent child   result
1   70.5  61.7 1.142626
2   68.5  61.7 1.110211
3   65.5  61.7 1.061588
4   64.5  61.7 1.045381
5   64.0  61.7 1.037277
6   67.5  62.2 1.085209
```

Note that you should take care to run SLURM scripts using the same version of openmpi
that you used while compiling Rmpi. Equally note that versions available will vary slightly
across the clusters.

### The example

This example shows off `doMPI`'s extension to R's `foreach` function, which
can divide up a repeated function and avoids using costly `for` loops. By using
`%dopar%` as our operator and invoking Rscript using `srun`, we ensure that the
MPI processes and the allocated nodes/cores are available to `Rmpi`.

Take a look a the SLURM script for more details on how to allocate, and the
`04_doMPI.R` script for an explanation of how it works, then try running it.
