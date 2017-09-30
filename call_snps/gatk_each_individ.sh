#!/bin/bash -login
#SBATCH -D /group/jrigrp8/mstitzer/lice/call_snps
#SBATCH -o /group/jrigrp8/mstitzer/lice/slurm-log/genotype-stdout-%j.txt
#SBATCH -e /group/jrigrp8/mstitzer/lice/slurm-log/genotype-stderr-%j.txt
#SBATCH -J genotype
set -e
set -u

module load R/3.3.1
module load maven
module load java
module load GATK
module load samtools


mkdir -p deduped_reads
mkdir -p base_recalibration

i=$SLURM_ARRAY_TASK_ID

## mark duplicates
if [ ! -f deduped_reads/lice${i}.dedup.bam ];
then
java -jar /share/apps/picard-tools-2.7.1/picard.jar MarkDuplicates INPUT=../mapping/lice${i}.sorted.bam OUTPUT=deduped_reads/temp.lice${i}.dedup.bam METRICS_FILE=deduped_reads/lice${i}.dedup.metrics.txt

## add read group
java -jar /share/apps/picard-tools-2.7.1/picard.jar AddOrReplaceReadGroups \
      I=deduped_reads/temp.lice${i}.dedup.bam  \
      O=deduped_reads/lice${i}.dedup.bam  \
      RGID=4 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=20

rm deduped_reads/temp.lice${i}.dedup.bam 

samtools index deduped_reads/lice${i}.dedup.bam

fi

## recalibrate base quality
#if [ ! -f base_recalibration/lice${i}.bqsr.bam ];
#then
#java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \
#   -T PrintReads \
#   -R ../mapping/PhumU2.Riesia.fa \
#   -I deduped_reads/lice${i}.dedup.bam \
#   -BQSR base_recalibration/lice${i}.recalibration_report.grp \
#   -o base_recalibration/lice${i}.bqsr.bam
#fi


## call variants in this individual, outputting gvcf
if [ ! -f lice${i}.gvcf ];
then
java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \
   -T HaplotypeCaller \
   -R ../mapping/PhumU2.Riesia.fa \
   -I deduped_reads/lice${i}.dedup.bam \
   -o lice${i}.gvcf \
   -ERC GVCF \
   -variant_index_type LINEAR \
   -variant_index_parameter 128000
fi



## gvcf info here https://software.broadinstitute.org/gatk/documentation/article?id=3893
## and here https://qcb.ucla.edu/wp-content/uploads/sites/14/2016/03/GATK_Discovery_Tutorial-Worksheet-AUS2016.pdf

## genotype together 
#GenotypeGVCFs

# java‐jarGenomeAnalysisTK.jar\
#‐TGenotypeGVCFs\
#‐Rref/human_g1k_b37_20.fasta\
#‐Vsandbox/NA12878_wgs_20.g.vcf\
#‐Vgvcfs/NA12877_wgs_20.g.vcf\
#‐Vgvcfs/NA12882_wgs_20.g.vcf\
#‐osandbox/CEUTrio_wgs_20_GGVCFs_jointcalls.vcf\
#‐L20:10000000‐10200000

## 4. Variant recalibration
#Finally, resume the classic GATK Best Practices workflow by running VQSR on these "regular" VCFs according to our usual recommendations.


## don't need to merge

### joint genotype

# java -jar GenomeAnalysisTK.jar \
#   -T GenotypeGVCFs \
#   -R reference.fasta \
#   --variant sample1.g.vcf \
#   --variant sample2.g.vcf \
#   -o output.vcf
#   
   
## lots of recalibration options
