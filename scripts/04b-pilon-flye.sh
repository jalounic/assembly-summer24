#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=48G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=pilon
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/pilon-flye%j.o
#SBATCH --error=/data/users/jackermann/pilon-flye%j.e
#SBATCH --partition=pibu_el8

module load Bowtie2/2.4.4-GCC-10.3.0;
module load SAMtools/1.13-GCC-10.3.0;

### index
WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_6/Illumina

####flye
cd ${WORKDIR}/assemblies/flye
bowtie2-build flye-raw.fasta flyeindex
echo "flye indexing done, starting alignment"

# align
bowtie2 --sensitive-local -p $SLURM_CPUS_PER_TASK -x flyeindex -1 <(zcat ${READ_DIR}/ERR3624574_1.fastq.gz) -2 <(zcat ${READ_DIR}/ERR3624574_2.fastq.gz) -S flye.sam
echo "flye alignment done, starting samtools"
# sort and convert sam to bam
samtools sort -@ $SLURM_CPUS_PER_TASK flye.sam -o flye-sorted.sam
samtools view -bS flye-sorted.sam -o flye.bam
samtools index flye.bam
echo "flye sorted and converted, starting pilon"

# pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar --genome flye-raw.fasta --frags flye.bam
echo "flye pilon done"
