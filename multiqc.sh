#!/bin/bash

#Set working directory 
data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a file to stock output of multiqc
mkdir -p multiqc_data

#Run multiqc on all fastqc files found in the fastqc_data folder
multiqc $data/fastqc_data/*.zip -o multiqc_data

