# TP NGS clownfish 2020

## Scientific question 
White tissues in Actinopterygean fishes can be due to iridophores (reflective tissue) or leucophores (white tissue). Fir instance, zebra fish _Danio rerio_'s white stripes are due to iridophores, whereas  

![screenshot](clownfish.jpeg) 
### Dataset used 
We analyzed RNA-seq data from 6 different conditions:
* SRR7591064 - Orange skin - ind 2
* SRR7591065 - White skin - ind 3
* SRR7591066 - Orange skin - ind 1
* SRR7591067 - Orange skin - ind 3
* SRR7591068 - White skin - ind 1
* SRR7591069 - White skin - ind 1

### Reference of the paper
_add the ref_

## Steps of the analysis:

### Downloading the SRA data
Download of the SRA data using fastq-dump in a for loop.The read's name are changed using an awk code, so that they end with "/1" (needed for trinity processing of the reads).   
Code named _download_fastq.sh_

SRR accession codes of the data used: SRR7591064, SRR7591065, SRR7591066, SRR7591067, SRR7591068, and SRR7591069

### Checking the quality of the reads
Check the quality of the reads for each file individually in a for loop using fastqc.
Code named _fastqc.sh_

Check the quality of the reads for all files at once using multiqc. 
Code named _multiqc_

_add an image_

The parameters flagged by fastqc and multiqc are: 
- per-base sequence content where we observe a non-random nucleotide composition of the beginning of the reads, probably due to a defect in the random primers used for the reverse transcriptase. 
- sequence duplicated levels are at a normal level for a RNA-seq, but they are flagged since in a DNA-seq experiment they would indicate a problem.

Except the unsolvable problem of RT primers, the reads have an overall good quality, so there is no need for a step to "clean" the reads.

### _De novo_ assembly of the reads 
We want to assemble all the reads in transcripts. This can be done by mapping the reads to a reference genome, or by a _de novo_ transcriptome assembly. In this case, we have a reference genome available for _A. ocellaris_, but we will reproduce the analysis done in the paper.   

We assembled the reads from all FASTQ files to get a transcriptome using Trinity. 

The Illumina sequencing performed generated single-end (--single) and strand-specific R (--SS_lib_type R) reads, so we have to specify these options to Trinity.
Code named _trinity.sh_

Example of transcript we get after the transcriptome assembly by trinity: *add an image?*

### Quantification of the expression level of the mRNA
Quantifies the level of expression of each Trinity transcript using salmon. Salmon works in two steps, with first salmon index, which indexes the Trinity transcriptome and salmon quant ,  which count how many reads map to each transcript.
Different values of "k" (25, 27 and 29) were used in the group to see which enabled the best alignment: a 25-mer turned to provide the best alignment. All tried values showed alignment between 92.5% and 96%, which is satisfactory. 
Code named _salmon.sh_

### Annotation of the transcripts
We now want to annotate the transcripts, so we can ... 
We will annotate the transcript by blasting them with the closest available reference genome, which in our case is _S.partitus_. We therefore have to get the _S.partitus_ genome from Ensembl, to find the likely coding sequence  of the trinity transcripts using Transdecoder, and to blast the likely coding sequence on the _S.partitus_ reference genome.    

#### Downloading the closest available reference genome 

We downloaded the _S.partitus_ genome (coding sequence) from Ensembl (release 102).
The data were available on ftp.ensembl.org, and we downloaded them using wget.  
Code named _get_ref_genome.sh_

We then renamed the downloaded reference genome to keep the Ensembl identifier (starting with ENS) (gene) and the name of the gene (gene_symbol) when there is one. This was done with an awk code.  
Code named _rename_genome_ref.awk_

#### Identification of coding sequences on the transcripts
We used TransDecoder to identify coding sequences in the trnascripts assembled by trinity. Transdecoder works in three steps, with the second one being optionnal (which was skipped here). TransDecoder.LongOrfs identifies ORF (ie recognizes start and stop codon on the transcript) and TransDecoder.Predict was used to keep the ORF most likely to be the actual coding sequence by transcript . Here we used TransDecoder.Predict to keep the longest ORF, assuming that the longest ORF is the most likely to be the actual coding sequence.

We used the option "-S" because the transcripts are strand-specific (because they reconstituted from strand-specific RNA-seq data) and "--gene_trans_map" (used later on) for TransDecoder.LongOrfs. 

Code named _transdecoder.sh_

#### Blast 
