#! /bin/bash

data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to store the output of TransDecoder
mkdir -p transdecoder_data

# Launch Transdecoder
# Work in 2 or 3 steps (the second is facultative)
# Step 1: extract the long open reading frames (TransDecoder.LongOrfs)
# Step 2: blast to identify peptides with homology to known proteins (optionnal) 
# Step 3:predict the likely coding regions (TransDecoder.Predict)

#Question: Pourquoi ne pas utiliser l'output de la première étape dans la 3ème? 
#          Que fait la 3ème exactement? (puisque la première étape donne déjà les ORFs)

TransDecoder.LongOrfs -t $data/trinity_data/Trinity.fasta -S --output_dir transdecoder_data

TransDecoder.Predict -t $data/trinity_data/Trinity.fasta -S --output_dir transdecoder_data

