
### Remove low-genotyped inidividuals (0.5 by individual)

`~/software/plink/plink_v1.90b4.6 --vcf ../call_snps/all_lice_filtered_snps.vcf --recode --make-bed --geno 0.1 --mind 0.5 --allow-extra-chr --out all_lice_filtered_snps.mafmindfilt`

39 people removed due to missing genotype data (--mind).

2650752 variants removed due to missing genotype data (--geno).
2617187 variants and 56 people pass filters and QC.


