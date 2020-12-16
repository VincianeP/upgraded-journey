library("tximport")
library("readr")
library(apeglm)
library("DESeq2", quietly = T)

#Import the data
#Create a table containing the conditions (name of the runs and color of the skin analyzed)
dir <- '/home/rstudio/data/mydatalocal/data'
samp.name <- c("SRR7591064","SRR7591065","SRR7591066","SRR7591067","SRR7591068","SRR7591069")
samp.color <- c("orange", "white", "orange", "orange", "white", "white")
samples <- data.frame(run=samp.name, condition=samp.color)

#Create a variable containing the path to each quant.sf file
files <- file.path(dir, "quantification_data",samples$run, "quant.sf")
names(files) <- samples$run

#Create a table containing col1=gene, col2=transcript
tx2gene <- read.table(file=paste(dir,"/trinity_data/Trinity.fasta.gene_trans_map", sep=""),
                      header=FALSE,sep="\t",col.names=c("geneid", "transcript_name"))[,c(2,1)]
                      
#tximport
txi <- tximport(files, type="salmon",tx2gene=tx2gene)
         
#DE
ddsTxi <- DESeqDataSetFromTximport(txi, colData=samples, design= ~ condition)

#Keep only expressed genes
keep <- rowSums(counts(ddsTxi)) >= 10
dds <- ddsTxi[keep,]

#Decide which condition is the reference 
dds$condition <- relevel(dds$condition, ref= "white")

dds <- DESeq(dds)