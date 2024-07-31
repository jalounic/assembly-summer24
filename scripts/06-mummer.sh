#!/usr/bin/env bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=mummer
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/mummer_%j.o
#SBATCH --error=/data/users/jackermann/mummer_%j.e
#SBATCH --partition=pibu_el8

module load MUMmer/4.0.0rc1-GCCcore-10.3.0;

# Define paths to directories
WORKDIR=/data/users/jackermann/assembly-annotation/assemblies/compare
cd ${WORKDIR}/mummerplots

PREFIX=canu_flye
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
ass1=${WORKDIR}/flye-polished.fasta
ass2=${WORKDIR}/canu-polished.fasta

mkdir ${PREFIX}
cd ${PREFIX}

nucmer --prefix=${PREFIX} --breaklen 1000 --mincluster 1000 ${ass1} ${ass2}

# Filter the alignments (one-to-one)
delta-filter -1 ${PREFIX}.delta > ${PREFIX}.filtered.delta

# Generate plots using mummerplot
mummerplot -R ${ass1} -Q ${ass2} --filter -t png --large --layout --fat ${PREFIX}.filtered.delta