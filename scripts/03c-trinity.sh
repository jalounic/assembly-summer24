#!/bin/sh
#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/03c-trinity_%j.o
#SBATCH --error=/data/users/jackermann/03c-trinity_%j.e
#SBATCH --partition=pibu_el8

module load Trinity/2.15.1-foss-2021a;

WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/users/jackermann/assembly-annotation/participant_6

cd ${WORKDIR}/trinity-assembly

Trinity --seqType fq --max_memory 48G \
--left ${READ_DIR}/RNAseq/*_1.fastq.gz --right ${READ_DIR}/RNAseq/*_2.fastq.gz --SS_lib_type RF \
--CPU 12
