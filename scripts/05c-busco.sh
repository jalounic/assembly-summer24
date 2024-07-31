#!/usr/bin/env bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --job-name=busco
#SBATCH --array=0-3
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/05b_busco%j.o
#SBATCH --error=/data/users/jackermann/05b_busco%j.e
#SBATCH --partition=pibu_el8

module load BUSCO/5.4.2-foss-2021a;

#flye
WORKDIR=/data/users/jackermann/assembly-annotation/assemblies/compare
OUTDIR=/data/users/jackermann/assembly-annotation/assemblies/compare/busco
cd ${OUTDIR}

FILES=(flye-raw flye-polished canu-raw canu-polished)

busco --cpu 4 -m genome -i ../${FILES[$SLURM_ARRAY_TASK_ID]}.fasta -o ${FILES[$SLURM_ARRAY_TASK_ID]} -l brassicales_odb10

# trinity
#busco --cpu 4 -m transcriptome -i ${WORKDIR}/trinity.fasta -o trinity -l brassicales_odb10