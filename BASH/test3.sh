#!/bin/bash
#SBATCH --job-name="test1"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember

LOCATION="/uufs/chpc.utah.edu/common/home/u1123911/GATK/GATK4"
HG19="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/ucsc.hg19.fasta"
module load bwa
gatk-launch FastqToSam -F1 $LOCATION/FASTQ/SP1.fq -O $LOCATION/SAM/Test1.sam -SM "TEST"
gatk-launch SamToFastq -F1 $LOCATION/SAM/Test1.fastq - I $LOCATION/SAM/Test1.sam

module unload bwa
