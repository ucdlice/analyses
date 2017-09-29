module load java
module load samtools

mkdir -p alignment_metrics

for i in `seq 1 96`;
do
java -jar /share/apps/picard-tools-2.7.1/picard.jar CollectAlignmentSummaryMetrics R=PhumU2.Riesia.fa I=lice${i}.sorted.bam O=alignment_metrics/lice${i}_alignment_metrics.txt
java -jar /share/apps/picard-tools-2.7.1/picard.jar CollectInsertSizeMetrics INPUT=lice${i}.sorted.bam OUTPUT=alignment_metrics/lice${i}_insert_metrics.txt HISTOGRAM_FILE=alignment_metrics/lice${i}_insert_size_histogram.pdf
samtools depth -a lice${i}.sorted.bam > alignment_metrics/lice${i}_depth_out.txt
done

