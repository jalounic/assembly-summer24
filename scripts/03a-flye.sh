#!/bin/sh
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/03a-flye_out%j.o
#SBATCH --error=/data/users/jackermann/03a-flye_err%j.e
#SBATCH --partition=pibu_el8

module load Flye/2.9-GCC-10.3.0;

WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/users/jackermann/assembly-annotation/participant_6

flye --pacbio-raw ${READ_DIR}/pacbio/* --out-dir ${WORKDIR}/flye-assembly --threads 16