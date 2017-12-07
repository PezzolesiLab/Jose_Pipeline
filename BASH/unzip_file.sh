#!/bin/bash
#SBATCH --job-name="unzip_file"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ"
zipped=$1
name=$2
folder=$3
bzip2 -dc $zipped > $location/$folder/$name
