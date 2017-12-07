#!/bin/bash
#SBATCH --job-name="index_HG19"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/index_HG19-%N-%j.out
#SBATCH -e err/index_HG19-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
HG19="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/ucsc.hg19.fasta"

module load bwa

bwa index -a bwtsw $HG19

module unload bwa

