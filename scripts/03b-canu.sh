#!/bin/sh
#SBATCH --time=48:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=james.ackermann@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jackermann/03b-canu_out%j.o
#SBATCH --error=/data/users/jackermann/03b-canu_err%j.e
#SBATCH --partition=pibu_el8

### run as soon as you looked at genomesize (genomescope!!)

WORKDIR=/data/users/jackermann/assembly-annotation
READ_DIR=/data/courses/assembly-annotation-course/raw_data/Ler/participant_6/pacbio

apptainer exec \
--bind $WORKDIR,$READ_DIR \
/data/courses/assembly-annotation-course/containers/canu_2.2.sif \
canu -p canu-raw -d ${WORKDIR}/assemblies/canu genomeSize=131m -maxThreads=$SLURM_CPUS_PER_TASK -maxMemory=$((SLURM_MEM_PER_NODE / 1024)) -pacbio ${READ_DIR}/ERR3415825.fastq.gz ${READ_DIR}/ERR3415826.fastq.gz