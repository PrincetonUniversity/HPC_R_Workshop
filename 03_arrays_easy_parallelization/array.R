# Get the $SLURM_JOB_ID variable from the environment created by Slurm
job_id <- Sys.getenv('SLURM_ARRAY_JOB_ID')
task_id <- Sys.getenv('SLURM_ARRAY_TASK_ID')

print(paste("My job_id is", job_id))
print(paste("My task_id is", task_id))

