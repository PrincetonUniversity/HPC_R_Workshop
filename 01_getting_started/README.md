# Getting started 

## What's this cluster thing?

When you connect to Adroit, or any of the university clusters aside
from Nobel, you're connecting to a 'head node', which is a computer
that connects to many others that are linked together for computation
called a 'cluster'.

The head node shares a file system with the clusters, and it is where
you should upload code, install R packages, and can allow for an 
occassional 10-15 minute test run.

## SLURM and where to compute

Your computational jobs should be submitted using the scheduling software
called SLURM (Simple Linux User Resource Management). It divides up the 
computing nodes and their CPUs (up to 20 per node) fairly and equitably.
Running without using the scheduler (i.e. on the head node) will cause
our sysadmins to take action up to throttling your CPU usage. It also 
means you can't use the full resources of multiple nodes in some cases.
So it is only disadvantageous to you.

## Installing Packages and accessing R

The latest or near-latest version of R is installed on all Research Computing
clusters. It requires no additional module loading and is simply available
from the command line as R.

```shell
$ R
```

That will launch the R commandline interpreter, (what RStudio calls the
'console '), which you'll need to engage in the first step of installing 
packages.

Choose an arbitrary package you might need. I like `data.table`. From the
console enter

```R
> install.packages("data.table")
```

You will then be prompted to set a directory to install packages in your 
home directory. Confirm this and choose a CRAN mirror that is geographically
close-ish. 

The package should install and you won't need to answer the directory or 
mirror questions again.

## Installation Gotchas

Laying aside complexities such as MPI packages that require a module to
find the OpenMPI libraries, there are a few frequent 'gotchas' that cause
trouble for new users.

* **The install requires a newer GCC** Enterprise Linux systems often have
compilers that lag behind the state of the art to provide the stability 
expected of them. There are modules that you can load from the commandline that
will provide these. For gcc, simply use `module load rh/devtoolset/8` and then
invoke R to install packages. 

* **A very large package uses all of your quota.** The exact error this produces
may vary but the easiest way to be sure that it might be a culprit is to run
the custom `checkquota` command. If your `/home/` quota is full, follow the
link in the command to request some more space for the package install.

* **R requires another library to compile the package.** This is a thorny problem.
Some packages may be available on the system but R isn't finding them for some reason,
or you may need to do an install of the libaries and add them to your R Makevars. Here
an email to `cses@princeton.edu` with the cluster you're on and what you're trying to
do would be a very good strategy for proceeding. 
