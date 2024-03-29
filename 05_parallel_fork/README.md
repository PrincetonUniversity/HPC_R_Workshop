# parallel library

R has built in multicore support under Linux that doesn't require MPI. If
your problem can use a more limited number of cores, it offers an easy
(very easy) way to use the number of cores you have using a suite of functions
that are part of the built-in `parallel` library, which builds on two
older packages (`multicore` and `snow`). `snow` still exists and has
MPI and sockets cluster implementations (though the former has been
problematic with OpenMPI, so I do not recommend it).

`parallel` works by forking process from the parent, so the Slurm script
will look different. It will specify `--nodes=1` `--ntasks=1` (one node, one process)
and `--cpus-per-task=4`, which says assign four CPU-cores to that process.

This can only run across one node, but it is very quick, very easy, and it
can accomodate parallelizing operations across large dataframes readily.

It can also run on a socket based setup, but this is mostly for compatibility with Windows-based parallelism not applicable to the Research Computing clusters.

```bash
$ cd HPC_R_Workshop/05_parallel_fork
$ cat 05_mclapply.R
$ sbatch 05_mclapply.cmd
```

```bash
$ cd HPC_R_Workshop/05_parallel_fork
$ cat 05_parallel.R
$ sbatch 05_parallel.cmd
```

## The example

This is an adaptation of a standard parallelize and reduce that has (admittedly)
limited application. However, if you can use the apply family of functions, you
can do the same with their parallel breathren. It also demonstrates the
`--mem=50G` flag in the example script. The matrix we make is quite large, and
CPUs come with a default allocation that isn't quite enough, so we
just ask for more.

There is another example that uses `mclapply` to do the same thing at a higher level over a matrix (or dataframe).

There are also high-level frameworks that can take various backends using the `parallel` package a base. `doParallel` is a good example. See [this](https://github.com/PrincetonUniversity/intro_ml_libs/tree/master/R) machine learning example at Princeton which uses `caret` and `doParallel`.

If you are used to functional and futures programming, there is also the `furrr` and `purrr` packages that can use multicore processing to execute async and futures based R coding.
