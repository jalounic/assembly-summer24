#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=48G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=pilon
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/pilon-canu%j.o
#SBATCH --error=/data/users/jackermann/pilon-canu%j.e
#SBATCH --partition=pibu_el8

module load Bowtie2/2.4.4-GCC-10.3.0;
module load SAMtools/1.13-GCC-10.3.0;

### index
WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_6/Illumina

####canu
cd ${WORKDIR}/assemblies/canu
#bowtie2-build canu-raw.contigs.fasta canuindex
echo "canu indexing done, starting alignment"

# align
#bowtie2 --sensitive-local -p 4 -x canuindex -1 <(zcat ${READ_DIR}/ERR3624574_1.fastq.gz) -2 <(zcat ${READ_DIR}/ERR3624574_2.fastq.gz) -S canu.sam
echo "canu alignment done, starting samtools"

##### didn't load samtools at first, should break here!

# sort and convert sam to bam
samtools sort -T $SCRATCH -@ $SLURM_CPUS_PER_TASK canu.sam -o canu-sorted.sam
samtools view -bS canu-sorted.sam -o canu.bam
samtools index canu.bam
echo "canu sorted and converted, starting pilon"

# pilon
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar --genome canu-raw.contigs.fasta --frags canu.bam
echo "canu pilon done"
