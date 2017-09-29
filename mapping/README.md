## Mapping to PhumU2 assembly


1. Download files from vectorbase
 
 - genome assembly PhumU2 [Pediculus-humanus-USDA_SCAFFOLDS_PhumU2.fa.gz](https://www.vectorbase.org/download/pediculus-humanus-usdascaffoldsphumu2fagz)
 - gene gff3, PhumU2.2 [Pediculus-humanus-USDA_BASEFEATURES_PhumU2.2.gff3.gz](https://www.vectorbase.org/download/pediculus-humanus-usdabasefeaturesphumu22gff3gz)
 - endosymbiont genome, [ASM9306v1](ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/093/065/GCA_000093065.1_ASM9306v1/GCA_000093065.1_ASM9306v1_genomic.fna.gz)
   - note this is the *Candidatus Riesia pediculicola* sequence described in the original body louse genome paper. There are now others on NCBI.
   
2. Combine fastas of louse scaffolds and endosymbiont, index using script `prepare_refgen.sh`


2. Map with `bwa mem` using script `map_lice.sh`

 - submit with ```--array=0-95``` to map all simultaneously

3. Calculate alignment metrics with `alignment_metrics.sh`, and plot them with `plot_alignment_metrics.R`. This outputs a plot (`alignment_metrics_alllice.pdf`) and tab-delimited file (`alignment_metrics_alllice.txt`) with number of reads sequenced, proportion mapped, and adapter contamination.
