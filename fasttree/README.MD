## convert vcf to fasta and make a tree

module load bcftools
module load samtools
module load vcftools


##get rid of indel in * for ALT genotype and for REF (there were 18k of these in the original vcf file)

bcftools view -m2 -M2 -v snps all_lice_filtered_snps.geno0.1mind0.5.vcf.gz > clean_noast.all_lice.vcf

##get rid of indels (*) in the REF allele, which are not removed with bcftools

grep -v "*" clean_noast.all_lice.tab > clean_noast_noindels_all_lice.tab

##make a fasta file from a vcf-tab file
perl vcf_tofasta_modified.sh -i clean_noast_noindels_all_lice.tab > clean_noast_noindels_all_lice.fasta

##install fasttree
gcc -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm

##run fasttree.sh see command below
##FastTree -gtr -nt clean_noast_noindels_all_lice.fasta > tree_out
