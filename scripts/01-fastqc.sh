#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/output_fastqc_%j.o
#SBATCH --error=/data/users/jackermann/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

module load FastQC/0.11.9-Java-11;

WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/users/jackermann/assembly-annotation/participant_6

#illumina
#fastqc -o ${WORKDIR}/read_QC/fastqc  ${READ_DIR}/Illumina/*fastq.gz

#pacbio
#fastqc -t8 -o ${WORKDIR}/read_QC/fastqc  ${READ_DIR}/pacbio/*fastq.gz
#java runs out of heap memory

#RNAseq
#fastqc -o ${WORKDIR}/read_QC/fastqc  ${READ_DIR}/RNAseq/*fastq.gz

##multiqc: MultiQC/1.11-foss-2021a