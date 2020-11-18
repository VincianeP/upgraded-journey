# TP NGS clownfish 2020

## Downloading the SRA data
Download of the SRA data using fastq-dump, and changing of the read's name so that they end with "/1" (needed for trinity processing of the reads).   _download_fastq.sh_ \n
SRR accession codes of the data used: SRR7591064, SRR7591065, SRR7591066, SRR7591067, SRR7591068, and SRR7591069

## Checking the quality of the reads
Check the quality of the reads for each file individually using fastqc. _fastqc.sh_ \n
Check the quality of the reads for all files at once using multiqc. _multiqc_ \n

The parameters flagged by fastqc and multiqc are 
- per-base sequence content where we observe a non-random nucleotide composition of the beginning of the reads, probably due to a defect in the random primers used for the reverse transcriptase. 
- sequence duplicated levels are at a normal level for a RNA-seq, but they are flagged since in a DNA-seq experiment they would indicate a problem. \n

Except the unsolvable problem of RT primers, the reads have an overall good quality, so there is no need for a step to "clean" the reads.

## _De novo_ assembly of the reads 
Assemble the reads from all FASTQ files to get a transcriptome using Trinity. _trinity.sh_ \n

The RNA-seq experiment performed generated single-end and strand-specific (R) reads.  
