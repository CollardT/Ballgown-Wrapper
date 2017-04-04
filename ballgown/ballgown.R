#!/usr/bin/Rscript

# Enabling commands line arguments
# ----------------------------------------------------------------------------------------

args = commandArgs(trailingOnly = TRUE)

# Loading required libraries. suppressMessages() remove all noisy attachement messages
# ----------------------------------------------------------------------------------------

suppressMessages(library(ballgown, warn.conflicts = FALSE))
suppressMessages(library(genefilter, warn.conflicts = FALSE))
suppressMessages(library(dplyr, warn.conflicts = FALSE))

# Setup for the tool with some bases variables.
# ----------------------------------------------------------------------------------------

filtstr = 0.5
pdat = 2
phendata = read.csv(args[1])
setwd(args[2])

# Checking if the pdata file has the right samples names.
# ----------------------------------------------------------------------------------------
 
if (all(phendata$ids == list.files(".")) != TRUE)
{
  cat("Your phenotype data table does not match the samples names. ")
}

# Creation of the ballgown object based on data
# ----------------------------------------------------------------------------------------
bgi = ballgown(dataDir= "." , samplePattern="", pData = phendata, verbose = FALSE)

# Filter the genes with an expression superior to the input filter
# ----------------------------------------------------------------------------------------
bgi_filt= subset(bgi, paste("rowVars(texpr(bgi)) >",filtstr), genomesubset = TRUE)

# Creating the variables containing the transcripts and the genes and sorting them through the arrange() command.
# ----------------------------------------------------------------------------------------

results_transcripts=stattest(bgi_filt,feature = "transcript", covariate = colnames(pData(bgi))[pdat], adjustvars = colnames(pData(bgi)[pdat+1]), getFC = TRUE, meas = "FPKM")
results_genes=stattest(bgi_filt,feature = "gene", covariate = colnames(pData(bgi))[pdat], adjustvars = colnames(pData(bgi)[pdat+1]), getFC = TRUE, meas = "FPKM")

results_transcripts = data.frame(geneNames=ballgown::geneNames(bgi_filt), geneIDs=ballgown::geneIDs(bgi_filt), results_transcripts)
results_transcripts = arrange(results_transcripts,pval)
results_genes = arrange(results_genes,pval)

# Main output of the wrapper, two .csv files containing the genes and transcripts with their qvalue and pvalue
# ----------------------------------------------------------------------------------------

write.csv(results_transcripts, file=args[3], row.names = FALSE)
write.csv(results_genes, file=args[4], row.names = FALSE)
