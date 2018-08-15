#!/bin/bash

for i in $(ls 04_mapped/transcriptome/*.A*.bam)

do
base="$(basename $i)"

        toEval="cat 00_scripts/04_samtools_flagstat.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/datarmor_jobs/SFS_$base.sh
done


#Submit jobs
for i in $(ls 00_scripts/datarmor_jobs/SFS*sh); do qsub $i; done

# Clean past jobs

rm 00_scripts/datarmor_jobs/SFS_*sh


