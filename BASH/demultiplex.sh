#!/bin/bash
#SBATCH --job-name="demultiplex"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/demultiplex-%N-%j.out
#SBATCH -e err/demultiplex-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
List1="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/LISTS/merged_fastq.txt"
List2="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/DEMULTIPLEXED/comai_barcodes1-96"
Location="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/DEMULTIPLEXED"
Location2="/uufs/chpc.utah.edu/common/home/u1123911/PIPELINE/FASTQ/MERGED"
readarray Codes< $List2
readarray Files< $List1
Last=0
Rounds=0

x=$((${#Files[@]} - 1))
let x=$x/2
file_number=0
function barcodes
{
if [ $Rounds -eq $x ]
then
        number_codes=49
else
        number_codes=50
fi
let file_number=$Rounds+1
rm $Location/comai_barcode$file_number.txt
touch $Location/comai_barcode$file_number.txt

for i in $(seq 1 $number_codes)
do
        echo ${Codes[$Last]} >> $Location/comai_barcode$file_number.txt
        let Last=$Last+1
        if [ $Last -eq 96 ]
        then
                Last=0
        fi
done


if [ $Rounds -eq $x ]
then
        echo ${Codes[0]} >> $Location/comai_barcode$file_number.txt
        echo ${Codes[1]} >> $Location/comai_barcode$file_number.txt
        echo ${Codes[2]} >> $Location/comai_barcode$file_number.txt
fi

let Rounds=$Rounds+1

}

for i in $(seq 0 $x)
do
        barcodes
done

file_name=0
file_name2=0
for i in $(seq 0 $x)
do
let code_number=$i+1
let file_name2=$file_name+1
sbatch  demultiplex_file.sh $Location/comai_barcode$code_number.txt $Location2 ${Files[$file_name]} $Location ${Files[$file_name2]}
let file_name=$file_name+2

done
