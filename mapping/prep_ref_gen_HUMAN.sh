#download human genome

wget ftp://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_genomic.fna.gz

#unzip it
gunzip GRCh38_latest_genomic.fna.gz

#look at it
wc GRCh38_latest_genomic.fna

#output
40525253   40531387 3282540172 GRCh38_latest_genomic.fna

#prepare for mapping
bwa index GRCh38_latest_genomic.fna
