#!/bin/bash
#PBS -N STAR_mapping
#PBS -o 98_log_files/starindex.err
#PBS -l walltime=24:00:00
#PBS -l mem=100g
#####PBS -m ea
#PBS -l ncpus=12
#PBS -q omp
#PBS -r n



# For genome
GENOMEFOLDER=01_info_files/transcriptome_STAR
GENOMEFASTA=01_info_files/transcriptome_STAR/Trinity.100aaorf.minexpr0.5.fa

#Genome Generation
STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $GENOMEFOLDER --genomeFastaFiles $GENOMEFASTA #--sjdbOverhang 99  
