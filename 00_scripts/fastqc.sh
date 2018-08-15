#!/bin/bash
#PBS -N fastqc.__BASE__
#PBS -o 98_log_files/fastqc.__BASE__.out
#PBS -l walltime=06:00:00
#PBS -l mem=80g
#####PBS -m ea
#PBS -l ncpus=8
#PBS -q omp
#PBS -r n


base=__BASE__


fastqc /home1/scratch/rcanet/rna-seq_mapping_workflow/manteau/03_trimmed/*
