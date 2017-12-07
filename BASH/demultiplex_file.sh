#!/bin/bash
#SBATCH --job-name="demultiplex_file"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/demultiplex_file-%N-%j.out
#SBATCH -e err/demultiplex_file-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
barcode=$1
location=$2
name=$3
location2=$4
name2=$5

IFS='.' read -r -a just_name <<< "$3"
IFS='.' read -r -a just_name2 <<< "$5"


new_name="$location2/${just_name[0]}.%.fastq"
new_name2="$location2/${just_name2[0]}.%.fastq"
fastq-multx -b -x -B $barcode $location/$name $location/$name2 -o $new_name -o $new_name2 
