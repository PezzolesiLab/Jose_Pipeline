#!/bin/bash
#SBATCH --job-name="unziper"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
module load python

List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/1895.txt"
List2="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/1902.txt"

FC_1895="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FILES/FC_01895"
FC_1902="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FILES/FC_01902"


function unzipping
{
python - <<END
infile = open("$1", 'r')
for line in infile:
	info = line.split('.')
	name = "$2" +"/"+ line
	print(name)
	newname=info[0]+"."+info[1]
	print(newname)
	print("$3")
print("FINAL")
infile.close()
END
}

unzipping $List1 $FC_1895 1895
unzipping $List2 $FC_1902 1902


#sbatch unzip_file.sh $FC_1895/LIB018853_GEN00048256_S1_L001_R1.fastq.bz2 LIB018853_GEN00048256_S1_L001_R1.fastq 


module unload python
