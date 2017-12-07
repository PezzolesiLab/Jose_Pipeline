#!/bin/bash
#SBATCH --job-name="check_merged_files"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/merged_fastq.txt"
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/MERGED"
Header="Summary of Read Counts in Merged fastq Files: "
echo $Header  > $location/merged.summary

readarray Files< $List1
x=$((${#Files[@]} - 1))

for i in $(seq 0 $x)
do	
	file_name=$location/${Files[$i]}
   	echo ${Files[$i]}  >> $location/merged.summary
	wc -l $file_name | awk '{ print $1/4 }' >> $location/merged.summary
done
