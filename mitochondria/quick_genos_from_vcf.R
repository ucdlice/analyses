library(pegas)
library(data.table)
library(plyr)

## make a vcf with your region of interest
## here's one way
### if you need position filter
## `vcftools --vcf ../call_snps/all_lice_filtered_snps.vcf --chr DS235854 --from-bp 1288063 --to-bp 1288814 --recode --out PHUM540560`
### or everything on a minichromsome!
## `vcftools --vcf ../call_snps/all_lice_filtered_snps.vcf --chr NC_013962.1 --recode --out NC_013962.1`
a=read.vcf('/group/jrigrp8/mstitzer/lice/single_gene/PHUM540560.recode.vcf')
## get general lice info
li=fread('/group/jrigrp8/mstitzer/lice/lice_info.txt', header=T)


## for each locus, make a matrix
#### not super easy to go back to which actual genomic position these are without opening up vcf
l1=as.matrix(a[8])
l2=as.matrix(a[9])

l=data.frame(IID=rownames(l1), locus1=l1[,1], locus2=l2[,1])
l$Ecto=mapvalues(l$IID, from=li$names.for.novogene, to=li$Ecto)

table(l$locus1, l$Ecto)
table(l$locus2, l$Ecto)

l$Location=mapvalues(l$IID, from=li$names.for.novogene, to=li$Location)
l$pool=mapvalues(l$IID, from=li$names.for.novogene, to=li$pool)


table(l$locus1, l$location)
table(l$locus1, l$Location)
table(l$locus2, l$Location)
table(l$locus1, l$Location, l$Ecto)
table(l$locus2, l$Location, l$Ecto)
