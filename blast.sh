#! /bin/bash

data="/home/rstudio/data/mydatalocal/data"
cd $data

mkdir -p blast_data
cd blast_data

mkdir -p blast_db

db=$data/blast_data/blast_db/Spartitus_db

#build reference database from the renamed reference genome (S.partitus) 
makeblastdb -in $data/ref_genome/s.partitus_renom.fa -out $db -dbtype nucl

#blast fasta against the ref database (db). query=input?
blastn -db $db -query $data/transdecoder_data/Trinity.fasta.transdecoder.renamed.cds -evalue 1e-10 -outfmt 6 -out $data/blast_data/blast

