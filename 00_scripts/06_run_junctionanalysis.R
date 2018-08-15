#!/usr/bin/Rscript

setwd("/home1/datawork/rcanet/rna-seq_mapping_workflow/manteau")


# load lib
library(JunctionSeq)

decoder<-read.table("01_info_files/genome/decoder.file.QoRTs.txt",header=T)

countFiles=c("05_count_jctseq/star_mapping/HI.4112.001.D707---D503.X1_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D707---D504.X2_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D707---D505.X3_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D707---D506.X4_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D707---D507.X6_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D707---D508.X7_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D708---D501.X8_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz",
"05_count_jctseq/star_mapping/HI.4112.001.D708---D502.X9_jctseq/QC.spliceJunctionAndExonCounts.withNovel.forJunctionSeq.txt.gz")


# Run basic analysis
jscs <- runJunctionSeqAnalyses(sample.files = countFiles,
	sample.names = decoder$sample.ID,
	condition=factor(decoder$group.ID),
	flat.gff.file = "05_count_jctseq/star_mapping/withNovel.forJunctionSeq.gff.gz",
	nCores = 1,
	analysis.type = "junctionsAndExons");

save(jscs,file="07_results_jctseq/jscs.rda")

exit

# Plots
buildAllPlots(jscs=jscs,
outfile.prefix = "07_results_jctseq/plots_jctseq/",
use.plotting.device = "png",
FDR.threshold = 0.01);
