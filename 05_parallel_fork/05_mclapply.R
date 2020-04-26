library("parallel")
# taken from https://garthtarr.com/parallel-computation-in-r/
X <- data.frame(matrix(rnorm(1e+07), ncol = 200))
ntasks <- as.numeric(Sys.getenv("SLURM_CPUS_PER_TASK"))
print(mclapply(X, median, mc.cores = ntasks))
