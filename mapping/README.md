## Mapping to PhumU2 assembly


1. Download files from vectorbase
 
 - genome assembly PhumU2 [Pediculus-humanus-USDA_CONTIGS_PhumU2.fa.gz](https://www.vectorbase.org/download/pediculus-humanus-usdacontigsphumu2fagz)
 - gene gff3, PhumU2.2 [Pediculus-humanus-USDA_BASEFEATURES_PhumU2.2.gff3.gz](https://www.vectorbase.org/download/pediculus-humanus-usdabasefeaturesphumu22gff3gz)


2. Map with `bwa mem` using script `map_lice.sh`

 - submit with ```--array=0-95``` to map all simultaneously
