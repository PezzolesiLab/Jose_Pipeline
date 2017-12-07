#!/bin/bash
#SBATCH --job-name="Summary_coverage"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/Summary_coverage-%N-%j.out
#SBATCH -e err/Summary_coverage-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/coverage_summary.txt"
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/FASTQ-SAM/COVERAGE"
Header="Summary of DEPTH OF COVERAGE: "

readarray Files< $List1

x=$((${#Files[@]} - 1))
for j in $(seq 1 4)
do
echo $Header  > $location/I$j/Coverage.summary
echo sample_id total mean third_quartile granular_median first_quartile above_1 above_3 above_5 above_10 above_15 above_20 above_25 above_30>> $location/I$j/Coverage.summary

	for i in $(seq 0 $x)
	do
                file_name=$location/I$j/${Files[$i]}
				echo $file_name
                awk 'FNR>=2 && FNR<=2' $file_name >> $location/I$j/Coverage.summary
	done
done
