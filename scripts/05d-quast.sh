#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/quast_%j.o
#SBATCH --error=/data/users/jackermann/quast_%j.e
#SBATCH --partition=pibu_el8

module load QUAST/5.0.2-foss-2021a

# Define paths to directories
WORKDIR=/data/users/jackermann/assembly-annotation/assemblies/compare
REFDIR=/data/courses/assembly-annotation-course/references
READ_DIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_6/pacbio

FILES=$(ls ${WORKDIR}/*.fasta | grep -v 'trinity.fasta')


#### with ref
OUTDIR=${WORKDIR}/quast

# Go to working directory
cd ${OUTDIR}

mkdir noref
cd noref
OUTDIR=${WORKDIR}/quast/noref

# with reference - longer
quast -o ${OUTDIR} -r ${REFDIR}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -g ${REFDIR}/TAIR10_GFF3_genes.gff -m 500 -t 16 --large --pacbio ${READ_DIR}/ERR3415825.fastq.gz --pacbio ${READ_DIR}/ERR3415826.fastq.gz --no-sv -e --est-ref-size 135000000 -i 500 ${FILES}

#without reference - took like 10mins
quast -o ${OUTDIR} -m 500 -t 16 --large --pacbio ${READ_DIR}/ERR3415825.fastq.gz --pacbio ${READ_DIR}/ERR3415826.fastq.gz --no-sv -e -i 500 ${FILES}

