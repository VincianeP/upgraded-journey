#!/bin/bash

#Set working directory
data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to store the output of the quantification
mkdir -p quantification_data


#Create a list of path of FASTQ files to use
FASTQ=$(ls $data/sra_data/*.fastq)
#echo "$FASTQ"


# Index the transcriptome, needed only once (independent of the reads)
salmon index -t trinity_data/Trinity.fasta -i $data/salmon_index -k 29


# Quantification, for each FASTQ file.
for fastq_file in $FASTQ
do
  
  #Get the name of the FASTQ file and remove the .fastq
  fastq_name=$(basename -s .fastq $fastq_file)

  salmon quant -l SR -r $fastq_file -i $data/salmon_index -o $data/quantification_data/$fastq_name \
  -p 16 --gcBias --validateMappings

done