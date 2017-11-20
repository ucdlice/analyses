k2=read.table('all_lice_filtered_snps.ldprune.2.Q')
k3=read.table('all_lice_filtered_snps.ldprune.3.Q')
k4=read.table('all_lice_filtered_snps.ldprune.4.Q')
k5=read.table('all_lice_filtered_snps.ldprune.5.Q')
k6=read.table('all_lice_filtered_snps.ldprune.6.Q')
k7=read.table('all_lice_filtered_snps.ldprune.7.Q')
k8=read.table('all_lice_filtered_snps.ldprune.8.Q')
k9=read.table('all_lice_filtered_snps.ldprune.9.Q')
k10=read.table('all_lice_filtered_snps.ldprune.10.Q')
k11=read.table('all_lice_filtered_snps.ldprune.11.Q')
k12=read.table('all_lice_filtered_snps.ldprune.12.Q')
k13=read.table('all_lice_filtered_snps.ldprune.13.Q')
k14=read.table('all_lice_filtered_snps.ldprune.14.Q')
k15=read.table('all_lice_filtered_snps.ldprune.15.Q')

ad=read.table('../lice_info.txt', header=T, sep='\t', stringsAsFactor=F)
ids=read.table('all_lice_filtered_snps.ldprune.fam')
ids$EID=ids$V1

ad$id=ad$V1  ## match it all up to my existing code
ad=ad[ad$id %in% ids$EID,]
ad=ad[order(as.character(ad$Location),ad$Date),]

names=sort(as.character(ad$Location))
names[duplicated(names)]=''
names[ad$Ecto[order(as.character(ad$Location))]=='Head']=paste0(names[ad$Ecto[order(as.character(ad$Location))]=='Head'], '*')


k2o=k2[match(ad$id, ids$EID),]
k3o=k3[match(ad$id, ids$EID),]
k4o=k4[match(ad$id, ids$EID),]
k5o=k5[match(ad$id, ids$EID),]
k6o=k6[match(ad$id, ids$EID),]
k7o=k7[match(ad$id, ids$EID),]
k8o=k8[match(ad$id, ids$EID),]
k9o=k9[match(ad$id, ids$EID),]
k10o=k10[match(ad$id, ids$EID),]
k11o=k11[match(ad$id, ids$EID),]
k12o=k12[match(ad$id, ids$EID),]
k13o=k13[match(ad$id, ids$EID),]
k14o=k14[match(ad$id, ids$EID),]
k15o=k15[match(ad$id, ids$EID),]

pdf('admixture_alllice.pdf')
## k=2
barplot(t(as.matrix(k2o)), col=rainbow(2), ylab='ancestry', border=NA, main='2', names.arg=names, cex.names=0.4, las=2)
## k=3
barplot(t(as.matrix(k3o)), col=rainbow(3),  ylab='ancestry', border=NA, main='3', names.arg=names, cex.names=0.4, las=2)
## k=4
barplot(t(as.matrix(k4o)), col=rainbow(4), ylab='ancestry', border=NA, main='4', names.arg=names, cex.names=0.4, las=2)
## k=5
barplot(t(as.matrix(k5o)), col=rainbow(5), ylab='ancestry', border=NA, main='5', names.arg=names, cex.names=0.4, las=2)
## k=6
barplot(t(as.matrix(k6o)), col=rainbow(6), ylab='ancestry', border=NA, main='6', names.arg=names, cex.names=0.4, las=2)
## k=7
barplot(t(as.matrix(k7o)), col=rainbow(7), ylab='ancestry', border=NA, main='7', names.arg=names, cex.names=0.4, las=2)
## k=8
barplot(t(as.matrix(k8o)), col=rainbow(8),  ylab='ancestry', border=NA, main='8', names.arg=names, cex.names=0.4, las=2)
## k=9
barplot(t(as.matrix(k9o)), col=rainbow(9), ylab='ancestry', border=NA, main='9', names.arg=names, cex.names=0.4, las=2)
## k=10
barplot(t(as.matrix(k10o)), col=rainbow(10),  ylab='ancestry', border=NA, main='10', names.arg=names, cex.names=0.4, las=2)
## k=11
barplot(t(as.matrix(k11o)), col=rainbow(11),  ylab='ancestry', border=NA, main='11', names.arg=names, cex.names=0.4, las=2)
## k=12
barplot(t(as.matrix(k12o)), col=rainbow(12),  ylab='ancestry', border=NA, main='12', names.arg=names, cex.names=0.4, las=2)
## k=13
barplot(t(as.matrix(k13o)), col=rainbow(13),  ylab='ancestry', border=NA, main='13', names.arg=names, cex.names=0.4, las=2)
## k=14
barplot(t(as.matrix(k14o)), col=rainbow(14), ylab='ancestry', border=NA, main='14', names.arg=names, cex.names=0.4, las=2)
## k=15
barplot(t(as.matrix(k15o)), col=rainbow(15), ylab='ancestry', border=NA, main='15', names.arg=names, cex.names=0.4, las=2)

dev.off()
