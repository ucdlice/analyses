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


### joint genotype

java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \
   -T GenotypeGVCFs \
   -R ../mapping/PhumU2.Riesia.fa \
   --variant lice1.g.vcf \
   --variant lice5.g.vcf \
   -o all_lice.raw.vcf

## can supply as list instead
#  -V mygvcfs.list

## 4. Variant recalibration
#Finally, resume the classic GATK Best Practices workflow by running VQSR on these "regular" VCFs according to our usual recommendations.
# can't do vqsr because we don't have trusted variants
## hard filtering instead.


java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \ 
    -T SelectVariants \ 
    -R ../mapping/PhumU2.Riesia.fa \
    -V all_lice.raw.vcf \ 
    -selectType SNP \ 
    -o all_lice_raw_snps.vcf 
    
    
    
java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \ 
    -T VariantFiltration \ 
    -R ../mapping/PhumU2.Riesia.fa \
    -V all_lice_raw_snps.vcf  \ 
    --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \ 
    --filterName "snp_filter" \ 
    -o all_lice_filtered_snps.vcf 
    
    
    
java -jar /share/apps/GATK-3.6/GenomeAnalysisTK.jar \ 
    -T SelectVariants \ 
    -R ../mapping/PhumU2.Riesia.fa \
    -V all_lice.raw.vcf \ 
    -selectType INDEL \ 
    -o all_lice_raw_indels.vcf 
    
    
    
java -jar GenomeAnalysisTK.jar \ 
    -T VariantFiltration \ 
    -R reference.fa \ 
    -V raw_indels.vcf \ 
    --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0 || SOR > 10.0 || InbreedingCoeff < -0.8" \ 
    --filterName "indel_filter" \ 
    -o all_lice_filtered_indels.vcf 

