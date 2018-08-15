#!/bin/bash

#PBS -N STAR.__BASE__
#PBS -o 98_log_files/STAR_transcriptome.__BASE__.err
#PBS -l walltime=24:00:00
#PBS -l mem=50g
#####PBS -m ea
#PBS -l ncpus=12
#PBS -q omp
#PBS -r n

cd $PBS_O_WORKDIR


base=__BASE__

#Test - Global variables
DATAOUTPUT="04_mapped/transcriptome/${base}"
DATAINPUT="03_trimmed"

# For genome
GENOMEFOLDER="01_info_files/transcriptome_STAR"
GENOME="01_info_files/transcriptome_STAR/Trinity.100aaorf.minexpr0.5.gtf"

platform="Illumina"

    # Align reads
    echo "Aligning $base"

STAR --runMode alignReads \
	--runThreadN 12 \
	--genomeDir "$GENOMEFOLDER" \
	--sjdbGTFfile "$GENOME" \
	--readFilesCommand zcat \
	--readFilesIn "$DATAINPUT"/"$base"_R1.paired.fastq.gz "$DATAINPUT"/"$base"_R2.paired.fastq.gz \
	--outSAMtype BAM SortedByCoordinate \
	--outFileNamePrefix "$DATAOUTPUT" \
	--outFilterMismatchNmax 5 \
	--sjdbGTFfeatureExon CDS



#Create BAM files
	echo "Creating bam for $base" 
samtools view -b -f 0x2 -F 256 "$DATAOUTPUT"_Aligned.sortedByCoord.out.bam >"$DATAOUTPUT".sortedByNam.bam
samtools sort -n "$DATAOUTPUT".sortedByName.out.bam -o "$DATAOUTPUT".sortedByName.bam
samtools index "$DATAOUTPUT".sortedByName.out.bam

