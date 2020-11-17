#!/bin/bash

# Create a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data
cd $data

# Create a directory where the data will be downloaded
mkdir -p sra_data
cd sra_data

# Make a list of SRR accessions:
SRR="SRR7591064
SRR7591065
SRR7591066
SRR7591067
SRR7591068
SRR7591069
"

# For each SRR accession, download the data :
for r in $SRR
do

  fastq-dump $r

# Rename sequence names, trinity need that their name ends with "/1" for R1 and "/2" for R2.

awk  '{ if (NR%2 == 1 ) {gsub("\\.","_");print $1"/1"}  else  { print $0}}' $r.fastq > $r.fastq.modif 

#Rename the modified fastq to fastq

mv $r.fastq.modif $r.fastq

done