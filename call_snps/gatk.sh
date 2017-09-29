
## mark duplicates

java -jar picard.jar MarkDuplicates INPUT=sorted_reads.bam OUTPUT=dedup_reads.bam METRICS_FILE=metrics.txt


## recalibrate base quality
 
java -jar GenomeAnalysisTK.jar \
   -T PrintReads \
   -R reference.fasta \
   -I input.bam \
   -BQSR recalibration_report.grp \
   -o output.bam


## gvcf info here https://software.broadinstitute.org/gatk/documentation/article?id=3893


## call variants in each sample, outputting gvcf

java -jar GenomeAnalysisTK.jar \ 
    -T HaplotypeCaller \ 
    -R reference.fa \ 
    -I preprocessed_reads.bam \  
    --genotyping_mode DISCOVERY \ 
    -stand_emit_conf 10 \ 
    -stand_call_conf 30 \ 
    -o raw_variants..g.vcf
   
--emitRefConfidence GVCF

## genotype together 
GenotypeGVCFs

## 4. Variant recalibration
Finally, resume the classic GATK Best Practices workflow by running VQSR on these "regular" VCFs according to our usual recommendations.


## don't need to merge

### joint genotype

 java -jar GenomeAnalysisTK.jar \
   -T GenotypeGVCFs \
   -R reference.fasta \
   --variant sample1.g.vcf \
   --variant sample2.g.vcf \
   -o output.vcf
   
   
## lots of recalibration options
