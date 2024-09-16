## Bioinformatics analysis used to determine reinfection and relapse tuberculosis using whole genome sequencing data.
### Citation: Utilizing whole genome sequencing to delineate relapse and reinfection tuberculosis on the Canadian prairies (https://doi.org/10.1080/24745332.2024.2366310)

#### Step 1: Quality check of raw FASTQ files

    perl WGS_SIBP_P1.pl Prepare_Input.txt RAW_READS QualityCheck RESULTS

#### Step 2: Remove adapter sequences from FASTQ files

    perl AdapterRem.pl Prepare_Adapter-Input.txt RAW_READS adapters.fa AdapterRemoval AdapterRemoval-QC

    RAW_READS = Directory with raw FASTQ files
    adapters.fa = Adapter sequences in fasta format
    AdapterRemoval = Directory to save FASTQ files after adapter cleaning
    AdapterRemoval-QC = Quality check results of FASTQ files after adapter cleaning

#### Step 3: Read mapping to the <i> Mycobacterium tuberculosis </i> reference genome

    perl ReadMapping.pl Prepare_Input.txt GCF_000277735.2_ASM27773v2_genomic.fna RAW_READS TB_Results

    RAW_READS = Directory with raw/cleaned FASTQ files
    TB_Results = Directory to store alignment results

#### Step 4: <i> De novo </i> genome assembly

    perl WGS_SIBP_P2.pl Prepare_Input.txt RAW_READS raw 35 Assembly

    RAW_READS = Directory with raw/cleaned FASTQ files
    Assembly = Directory to store assembled genomes

#### Step 5: Check the quality of the assembled genomes

    quast.py AssembledContigs/* -r GCF_000195955.2_ASM19595v2_genomic.fna -g GCF_000195955.2_ASM19595v2_genomic.gff

    AssembledContigs = Directory containing all assembled genomes in fasta format

#### Step 6: Coverage calculation
##### Program version: fastqinfo-2.0
##### Insert size calculation Example:
       head -n 2 C09MB033185_i7-43_R1.fastq |tail -n 2|wc -c
##### Coverage calculation Example:
    fastq-info/bin/fastqinfo-2.0.sh -r 215 C09MB033185_i7-43_R1.fastq C09MB033185_i7-43_R2.fastq Genome.fasta
    fastq-info/bin/fastqinfo-2.0.sh -r 215 C09MB033185_i7-43_R1.fastq C09MB033185_i7-43_R2.fastq ALL-Contigs/C09MB033185.fasta

#### Step 7: Spolingotyping

     python Spolingotyping.py

#### Step 8: Lineages and AMR prediction

     perl mykrobe_AMR.pl Prepare_Input.txt RAW_READS Lineage_AMR

#### Step 9: Single nucleotide polymorphisms (SNPs) and phylogenetic analysis

      MTBseq --step TBfull --threads 30
      raxmlHPC -s TB_joint_cf4_cr4_fr75_ph4_samples50_amended_u95_phylo_w12.plainIDs.phy -m GTRGAMMA -p 12345 -# 200 -T 35 -n RecurrentTb 
