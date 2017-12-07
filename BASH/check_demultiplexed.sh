#!/bin/bash
#SBATCH --job-name="check_demultiplexed"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/check_demultiplexed-%N-%j.out
#SBATCH -e err/check_demultiplexed-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/demultiplexed.txt"
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/DEMULTIPLEXED"
Header="Summary of Read Counts in Demultiplexed Files: "
echo $Header  > $location/demultiplexed.summary

readarray Files< $List1
x=$((${#Files[@]} - 1))

for i in $(seq 0 $x)
do
        file_name=$location/${Files[$i]}
        echo ${Files[$i]}  >> $location/demultiplexed.summary
        wc -l $file_name | awk '{ print $1/4 }' >> $location/demultiplexed.summary
done
