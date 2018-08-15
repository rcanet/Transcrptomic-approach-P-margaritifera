#!/usr/bin/env bash
#PBS -o 98_log_files/error_freebayes.out
#PBS -q sequentiel
#PBS -l walltime=36:00:00
#PBS -l ncpus=1
#PBS -l mem=120g


cd $PBS_O_WORKDIR

#Working directories, input and output files
data=06_snp/list.input.freebayes.txt
outdir=06_snp/
ref="01_info_files/Trinity.100aaorf.minexpr0.5.fa"
tag="snp_subset_freebayes_v1"
tmp=/home1/scratch/rcanet


#Freebayes parameters 
nAlleles="0"
minMapQ="30"
minCOV=10
Ploidy=10


#Calling SNP with Freebayes on trimmed bam file
echo "Running Freebayes on ${data} samples..."

time freebayes -f $ref \
                --use-best-n-alleles $nAlleles \
                --min-mapping-quality $minMapQ \
                --no-indels \
 	        --no-complex \
        	--min-coverage $minCOV \
                --genotype-qualities \
                --bam-list ${data} \
                --vcf ${outdir}/diploid.${tag}.vcf 

