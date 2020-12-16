#!/bin/bash
  
#Create a list containing the path of each fastq file 

data="/home/rstudio/data/mydatalocal/data"
FASTQ=$(ls $data/sra_data/*.fastq |paste -s -d, -)

#echo "$FASTQ" to check if $FASTQ is composed of a list of fastq files path as expected


#Create a folder to stock the output of Trinity
cd $data
mkdir -p trinity_data


#Run Trinity 
Trinity --seqType fq --single $FASTQ --SS_lib_type R --max_memory 50G \
--CPU 16 --output trinity_data --normalize_by_read_set


# Remove length and path in sequence names to avoid bug with blast ( sequence name length > 1000)
# sed -re "s/(>[_a-zA-Z0-9]*)( len=[0-9]*)( path=.*)/\1/"

