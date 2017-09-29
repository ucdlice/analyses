## combine louse scaffolds and riesia genome and its plasmid
zcat Pediculus-humanus-USDA_SCAFFOLDS_PhumU2.fa.gz GCF_000093065.1_ASM9306v1_genomic.fna.gz > louse_riesia.fa

## make sure we each do the same thing!!
wc louse_riesia.fa

## output is:
#   1395145   1398959 112900069 louse_riesia.fa
