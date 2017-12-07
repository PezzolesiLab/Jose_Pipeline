#!/bin/bash
#SBATCH --job-name="concat"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/test3-%N-%j.out
#SBATCH -e err/test3-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/1895q.txt"
location1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/1895"
location2="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/1902"

python - <<END
import os
rows = 53
columns = 7
MATRIX = [[0 for i in xrange(columns)] for i in xrange(rows)] 
infile = open("$List1", 'r')
i=1
for line in infile:
	MATRIX[i][1] = line  
	info = line.split('_')
	MATRIX[i][2] = info[0]  
	MATRIX[i][3] = info[1]  
	MATRIX[i][4] = info[2]  
	MATRIX[i][5] = info[3]  
	MATRIX[i][6] = info[4]  
	i = i + 1
infile.close()

for x in xrange(1,53,4):
	file1_R1 ="$location1"+"/"+MATRIX[x][1] 
	file2_R1 ="$location2"+"/"+MATRIX[x][1]
	file3_R1 ="$location1"+"/"+MATRIX[x+2][1]
	file4_R1 ="$location2"+"/"+MATRIX[x+2][1]
	name_R1  =MATRIX[x][2]+"_"+MATRIX[x][3]+"_"+MATRIX[x][4]+"_merged_"+MATRIX[x][6]
	batch1=file1_R1.strip()+" "+file2_R1.strip()+" "+file3_R1.strip()+" "+file4_R1.strip()+" "+name_R1.strip()		
	print(x)
	os.system("sbatch concat_file.sh "+batch1)

for x in xrange(2,53,4):
        file1_R2 ="$location1"+"/"+MATRIX[x][1]
        file2_R2 ="$location2"+"/"+MATRIX[x][1]
        file3_R2 ="$location1"+"/"+MATRIX[x+2][1]
        file4_R2 ="$location2"+"/"+MATRIX[x+2][1]
        name_R2  =MATRIX[x][2]+"_"+MATRIX[x][3]+"_"+MATRIX[x][4]+"_merged_"+MATRIX[x][6]
	batch2=file1_R2.strip()+" "+file2_R2.strip()+" "+file3_R2.strip()+" "+file4_R2.strip()+" "+name_R2.strip()
        print(x)
        os.system("sbatch concat_file.sh "+batch2)
        
END




