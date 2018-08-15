#!/bin/bash
#PBS -N STAR_mapping
#PBS -o 98_log_files/starindex.err
#PBS -l walltime=24:00:00
#PBS -l mem=100g
#####PBS -m ea
#PBS -l ncpus=12
#PBS -q omp
#PBS -r n

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)

# For genome
GENOMEFOLDER=01_info_files/genome_STAR
GENOMEFASTA=01_info_files/genome_STAR/Trinity.transcriptome.300118.fa
STAR=softwares/STAR-2.6.0a/bin/Linux_x86_64

#move to present working directory
cd 01_info_files/genome_STAR

#Genome Generation
$STAR/STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $GENOMEFOLDER --genomeFastaFiles $GENOMEFASTA --limitGenomeGenerateRAM 51089445589
