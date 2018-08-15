#!/usr/bin/env bash
#PBS -q omp
#PBS -l walltime=01:00:00
#PBS -l ncpus=2
#PBS -l mem=20g
#PBS -o 98_log_files/vcftools.err

# Definition des variables
INPUT=06_snp/01_couleur_freebayes_nAlleles_4_minMapQ_20_minCov_5.vcf
OUTPUT=06_snp/test/02_couleur_freebayes_nAlleles_4_minMapQ_20_minCov_5
KEEP=06_snp/list_individuals_to_keep.txt

# Filtration du vcf

vcftools --vcf "$INPUT" \
	--max-maf 0.6 \
	--maf 0.4 \
	--out "$OUTPUT" \
	--recode \
	--max-missing 1 \
	--max-alleles 2 \
	--remove-indels \
	--keep "$KEEP"
