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

```shell
Rscript process_df.R $SLURM_ARRAY_TASK_ID
```
Then use those different numbers to subset your data for processing.

Run the commands below to submit the example job:

```
$ git clone https://github.com/PrincetonUniversity/HPC_R_Workshop
$ cd HPC_R_Workshop/03_arrays_easy_parallelization
$ cat array.R
$ cat 03_array.cmd
$ sbatch 03_array.cmd
```

The Slurm script `03_array.cmd` uses:

```
Rscript array.R
```

The R script `03_array.cmd` stores the value of the enviroment variable `SLURM_ARRAY_TASK_ID` in `task_id`:

```
task_id <- Sys.getenv('SLURM_ARRAY_TASK_ID')
```

#### Job Arrays as a Divide and Conquer Solution

You can also use the array ID to separate out or subset in other ways. `03_iris_example.cmd` does just that,
using a simple set of `if` statements to subset a dataframe and process a selected portion.

Run the commands below to submit the job:

```
$ cat 03_iris.R
$ cat 03_iris_example.cmd
$ sbatch 03_iris_example.cmd
```

For more on job arrays see our [Slurm webpage](https://researchcomputing.princeton.edu/support/knowledge-base/slurm#arrays).
