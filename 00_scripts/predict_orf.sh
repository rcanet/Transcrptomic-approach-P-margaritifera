#!/bin/bash

#PBS -q omp
#PBS -l ncpus=2
#PBS -l mem=60gb
#PBS -l walltime=24:00:00
#PBS -o 98_log_files/TransDecoder.out

#Global variables
ASSEMBLY=/home1/datawork/rcanet/rna-seq_mapping_workflow/manteau/01_info_files/Trinity.100aaorf.minexpr0.5/Trinity.100aaorf.minexpr0.5.fa	#path to transcriptome assembly or fasta file
TRANSDECODER_LONGORF=/home1/datawork/rcanet/rna-seq_mapping_workflow/manteau/01_info_files/TransDecoder-TransDecoder-v5.3.0/TransDecoder.LongOrfs	#path to transdecoder LongOrfs (.../TransDecoder-5.3.0/TransDecoder.LongOrfs)
MINPROT=100
WORKING_DIRECTORY=/home1/datawork/rcanet/rna-seq_mapping_workflow/manteau/06_snp/snp_identity_orf	#path to working/output directory

mkdir -p $WORKING_DIRECTORY

cd $WORKING_DIRECTORY

time $TRANSDECODER_LONGORF -t $ASSEMBLY -m $MINPROT 
  


