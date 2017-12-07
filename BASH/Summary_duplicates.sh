#!/bin/bash
#SBATCH --job-name="Summary_duplicates"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/Summary_duplicates-%N-%j.out
#SBATCH -e err/Summary_duplicates-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/Duplicates_Metrics.txt"
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/FASTQ-SAM"
Header="Summary of Duplicated Files: "
echo $Header  > $location/Duplicates.summary
echo LIBRARY UNPAIRED_READS_EXAMINED READ_PAIRS_EXAMINED UNMAPPED_READS UNPAIRED_READ_DUPLICATES READ_PAIR_DUPLICATES READ_PAIR_OPTICAL_DUPLICATES PERCENT_DUPLICATION >> $location/Duplicates.summary

readarray Files< $List1

x=$((${#Files[@]} - 1))

for i in $(seq 0 $x)
do
                file_name=$location/${Files[$i]}
				echo ${Files[$i]} >> $location/Duplicates.summary
                awk 'FNR>=8 && FNR<=8' $file_name >> $location/Duplicates.summary
done
