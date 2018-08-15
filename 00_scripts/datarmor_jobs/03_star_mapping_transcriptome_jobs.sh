#!/bin/bash


# Clean past jobs

rm 00_scripts/datarmor_jobs/star_mapping_transciptome_*sh


# launch scripts for Colosse
for file in $(ls 03_trimmed/*paired*.f*q.gz|sed 's/_R[12].paired.fastq.gz//g'|sort -u)
do

base=$(basename "$file")

        toEval="cat 00_scripts/03_star_mapping_transcriptome.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/datarmor_jobs/star_mapping_transciptome_$base.sh
done

#Submit jobs
for i in $(ls 00_scripts/datarmor_jobs/star_mapping_transciptome_*sh); do qsub $i; done

