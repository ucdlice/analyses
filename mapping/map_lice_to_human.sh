#!/bin/bash
#SBATCH -p LM
#SBATCH --mem 1200GB
#SBATCH -N 2
#SBATCH --ntasks-per-node 4
#SBATCH -t 48:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sacaplins@ucdavis.edu
#SBATCH -D /pylon2/bi4ifup/caplins/LOUSE/
#SBATCH -o /pylon2/bi4ifup/caplins/LOUSE/slurm-log/mapteo-stdout-%j.txt
#SBATCH -e /pylon2/bi4ifup/caplins/LOUSE/slurm-log/mapteo-stderr-%j.txt
#SBATCH -J mapteo

set -e
set -u

module load samtools
module load bwa

## path to reads, assuming arranged like from novogene download
READPATH=raw_data


CPU=12

## get the sample we want to run for this array iteration
mapfile -t SAMPLENAMES < lice.samplenames.txt  ## this is a file with each lice identifier on a separate line
SAMPLENAME=${SAMPLENAMES[$SLURM_ARRAY_TASK_ID]}
echo ${SAMPLENAME}

## read names have lots of extra info, so let's specify them by name below
READ1=${READPATH}/${SAMPLENAME}/${SAMPLENAME}_*1.fq.gz
READ2=${READPATH}/${SAMPLENAME}/${SAMPLENAME}_*2.fq.gz

echo $READ1
echo $READ2

## map all and output sorted bam
#module load bwa
bwa mem -t $CPU human_assembly/GRCh38_latest_genomic.fna $READ1 $READ2 | samtools view -Su - | samtools sort -o ${SAMPLENAME}.sorted
