#!/bin/bash

#PBS -N STAR.__BASE__
#PBS -o 98_log_files/STAR.__BASE__.err
#PBS -l walltime=24:00:00
#PBS -l mem=100g
#####PBS -m ea
#PBS -l ncpus=12
#PBS -q omp
#PBS -r n

cd $PBS_O_WORKDIR

base=__BASE__

#Test - Global variables
DATAOUTPUT="04_mapped/genome/${base}"
DATAINPUT="03_trimmed"

# For genome
GENOMEFOLDER="01_info_files/genome_STAR"

platform="Illumina"

    # Align reads
    echo "Aligning $base"

STAR --runMode alignReads \
	--runThreadN 12 \
	--genomeDir "$GENOMEFOLDER" \
	--readFilesCommand zcat \
	--readFilesIn "$DATAINPUT"/"$base"_R1.paired.fastq.gz "$DATAINPUT"/"$base"_R2.paired.fastq.gz \
	--outSAMtype BAM SortedByCoordinate \
	--outFileNamePrefix "$DATAOUTPUT" \
	--outFilterMismatchNmax 5 \



#Create BAM files
    echo "Creating bam for $base"
samtools view -b -f 0x2 -F 3340 "$DATAOUTPUT"Aligned.sortedByCoord.out.bam > "$DATAOUTPUT".paired.sortedByCoord.bam # F 256
samtools sort -n "$DATAOUTPUT".paired.sortedByCoord.bam -o "$DATAOUTPUT".paired.sortedByName.bam
samtools index "$DATAOUTPUT".paired.sortedByName.bam

