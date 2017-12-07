#!/bin/bash
#SBATCH --job-name="UBAM-FASTQ_file"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/UBAM-FASTQ_file-%N-%j.out
#SBATCH -e err/UBAM-FASTQ_file-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
Location1=$1
Location2=$2
name1=$3
name2=$4

IFS='.' read -r -a splited_name <<< "$3"
IFS='.' read -r -a splited_name2 <<< "$4"

echo -F1 $Location1/$name1 -F2 $Location1/$name2 -O $Location2/${splited_name[0]}_R2.${splited_name[1]}.sam -O $Location2/${splited_name2[0]}.${splited_name2[1]}.sam
echo gatk-launch FastqToSam -F1 $Location1/$name1 -O $Location2/${splited_name[0]}.${splited_name[1]}.sam -SM "${splited_name[1]}" -SO coordinate
echo gatk-launch FastqToSam -F1 $Location1/$name2 -O $Location2/${splited_name2[0]}.${splited_name2[1]}.sam -SM "${splited_name2[1]}" -SO coordinate
gatk-launch MergeSamFiles -I $Location2/${splited_name[0]}.${splited_name[1]}.sam -I $Location2/${splited_name2[0]}.${splited_name2[1]}.sam -O $Location2/${splited_name[0]}_R2.${splited_name[1]}.sam 
