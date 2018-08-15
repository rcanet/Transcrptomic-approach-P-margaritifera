#!/usr/bin/env python
# -*- coding: utf-8 -*-

####	Script by Pauline Auffret	####

import sys
from Bio.Seq import Seq
from Bio.Alphabet import generic_dna
from Bio import SeqIO
import difflib 

fasta_file = "11_snp_analysis/Names/list_sequences_trianalyse.fa" #transcript fasta file
orf_file = "11_snp_analysis/Names/longest_orf.cds" #cds fasta file
snp_file = "11_snp_analysis/Names/trianalyse.vcf" #SNP info text file (4 columns : CHROM	POS	REF	ALT)
out_file = "11_snp_analysis/Names/identified_SNPs_tri_analysis.txt" #outfile

#Read SNP info file and save in a dictionary
snpF=open(snp_file, "rU")
snp_info=dict()
line=snpF.readline()
while line :
	if not line.startswith("CHROM") :
		line=line.replace("\n","")
		line=line.split("\t")		
		snp_info[line[0]]=[line[1],line[2],line[3]]
	line=snpF.readline()
#print snp_info

#read ORF file and save in a dictionary
orfF=open(orf_file, "rU")
orf_info=dict()
seq=""
id=""
nbSeq=0
line=orfF.readline()
while line :
	if line.startswith(">") :
		if nbSeq!=0 :
			orf_info[str(id)]=str(seq)
		id=line.replace(">","").replace("\n","")
		seq=""
		nbSeq=nbSeq+1
	else :
		line=line.replace("\n","")
		seq=seq+line
	line=orfF.readline()
orf_info[str(id)]=str(seq)


#Get information on protein translated ORF
outF=open(out_file, "w")
outF.write("CHROM\tORF_start\tORF_end\tsyn\tstrand\torf_nt_seq\torf_prot_seq\tmut_nt_seq\tmut_prot_seq\taa_ref\taa_mut\n")
for key in orf_info : 
	syn="SYN"
	orf_seq=orf_info[key]
	key=key.split(" ")
	tr_name=key[3].split(":")[0]
	start=int(key[3].split(":")[1].split("-",1)[0])
	end=int(key[3].split(":")[1].split("-",1)[1].split("(")[0])
	strand=key[3].split(":")[1].split("-",1)[1].split("(")[1].split(")")[0]
	if end<start :
		tmp = start
		start = end
		end = tmp
	pos=int(snp_info[tr_name][0])
	ref=snp_info[tr_name][1]
	alt=snp_info[tr_name][2]
	if int(pos) < int(start) or int(pos) > int(end):
		syn="NOT IN ORF"
		orf_seq="NA"
		prot_orf="NA"
		seq_mut="NA"
		prot_seq_mut="NA"
		aa_ref="NA"
		aa_mut="NA" 
	else :
		orf_pos = int(pos)-int(start)+1
		orf_pos_prot = orf_pos/3
		orf_seq = str(orf_seq)
		#REF and ALT are always given on forward strand so need to rev_complement if the ORF is given on the - strand
		if strand == "-" :
			orf_seq=Seq(orf_seq)
			orf_seq=orf_seq.reverse_complement()
		orf_pos_nt=orf_seq[orf_pos-1]
		if orf_pos_nt != ref :
			print "Error in determining the ref allele in ORF sequence." 
		seq_mut=list(orf_seq)
		seq_mut[orf_pos-1]=str(alt)
		seq_mut=''.join(seq_mut)
		orf_seq=Seq(str(orf_seq),generic_dna)
		seq_mut=Seq(str(seq_mut),generic_dna)
		#Back to rev comp with ALT in correct position
		if strand == "-" :
			seq_mut=seq_mut.reverse_complement()
			orf_seq=orf_seq.reverse_complement()
		prot_orf=orf_seq.translate()
		prot_seq_mut=seq_mut.translate()
		#print orf_seq
		#print orf_pos
		aa_ref = prot_orf[orf_pos_prot-1]
		aa_mut = prot_seq_mut[orf_pos_prot-1]
		if aa_ref != aa_mut :
			syn="NON SYN"
	the_big_list=[tr_name,start,end,syn,strand,orf_seq,prot_orf,seq_mut,prot_seq_mut,aa_ref,aa_mut]
	for elem in the_big_list :
		outF.write(str(elem)+"\t")			 
outF.write("\n")
