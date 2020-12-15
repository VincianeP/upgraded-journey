#! /bin/bash

data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to store the output of TransDecoder
mkdir -p transdecoder_data
cd transdecoder_data

# Launch Transdecoder
# Work in 2 or 3 steps (the second is facultative)
# Step 1: extract the long open reading frames (TransDecoder.LongOrfs)

TransDecoder.LongOrfs -t $data/trinity_data/Trinity.fasta -S --gene_trans_map $data/trinity_data/Trinity.fasta.gene_trans_map -O $data/transdecoder_data


# Step 2: blast to identify peptides with homology to known proteins (optionnal) 
# Step 3: predict the likely coding regions (TransDecoder.Predict)

TransDecoder.Predict -t $data/trinity_data/Trinity.fasta --single_best_only -O $data/transdecoder_data

