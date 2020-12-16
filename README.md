# TP NGS clownfish 2020

## Scientific question 
White tissues in Actinopterygean fishes can be due to iridophores (reflective tissue) or blabla 

![screenshot](clownfish.jpeg)
### Dataset used 
We analyzed RNA-seq data from 6 different conditions:
SRR7591064 - Orange skin - ind 2
SRR7591065 - White skin - ind 3
SRR7591066 - Orange skin - ind 1
SRR7591067 - Orange skin - ind 3
SRR7591068 - White skin - ind 1
SRR7591069 - White skin - ind 1

### Reference of the paper
_add the ref_

## Steps of the analysis:

### Downloading the SRA data
Download of the SRA data using fastq-dump in a for loop.The read's name are changed using an awk code, so that they end with "/1" (needed for trinity processing of the reads).   
Code available at: _download_fastq.sh_

SRR accession codes of the data used: SRR7591064, SRR7591065, SRR7591066, SRR7591067, SRR7591068, and SRR7591069

### Checking the quality of the reads
Check the quality of the reads for each file individually in a for loop using fastqc.
Code available at: _fastqc.sh_

Check the quality of the reads for all files at once using multiqc. _multiqc_

The parameters flagged by fastqc and multiqc are: 
- per-base sequence content where we observe a non-random nucleotide composition of the beginning of the reads, probably due to a defect in the random primers used for the reverse transcriptase. 
- sequence duplicated levels are at a normal level for a RNA-seq, but they are flagged since in a DNA-seq experiment they would indicate a problem.


Except the unsolvable problem of RT primers, the reads have an overall good quality, so there is no need for a step to "clean" the reads.

### _De novo_ assembly of the reads 
We want to assemble all the reads in transcripts. This can be done by mapping the reads to a reference genome, or by a _de novo_ transcriptome assembly. In this case, we have a reference genome available for _A. ocellaris_, but we will reproduce the analysis done in the paper.   

Assemble the reads from all FASTQ files to get a transcriptome using Trinity. _trinity.sh_

The Illumina sequencing performed generated single-end (--single) and strand-specific R (--SS_lib_type R) reads.

Example of transcript we get after the transcriptome assembly by trinity: *add an image*

### Quantification of the expression level of the mRNA
Quantifies the level of expression of each transcript using salmon. _salmon.sh_
 
