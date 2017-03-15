#!/usr/bin/env Rscript

#library("ballgown")
library(ballgown)

args = commandArgs(trailingOnly = TRUE)

# fileConn<-file(args[2])
# writeLines(c(paste('<body style="background-color:red">',args[1],'</body>')), fileConn)
# close(fileConn)
#

phendata = read.csv(args[1])
write.csv(phendata, file = args[2])
filtstr = 0.5
pdat = 2
out="results"

# Creation of the ballgown object based on data
# ----------------------------------------------------------------------------------------
bgi = ballgown(samples= args[2] , pData = phendata)

# #bgi = ballgown(dataDir = , samplePattern = , pData = phendata)

# Filter the genes with an expression superior to the input filter
# ----------------------------------------------------------------------------------------
# bgi_filt= subset(bgi, paste("rowVars(texpr(bg_chrX)) >",filtstr), genomesubset = TRUE)
#

# r_transcript=stattest(bgi_filt,feature = "transcript", covariate = colnames(pData(bgi))[2], adjustvars = colnames(pData(bgi)[3]), getFC = TRUE, meas = "FPKM")
# r_genes=stattest(bgi_filt,feature = "gene", covariate = colnames(pData(bgi))[pdat], adjustvars = colnames(pData(bgi)[pdat+1]), getFC = TRUE, meas = "FPKM")
#
# results_transcripts = data.frame(geneNames=ballgown::geneNames(bgi_filt), geneIDs=ballgown::geneIDs(bgi_filt), results_transcripts)
# results_transcripts = arrange(results_transcripts,pval)
# results_genes = arrange(results_genes,pval)
#
# write.csv(results_transcripts, paste(out,"_transcript.csv"), row.names = FALSE)
# write.csv(results_genes, paste(out,"_genes.scv"), row.names = FALSE)
