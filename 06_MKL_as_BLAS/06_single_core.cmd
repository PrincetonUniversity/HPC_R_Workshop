#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 05:00
# This uses the class reservation and will only work for our 
# class today, in the future, remove this from your SBATCH
# SBATCH -p class

/usr/bin/Rscript test.R

