#!/bin/bash
#PBS -N filt.jctseq
#PBS -o 98_log_files/filt.jctseq.err
#PBS -l walltime=02:00:00
#PBS -m ea
#PBS -l ncpus=1
#PBS -l mem=25g
#PBS -r n

# Move to present working dir
cd $PBS_O_WORKDIR

DECODER="01_info_files/genome/decoder.file.QoRTs.txt"
GTF="01_info_files/genome/Pmarg_trimmed.gtf"

java -jar -Xmx20g softwares/QoRTs-STABLE.jar \
                mergeNovelSplices \
                --minCount 6 \
                --stranded \
                05_count_jctseq/star_mapping/ \
                "$DECODER" \
                "$GTF" \
                05_count_jctseq/star_mapping/

