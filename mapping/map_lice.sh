#!/bin/bash -login
#SBATCH -D /group/jrigrp8/mstitzer/lice/mapping
#SBATCH -o /group/jrigrp8/mstitzer/lice/slurm-log/mapteo-stdout-%j.txt
#SBATCH -e /group/jrigrp8/mstitzer/lice/slurm-log/mapteo-stderr-%j.txt
#SBATCH -J mapteo
set -e
set -u


CPU=12

## get the sample we want to run for this array iteration
mapfile -t SAMPLENAMES < lice.samplenames.txt  ## this is a file with each lice identifier on a separate line
SAMPLENAME=${SAMPLENAMES[$SLURM_ARRAY_TASK_ID]}
echo ${SAMPLENAME}

READ1=${SAMPLENAME}_1.fastq
READ2=${SAMPLENAME}_2.fastq

## map all and output sorted bam
module load bwa
bwa mem -t $CPU PhumU2.Riesia.fa $READ1 $READ2 | samtools view -Su  - | samtools sort - ${SAMPLENAME}.sorted

