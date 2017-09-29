library(cowplot)

l=read.table('lice.samplenames.txt')

## feel free to add more columns! 

for (i in 1:96){
 a=read.table(paste0('alignment_metrics/lice', i, '_alignment_metrics.txt'), header=T, sep='\t')
 l$TOTAL_READS[l$V1==paste0('lice', i)]=a$TOTAL_READS[3]
 l$PCT_PF_READS_ALIGNED[l$V1==paste0('lice', i)]=a$PCT_PF_READS_ALIGNED[3]
 l$PCT_ADAPTER[l$V1==paste0('lice', i)]=a$PCT_ADAPTER[3]
}


pdf('alignment_metrics_alllice.pdf')
ggplot(l, aes(x=V1, y=TOTAL_READS)) + geom_point()
ggplot(l, aes(x=V1, y=PCT_PF_READS_ALIGNED)) + geom_point()
ggplot(l, aes(x=V1, y=PCT_ADAPTER)) + geom_point()
dev.off()
