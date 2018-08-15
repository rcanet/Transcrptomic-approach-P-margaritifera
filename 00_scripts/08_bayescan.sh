#!/bin/bash
#PBS -N bayescan
#PBS -o 98_log_files/bayescan.err
#PBS -l walltime=72:00:00
#PBS -l mem=60g
#PBS -l ncpus=8
#PBS -q omp


# Load conda environment

source activate bayescan


# Determination of the global variables

INPUT="08_bayescan/bayes_input.txt"
OUTPUT=08_bayescan/

bayescan2 $INPUT \
	-od $OUTPUT \
	-thread 8 \
	-out_freq 

