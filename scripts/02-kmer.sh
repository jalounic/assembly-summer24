#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=06:00:00
#SBATCH --job-name=jf
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/output_jf_%j.o
#SBATCH --error=/data/users/jackermann/error_jf_%j.e
#SBATCH --partition=pibu_el8
module load Jellyfish/2.3.0-GCC-10.3.0


WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/users/jackermann/assembly-annotation/participant_6

#mkdir /data/users/jackermann/assembly-annotation/read_QC/kmer_counting

# illumina only
IN=${READ_DIR}/Illumina

OUT=${WORKDIR}/read_QC/kmer_counting/
cd $OUT

#19 or 21?
jellyfish count -C -m 19 -s 5G -t 4 -o ill_reads19.jf <(zcat ${IN}/*_1.fastq.gz) <(zcat ${IN}/*_2.fastq.gz)
jellyfish histo -t 4 ill_reads19.jf > ill_reads19.histo

#19 or 21?
jellyfish count -C -m 21 -s 5G -t 4 -o ill_reads21.jf <(zcat ${IN}/*_1.fastq.gz) <(zcat ${IN}/*_2.fastq.gz)
jellyfish histo -t 4 ill_reads21.jf > ill_reads21.histo
