#!/bin/bash -login
#SBATCH -D /group/jrigrp8/mstitzer/lice/mapping
#SBATCH -o /group/jrigrp8/mstitzer/lice/slurm-log/mapteo-stdout-%j.txt
#SBATCH -e /group/jrigrp8/mstitzer/lice/slurm-log/mapteo-stderr-%j.txt
#SBATCH -J mapteo
set -e
set -u

## path to reads, assuming arranged like from novogene download
PATH=raw_reads/hwftp.novogene.com/data_release/C202SC17090235/raw_data


CPU=12

## get the sample we want to run for this array iteration
mapfile -t SAMPLENAMES < lice.samplenames.txt  ## this is a file with each lice identifier on a separate line
SAMPLENAME=${SAMPLENAMES[$SLURM_ARRAY_TASK_ID]}
echo ${SAMPLENAME}

## read names have lots of extra info, so let's specify them by name below
READ1=${PATH}/${SAMPLENAME}/${SAMPLENAME}_*1.fq.gz 
READ2=${PATH}/${SAMPLENAME}/${SAMPLENAME}_*2.fq.gz

## map all and output sorted bam
module load bwa
bwa mem -t $CPU PhumU2.Riesia.fa  $READ1 $READ2 | samtools view -Su  - | samtools sort - ${SAMPLENAME}.sorted

