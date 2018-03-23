library(parallel)

ntasks <- as.numeric(Sys.getenv("SLURM_CPUS_PER_TASK"))
print(ntasks)
cl <- makeCluster(ntasks - 1, type="FORK")

parallelAvg <- function(m, n) {
    A <- matrix(rnorm(m*n), nrow = m, ncol = n)
    row.means <- parApply(cl, A, 1, mean)
    print(mean(row.means))
}

parallelAvg(50000, 50000)

stopCluster(cl)
