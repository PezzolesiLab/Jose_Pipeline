#!/bin/bash
#SBATCH --job-name="FASTQ-SAM_file"
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -o out/FASTQ-SAM_file-%N-%j.out
#SBATCH -e err/FASTQ-SAM_file-%N-%j.err
#SBATCH --mail-user=megahitokiri@hotmail.com
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi
#SBATCH --partition=ember
	
Location1=$1
Location2=$2
name1=$3
name2=$4
HG19="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/ucsc.hg19.fasta"
VCF1="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/1000G_phase1.indels.hg19.sites.vcf"
VCF2="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf"
VCF3="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources-GATK/dbsnp_138.hg19.vcf"
Interval1="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/medalists/FASTQs/ELID0792801.tiled.interval_list"
Interval2="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/medalists/FASTQs/ELID0792801.targeted.interval_list"
Interval3="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/medalists/FASTQs/MonogenicDM_genes.ELID0792801.tiled.interval_list"
Interval4="/uufs/chpc.utah.edu/common/home/pezzolesi-group1/medalists/FASTQs/MonogenicDM_genes.ELID0792801.targeted.interval_list"

module load bwa
module load gatk

IFS='.' read -r -a splited_name <<< "$3"
IFS='.' read -r -a splited_name2 <<< "$4"
header="@RG\tID:LIB018853_$5\tSM:$5\tLB:$5\tPL:Illumina\tCN:HMS-BPF"

bwa mem -M -t 12 -R $header $HG19 $Location1/$name1 $Location1/$name2 > $Location2/${splited_name[0]}_R2_aln.${splited_name[1]}.sam
gatk-launch SortSam -I $Location2/${splited_name[0]}_R2_aln.${splited_name[1]}.sam -O $Location2/${splited_name[0]}_R2_aln.${splited_name[1]}.bam -SO coordinate
gatk-launch MarkDuplicates -I $Location2/${splited_name[0]}_R2_aln.${splited_name[1]}.bam -O $Location2/${splited_name[0]}_R2_dupMark.${splited_name[1]}.bam -M $Location2/${splited_name[0]}_R2_Metrics.${splited_name[1]}.txt  
gatk-launch BaseRecalibrator -I $Location2/${splited_name[0]}_R2_dupMark.${splited_name[1]}.bam -O $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.table -R $HG19 -knownSites $VCF1 -knownSites $VCF2 -knownSites $VCF3
gatk-launch ApplyBQSR -bqsr $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.table -I $Location2/${splited_name[0]}_R2_dupMark.${splited_name[1]}.bam -O $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.bam
gatk -T DepthOfCoverage -R $HG19 -I $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.bam -o $Location2/COVERAGE/I1/${splited_name[0]}_R2_COVERAGE.${splited_name[1]}.txt -L $Interval1 -ct 1 -ct 3 -ct 5 -ct 10 -ct 15 -ct 20 -ct 25 -ct 30 -omitBaseOutput -omitIntervals -omitLocusTable
gatk -T DepthOfCoverage -R $HG19 -I $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.bam -o $Location2/COVERAGE/I2/${splited_name[0]}_R2_COVERAGE.${splited_name[1]}.txt -L $Interval2 -ct 1 -ct 3 -ct 5 -ct 10 -ct 15 -ct 20 -ct 25 -ct 30 -omitBaseOutput -omitIntervals -omitLocusTable
gatk -T DepthOfCoverage -R $HG19 -I $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.bam -o $Location2/COVERAGE/I3/${splited_name[0]}_R2_COVERAGE.${splited_name[1]}.txt -L $Interval3 -ct 1 -ct 3 -ct 5 -ct 10 -ct 15 -ct 20 -ct 25 -ct 30 -omitBaseOutput -omitIntervals -omitLocusTable
gatk -T DepthOfCoverage -R $HG19 -I $Location2/${splited_name[0]}_R2_RECALIBRATED.${splited_name[1]}.bam -o $Location2/COVERAGE/I4/${splited_name[0]}_R2_COVERAGE.${splited_name[1]}.txt -L $Interval4 -ct 1 -ct 3 -ct 5 -ct 10 -ct 15 -ct 20 -ct 25 -ct 30 -omitBaseOutput -omitIntervals -omitLocusTable

module unload bwa
module unload gatk

