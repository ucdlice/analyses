setwd('/Users/pbrand/science/research/ped/analyses/pca/')
library(SNPRelate)
bed<-"lice_only_2.bed"
fam<-"lice_only_2.fam"
bim<-"lice_only_2.bim"

snpgdsBED2GDS(bed,fam,bim,"lice_only_2.gds")
snpgdsSummary("lice_only_2.gds")

genofile<-snpgdsOpen("NC_pre_2.gds",allow.duplicate = T)



genofile

sample.id<-read.gdsn(index.gdsn(genofile, "sample.id"))



#use this to subsample data before PCA
qc<-read.table("qc_ind.txt")
popraw<-read.table("analyses/pca/popid.txt")

sel<-popraw[popraw[,1] %in% qc[,1],1]

sel<-as.vector(popraw[popraw[,3]=="SF",1])
sel<-popraw[,1]

#pca
pca<-snpgdsPCA(genofile,autosome.only = F,sample.id = sel)
pc.percent<-pca$varprop*100
head(round(pc.percent,2))

tab <- data.frame(sample.id = pca$sample.id,
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  EV3 = pca$eigenvect[,3],
                  EV4 = pca$eigenvect[,4],
                  stringsAsFactors = FALSE)
head(tab)

#plot without a-priori sample information
plot(pca$eigenvect[,c(2,1)], xlab="eigenvector 2", ylab="eigenvector 1")


#plot with info
sample.id<-read.gdsn(index.gdsn(genofile, "sample.id"))
popraw<-read.table("analyses/pca/popid.txt")
popraw
pop_code<-popraw[,2]
cbind(sample.id,pop_code)

tab <- data.frame(sample.id = pca$sample.id,
                  pop = factor(pop_code)[match(pca$sample.id, sample.id)],
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  EV3 = pca$eigenvect[,3],
                  EV4 = pca$eigenvect[,4],
                  stringsAsFactors = FALSE)
head(tab)

plot(tab$EV3, tab$EV2, col=as.integer(tab$pop), xlab="eigenvector 2", ylab="eigenvector 1")
legend("bottomright", legend=levels(tab$pop), pch="o", col=1:nlevels(tab$pop))

text(tab$EV3,tab$EV2,sample.id,adj = 1,cex=0.5)


lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")
pairs(pca$eigenvect[,1:4], col=tab$pop, labels=lbls)
