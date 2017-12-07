#!/bin/bash
#SBATCH --job-name="UBAM-FASTQ"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/UBAM-FASTQ-%N-%j.out
#SBATCH -e err/UBAM-FASTQ-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember

List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/purged_demultiplexed.txt"
Location1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/DEMULTIPLEXED"
Location2="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/UBAM-FASTQ"
readarray Files< $List1
x=$((${#Files[@]} - 1))
let x=$x/2
name1=0
name2=0
counter=0
rounds=0

for i in $(seq 0 $x)
do

if [ $rounds -eq 12 ]
then
	let name2=$name1+52
else
	let name2=$name1+50
fi

if [ $rounds -eq 13 ]
then
	let name2=$name2+2
fi

sbatch UBAM-FASTQ_file.sh $Location1 $Location2 ${Files[$name1]} ${Files[$name2]}

let counter=$counter+1

if [ $counter -eq 50 ]
then
	counter=0
	let rounds=$rounds+1
fi

if [ $rounds -eq 13 ]
then
	let name1=(rounds*100)+$counter-50
else
	let name1=(rounds*100)+$counter
fi
done
