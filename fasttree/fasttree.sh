#!/bin/bash
#SBATCH -N 1
#SBATCH -p LM
#SBATCH -t 96:00:00
#SBATCH --mem=1344GB
#SBATCH --mail-user=sacaplins@ucdavis.edu
#SBATCH --mail-type=ALL

echo commands to stdout
set -x

cd /pylon5/bi4ifup/caplins/SNPEFF/fasttree_tre


./FastTree -gtr -nt ../../clean_noast_noindels_all_lice.fasta > tree_out

