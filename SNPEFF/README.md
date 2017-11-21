
install snpEff `wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip` 

download louse genome `java -jar ~/snpEff/snpEff.jar download Pediculus_humanus`

run snpEff annotate via `java -jar ~/snpEff/snpEff.jar ann sequences/all_lice_filtered_snps.geno0.1mind0.5.vcf Pediculus_humanus`

run snpFilt to extract fields `java -jar ~/snpEff/SnpSift.jar extractFields test.pediculus.ann.vcf CHROM POS REF ALT "ANN[*].EFFECT" > test.pediculus.ann.extract.fields`



