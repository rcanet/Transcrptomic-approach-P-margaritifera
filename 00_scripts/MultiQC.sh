#!/bin/bash
#PBS -N MultiQC
#PBS -o 98_log_files/MultiQC_albinos.out
#PBS -l walltime=05:00:00
#PBS -l mem=50g
#PBS -l ncpus=8
#PBS -q omp


cd 02_data/

#	Analyse des séquences

source activate multiqc

multiqc -m fastqc . 
