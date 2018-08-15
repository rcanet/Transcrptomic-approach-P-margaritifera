#!/bin/bash
#PBS -N trimmomatic__BASE__
#PBS -o 98_log_files/samtools_flagstat.out
#PBS -l walltime=06:00:00
#PBS -l mem=80g
#####PBS -m ea
#PBS -l ncpus=4
#PBS -q omp
#PBS -r n


. /appli/bioinfo/samtools/latest/env.sh

base=__BASE__

samtools flagstat 04_mapped/transcriptome/$base" > 04_mapped/transcriptome/"$base"_samtools_flagstat.txt
