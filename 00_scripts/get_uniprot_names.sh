#!/bin/bash
#PBS -N uniprot
#PBS -o 98_info_files/uniprot.out
#PBS -l walltime=10:00:00
#PBS -l mem=30g
#PBS -l ncpu=4
#PBS -q omp


# Give the IDs of uniprot from 01_info_files/annotations.txt

OUTPUT=10_R/DEG/proteins_uniprot_DEG.txt

while read line
do
	wget -q -O - http://www.uniprot.org/uniprot/"$line".txt > "$OUTPUT"
done
