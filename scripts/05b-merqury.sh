#!/usr/bin/env bash
#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=merqury
#SBATCH --array=0-3
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/jackermann/merqury_%j.o
#SBATCH --error=/data/users/jackermann/merqury_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/jackermann/assembly-annotation/assemblies/compare
## container path: /mnt/containers/apptainer/merqury_1.3.sif

FILES=(flye-raw flye-polished canu-raw canu-polished)

cd $WORKDIR

export MERQURY="/usr/local/share/merqury"

apptainer exec \
--bind ${WORKDIR} \
/mnt/containers/apptainer/merqury_1.3.sif \
merqury.sh \
${WORKDIR}/meryl/Ler-k21-db.meryl \
${WORKDIR}/${FILES[$SLURM_ARRAY_TASK_ID]}.fasta \
${FILES[$SLURM_ARRAY_TASK_ID]}-merqury

echo "done!"