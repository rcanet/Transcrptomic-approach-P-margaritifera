#!/usr/bin/env bash
#PBS -N jctseq.__BASE__
#PBS -o 98_log_files/log-jctseq.__BASE__.err
#PBS -l walltime=02:00:00
#PBS -m ea
#PBS -l ncpus=1
#PBS -l mem=80g
#PBS -r n

# Move to present working dir
cd $PBS_O_WORKDIR


GTF="01_info_files/genome/Pmarg_trimmed.gtf"
GENOME="01_info_files/genome/Pmarg_trimmed.fasta"
INPUT=04_mapped/genome
OUTPUT=05_count_jctseq/star_mapping
base=__BASE__


# launch
java -jar -Xmx25g softwares/QoRTs-STABLE.jar QC \
                --stranded \
                --nameSorted \
                --minMAPQ 30 \
                --maxReadLength 100 \
                --genomeFA "$GENOME" \
                --runFunctions writeKnownSplices,writeNovelSplices,writeSpliceExon \
                "$INPUT"/"$base".paired.sortedByName.bam \
                $GTF \
                "$OUTPUT"/"$base"_jctseq/
                #--testRun \

