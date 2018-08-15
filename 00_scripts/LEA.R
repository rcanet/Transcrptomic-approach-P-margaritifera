#!/usr/bin/Rscript

setwd("12_LEA")

library("LEA")

genotype = lfmm2geno("data.lfmm")
obj.snmf = snmf(genotype, K = 1:9, entropy = T, ploidy = 2, project="new")

save(obj.snmf, file = "snmf.rda")

print("object snmf saved")

exit

obj.lfmm=lfmm("data.lfmm", "popfile.env", K = 2, rep = 5, project="new")

print("obj.lfmm created")

save(obj.lfmm, file = "obj.lfmm.rda")

#Record z-scores from the 5 runs in the zs matrix
zs = z.scores(obj.lfmm, K = 2)

#Combine z-scores using the median
zs.median = apply(zs, MARGIN = 1, median)

#Compute the GIF
lambda = median(zs.median^2)/qchisq(0.5, df = 1)
lambda

# compute adjusted p-values from the combined z-scores
adj.p.values = pchisq(zs.median^2/lambda, df = 1, lower = FALSE)

#histogram of p-values
hist(adj.p.values, col = "red")

# compute adjusted p-values from the combined z-scores
adj.p.values = pchisq(zs.median^2/.55, df = 1, lower = FALSE)

#histogram of p-values
hist(adj.p.values, col = "green")

print("histogram of adjusted p-value done")

save.image(file="Env_lfmm_padj.rda")

## FDR control: Benjamini-Hochberg at level q
## L = number of loci
L = 145123
#fdr level q
q = 0.1
w = which(sort(adj.p.values) < q * (1:L)/L)
candidates.bh = order(adj.p.values)[w]

## FDR control: Storey's q-values 
library(qvalue)
plot(qvalue(adj.p.values))
candidates.qv = which(qvalue(adj.p.values, fdr = .1)$signif)

save.image(file="myEnvironment.rda")
