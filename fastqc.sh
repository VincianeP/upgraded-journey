#!/bin/bash

# Again go create / go in the working directory

data="/home/rstudio/data/mydatalocal/data"
cd $data


# Create a folder for the fastqc

mkdir -p fastqc_data
cd sra_data

# For each fastq in sra_data, apply fastqc and direct output to fastqc_data 

SRR="SRR7591064
SRR7591065
SRR7591066
SRR7591067
SRR7591068
SRR7591069"

for r in $SRR

do 
  fastqc $r.fastq -o $data/fastqc_data -t 16 #$r.fastq = name of the file, $data/fastqc_data = path of the output folder

done



#ou boucle for sur le chemin du fichier directement (méthode de Paul): 

#cd $data

#Create a list containing the path of the fastq files in the sra_data folder
#list_file=$data/sra_data/*.fastq

#for file in $list_file
#do 
#  fastqc -o fastqc_data -t 16 $file
#done

#to execute, type "nohup ./fastqc.sh >& nohup.fastqc &"
#follow how it's going with "tail -f nohup.fastqc"