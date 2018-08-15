#!/bin/bash

#Clean past jobs

rm 00_scripts/datarmor_jobs/parallelized_jobs/JCT_*sh

for i in $(ls 04_mapped/genome/*.paired.sortedByName.bam|sed 's/.paired.sortedByName.bam//g')

do
base="$(basename $i)"

        toEval="cat 00_scripts/05_junctionseq_count.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/datarmor_jobs/parallelized_jobs/JCT_$base.sh
done

#Submit jobs
for i in $(ls 00_scripts/datarmor_jobs/parallelized_jobs/JCT*sh); do qsub $i; done

