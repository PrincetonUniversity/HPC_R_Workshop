library(Rmpi)
library(doMPI)

# Some historic datasets
library(HistData)

# This is Galton's data mapping the height of sons to their fathers
# It's a dataframe of 900ish rows with two columns, so nice and 
# easy for our example.
data(Galton)


# If you used srun, no need to pass any parameters here
# the MPI cluster is already arranged for you.
cl <- startMPIcluster()
registerDoMPI(cl)

# Splitting the Galton data frame (mapped to df) into
# units of 100 rows max.
df <- Galton
n <- 100
nr <- nrow(df)
# uses rep to specify the break points without having to manually call each
split_df <- split(df, rep(1:ceiling(nr/n), each=n, length.out=nr))

# In some hypotethical universe, I might want to know the ratio of
# the parent's height vs the child's
# foreach takes parameters and passes them to the MPI worker processes
# using the dimension of the parameter with the longest length (only one here)
# .combine= specifies a function that will be used to combine the results, i.e.
# cbind, rbind, c, etc.
df$results <- foreach(i=1:length(split_df), .combine='rbind') %dopar% {

    # I take the split lists of data frame, add a column called $ratio
    # and assign the result just as I would with a non-parallelized operation
    result <- split_df[[i]]$parent/split_df[[i]]$child
    as.data.frame(result)
    # this result gets rbind-ed together as a column on our df.
}

# Take a look a the df we got back that we could continue working on if we wanted to
head(df)

# close the cluster to properly free up the MPI resources so SLURM
# will declare the job 'done'.
closeCluster(cl)
Rmpi::mpi.quit()
