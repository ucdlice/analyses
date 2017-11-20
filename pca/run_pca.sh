#!/bin/bash -login
#SBATCH -D /group/jrigrp8/mstitzer/lice/pca
#SBATCH -o /group/jrigrp8/mstitzer/lice/slurm-log/genotype-stdout-%j.txt
#SBATCH -e /group/jrigrp8/mstitzer/lice/slurm-log/genotype-stderr-%j.txt
#SBATCH -J pca
set -e
set -u

module load vcftools
module load plink

#if [ ! -f all_lice.raw.plink.map ]
#then
#vcftools --vcf ../call_snps/all_lice.raw.vcf --plink --out all_lice.raw.plink
#fi

#grep -v "*" ../call_snps/all_lice.raw.vcf > all_lice.raw.nodel.vcf
#vcftools --vcf all_lice.raw.nodel.vcf --min-alleles 2 --max-alleles 2 --plink --out all_lice.raw.nodel.plink


#plink --file all_lice.raw.nodel.plink --make-bed --out all_lice.raw.nodel.plink
~/software/plink/plink_v1.90b4.6 --file all_lice_filtered_snps.mafmindfilt --indep 50 5 2 --allow-extra-chr --out all_lice_filtered_snps.ldprune
~/software/plink/plink_v1.90b4.6 --file all_lice_filtered_snps.mafmindfilt --extract all_lice_filtered_snps.ldprune.prune.in --allow-extra-chr --make-bed --out all_lice_filtered_snps.ldprune
~/software/plink/plink_v1.90b4.6 --bfile all_lice_filtered_snps.ldprune --biallelic-only strict --allow-extra-chr --pca --out all_lice_filtered_snps.pca


