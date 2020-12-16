#! /bin/bash

data="/home/rstudio/data/mydatalocal/data"
cd $data

mkdir -p blast_data
cd blast_data

mkdir -p blast_db

db=$data/blast_data/blast_db/Spartitus_db.??

#build reference database from the renamed reference genome (S.partitus) (seqtype=1)
makeblastdb -seqtype 1 -in $data/ref_genome/s.partitus_renom.fa -title $db

#blast fasta against the ref database (db). query=input?
blastn -db $db -query $data/transdecoder_data/?? -evalue $evalue -outfmt 6 -out $data/blast_data


Rscript --vanilla  annote_fasta_from_blast.R $out_blast 
