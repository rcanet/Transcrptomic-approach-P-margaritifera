#!/usr/bin/env bash
#PBS -N htseq.__BASE__
#PBS -o 98_log_files/htseq.__BASE__.err
#PBS -l walltime=04:00:00
#PBS -m ea
#PBS -l ncpus=1
#PBS -l mem=50g
#PBS -r n


# Move to present working dir
cd $PBS_O_WORKDIR


# Load htseq

#Global variables
DATAINPUT="04_mapped/transcriptome"
DATAOUTPUT="05_count"
DATAOUTPUT_SPLICE=""

GFF_FOLDER="01_info_files"
GFF_FILE="Trinity.100aaorf.minexpr0.5.gff3"

#launch script
base=HI.4112.001.D707---D506.X4

# for gene expression
htseq-count -f "bam" -s "no" -r "pos" -t "CDS" -i "Name" --mode="union" "$DATAINPUT"/"$base".sorted.bam "$GFF_FOLDER"/"$GFF_FILE" >>"$DATAOUTPUT"/htseq-count_"$base".txt

# for splicing variations
#htseq-count -f="bam" -s="no" -r="pos" -t="exon" -i="gene" --mode="union" "$DATAINPUT"/"$base".sorted.bam "$GFF_FOLDER"/"$GFF_FILE" >>"$DATAOUTPUT_SLPICE"/htseq-count_"$base".txt
