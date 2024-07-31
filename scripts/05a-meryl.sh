#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=meryl
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/jackermann/meryl%j.o
#SBATCH --error=/data/users/jackermann/meryl%j.e
#SBATCH --partition=pibu_el8

# Define paths to directories
WORKDIR=/data/users/jackermann/assembly-annotation/assemblies/compare/meryl
READ_DIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_6/Illumina

cd ${WORKDIR}
kmer_size=21 # safe bet

# use canu apptainer for meryl command
apptainer exec \
--bind $WORKDIR,$READ_DIR \
/data/courses/assembly-annotation-course/containers/canu_2.2.sif \
bash -c "meryl count k=${kmer_size} threads=4 memory=48 ${READ_DIR}/ERR3624574_1.fastq.gz output ${WORKDIR}/kmer_db_1.meryl && meryl count k=${kmer_size} threads=4 memory=48 ${READ_DIR}/ERR3624574_1.fastq.gz output ${WORKDIR}/kmer_db_2.meryl && meryl union-sum ${WORKDIR}/kmer_db_1.meryl ${WORKDIR}/kmer_db_2.meryl output ${WORKDIR}/Ler-k21-db.meryl"