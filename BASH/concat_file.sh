#!/bin/bash
#SBATCH --job-name="concat_file"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/MERGED"
file1=$1
file2=$2
file3=$3
file4=$4
name=$5
cat $file1 $file2 $file3 $file4 > $location/$name
