## combine louse scaffolds and riesia genome and its plasmid
zcat Pediculus-humanus-USDA_SCAFFOLDS_PhumU2.fa.gz GCF_000093065.1_ASM9306v1_genomic.fna.gz > PhumU2.Riesia.fa

## make sure we each do the same thing!!
wc PhumU2.Riesia.fa

## output is:
#   1395145   1398959 112900069 PhumU2.Riesia.fa

## index genome for bwa 
bwa index PhumU2.Riesia.fa

## index genome for gatk
samtools faidx PhumU2.Riesia.fa
module load java
java -jar /share/apps/picard-tools-2.7.1/picard.jar CreateSequenceDictionary R=PhumU2.Riesia.fa O=PhumU2.Riesia.dict 
