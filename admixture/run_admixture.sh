#!/bin/bash -login


## first, get rid of high missing individual TEs
#plink --file ../partition_h2/TE_pedfile --geno 0.1 --make-bed --out TE_cleaned


plink --vcf ../pca/all_lice.raw.nodel.vcf.gz --geno 0.1 --make-bed --allow-extra-chr --out all_lice_cleaned

plinkbed=all_lice_cleaned.bed

for K in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15;\
#for K in 11 12 13 14 15;\
do /group/jrigrp8/arabidopsis/admixture/admixture_linux-1.3.0/admixture --cv ${plinkbed} $K | tee log${K}.alllice.out; done

