#! /bin/bash
 
data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to store the output 
mkdir -p ref_genome

wget -O $data/ref_genome/s.partitus_ref.fa.gz http://ftp.ensembl.org/pub/release-102/fasta/stegastes_partitus/cds/Stegastes_partitus.Stegastes_partitus-1.0.2.cds.all.fa.gz

#Utiliser rename_genome_ref.awk avec : awk -f rename_genome_ref.awk /home/rstudio/data/mydatalocal/data/ref_genome/s.partitus_ref.fa > /home/rstudio/data/mydatalocal/data/ref_genome/s.partitus_renom.fa