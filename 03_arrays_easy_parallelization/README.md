## A simple parallelization with arrays

Slurm has a built-in method for running many similar tasks in parallel.
It also has the virtue of requiring no special libraries or packages
to exploit.

These are called array jobs, and that is the example that you see in `03_array.cmd`.
Go ahead and look at it and the `array.R` sample.

### How to actually use these

The toy script above did nothing other than print an array and its subtasks as 
they identified themselves. How would you use this for real? Since R can access
the arguments passed to RScript, you can use it to slice processing on a data frame
with relative ease.

Let's say you had a data frame of 500 rows and were running a simple `apply()` across
all 500 rows that was exactly the same. Not very big, but maybe you're doing something
computationally complex in a non-trivial example.

If you requested a Slurm allocation of 5 array jobs as follows (`--array=1,100,200,300,400`)
, you could then count on getting the
arguments 1,100,200,300,400 in your slurm script as an environment variable:

In your Slurm script:

```
$ cat 03_iris.R
$ sbatch 03_iris_sample.cmd
```

```shell
Rscript process_df.R $SLURM_ARRAY_TASK_ID
```
Then use those different numbers to subset your data for processing.

The Slurm script (`03_array.cmd`):

```
Rscript array.R
```

The R script stores the value of the enviroment variable `SLURM_ARRAY_TASK_ID` in `task_id`:

```
task_id <- Sys.getenv('SLURM_ARRAY_TASK_ID')
```

#### Passing the Array Index as a Command Line Argument

You can also use the array ID to separate out or subset in other ways. `03_iris_example.cmd` does just that,
using a simple set of `if` statements to subset a data frame and process a selected portion.

In the Slurm script:

```
Rscript 03_iris.R $SLURM_ARRAY_TASK_ID
```

The R script stores the array task ID as `start_index`:

```
start_index <- commandArgs(trailingOnly = TRUE)
```

### Commands to run on Adroit

```
$ git clone https://github.com/PrincetonUniversity/HPC_R_Workshop
$ cd HPC_R_Workshop/03_arrays_easy_parallelization
$ sbatch 03_array.cmd
```

For more on job arrays see our [Slurm webpage](https://researchcomputing.princeton.edu/support/knowledge-base/slurm#arrays).
