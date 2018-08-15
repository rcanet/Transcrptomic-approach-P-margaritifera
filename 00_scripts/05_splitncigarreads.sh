#!/usr/bin/env bash
#PBS -o 98_log_files/SpliceNCigarReads__BASE__.transcriptome.out
#PBS -q sequentiel
#PBS -l ncpus=1
#PBS -l mem=50g
#PBS -l walltime=02:00:00


# VARIABLES GLOBALES
data=04_mapped/transcriptome/
outdir=04_mapped/transcriptome/cigared
ref=01_info_files/transcriptome_STAR/Trinity.100aaorf.minexpr0.5.fa
tmp=
pic=softwares/picard-tools-1.119


file=__BASE__

#Marking duplicates and removing them
cd ${data}
time java -jar -Djava.io.tmpdir=$tmp ${pic}/MarkDuplicates.jar I=${file} O=${outdir}/${file%.*}_MD.bam M=${outdir}/${file%.*}_MD_metrics.txt ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=true CREATE_INDEX=TRUE ;

file=${outdir}/${file%.*}_MD.bam

#Sorting & indexing bam files and correcting & filtering reads
cd ${outdir}

samtools sort ${file} > ${file%.*}_sorted.bam ;
samtools index ${file%.*}_sorted.bam  > ${file%.*}_sorted.bam.bai  ;

time gatk SplitNCigarReads --TMP_DIR ${tmp} -R $ref -I ${file%.*}_sortedByName_MD.bam -O ${file%.*}_sorted_split.bam ;

#-rf ReassignOneMappingQuality -RMQF 255 -RMQT 60 -U ALLOW_N_CIGAR_READS ;


samtools index ${file%.*}_sorted_split.bam > ${file%.*}_sorted_split.bam.bai ;
samtools flagstat ${file%.*}_sorted_split.bam > ${file%.*}_sorted_split.bam.flagstat ;

#Add read group information to bam files
id=${file##*.}
id=${file%.*}
time java -jar -Djava.io.tmpdir=$tmp ${pic}/AddOrReplaceReadGroups.jar I=${file%.*}_sorted_split.bam O=${file%.*}_sorted_split_RG.bam RGID=${id} RGLB=${id} RGPL=illumina RGPU=${id} RGSM=${id}

#Sorting & indexing final bam files
samtools index ${file%.*}_sorted_split_RG.bam > ${file%.*}_sorted_split_RG.bam.bai ;
samtools flagstat ${file%.*}_sorted_split_RG.bam > ${file%.*}_sorted_split_RG.bam.flagstat ;

#Removing int files
rm ${file%.*}_sorted_split.bam
rm ${file%.*}_sorted.bam
rm ${file%.*}_sorted.bam.bai
rm ${file}
