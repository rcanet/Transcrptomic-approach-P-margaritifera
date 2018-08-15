#!/bin/bash

# clean past jobs

 rm 00_scripts/datarmor_jobs/parallelized_jobs/STAR_genome_*sh


# launch scripts for Colosse
for file in $(ls 03_trrimmed/*.A*_R1.paired.fastq.gz | sed 's/_R1.paired.fastq.gz//g')
do

base=$(basename "$file")
        toEval="cat 00_scripts/03_star_mapping_genome.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/datarmor_jobs/parallelized_jobs/STAR_genome_$base.sh
done

# Submit jobs
for i in $(ls 00_scripts/datarmor_jobs/parallelized_jobs/STAR_genome_*.sh)	
do 
	echo $base
	qsub $i
done


