# Running a basic R job. 

### Rscript

You will see old guides pointing to `R CMD BATCH` as a way to invoke 
R scripts from the command line. This has been superseded by a single
point of running, `Rscript`. At its most basic, on Linux you would
run an R script by invoking:

```shell
Rscript myscript.R
```

However, if you do that on a scheduled cluster, you will be running 
on the login node and interfering with the work of others (e.g., code building, file transfers). So instead all production jobs must be submitted to the Slurm job scheduler.

### Anatomy of a Slurm Script

To do this, you wrap a simple bash script with the parameters for the `sbatch`
utility, and make your call to `Rscript` within that script. As an example,
see the included `02_simple_submit.cmd` and `Hello.R`, the first of which is heavily
notated. The second of which uses R's `print` function to write 'Hello world!'
to stdout.

To run it, from the `02` directory:

```shell
$ sbatch 02_simple_submit.cmd
```

See our [Slurm knowledge base page](https://researchcomputing.princeton.edu/support/knowledge-base/slurm) for more information.

### Where do my results go?
The job will be scheduled (you'll get a notice as to the number). You can see where you
are in the queue with the command:

```
$ squeue --me
```

This job will be so short you'll probably not be able to run these.

Output from stdout (i.e. any print statements) will be by default written to a file labeled
`slurm-XXXXXXX.out` in the current working directory from which you call `sbatch`.

Other files you write (i.e., a pickled .RData or .csv of results) will output based on the working
directory of R and what paths you use in your code. You can also redirect output using the standard
bash redirect for stdout and stderr (`>`,`|`, etc.)

### Other settings
We will be experimenting with adjusting the other settings for `sbatch` later, especially ones
that vary the number of process and tasks. As a rule, unless you're using an underlying library
that offers parallelization either through threading or MPI (Message Passing Interface), R is 
going to use one node and one CPU-core. This means that effectively you aren't getting much more than
your local laptop is providing, which is why we have to parallelize! Even on a single node of Adroit
there are more than 30 CPU-cores. If you can use them, your jobs will complete much more quickly.

You may also have to adjust things like the default memory allocated, which is based on the number
of CPUs, which you can do using:

```bash
#SBATCH --mem=4G
```

Learm more about [allocating CPU memory](https://researchcomputing.princeton.edu/support/knowledge-base/memory) with Slurm.
