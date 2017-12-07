#!/bin/bash
#SBATCH --job-name="Purged_demultiplexed"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/Purged_demultiplexed-%N-%j.out
#SBATCH -e err/Purged_demultiplexed-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/demultiplexed.txt"
location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS"
rm $location/purged_demultiplexed.txt
touch $location/purged_demultiplexed.txt

readarray Files< $List1
x=$((${#Files[@]} - 1))

for i in $(seq 0 $x)
do
	IFS='.' read -r -a name <<< "${Files[$i]}"
if [ "${name[1]}" == "unmatched" ]
then
	echo $i ${name[1]} ${Files[$i]}
else
    echo ${Files[$i]}  >> $location/purged_demultiplexed.txt
fi
	
done
