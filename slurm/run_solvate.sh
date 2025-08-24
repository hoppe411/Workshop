#!/bin/bash
#SBATCH --job-name=solvate_petase
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --mem=4gb
#SBATCH -o slurm-%j.out

module load charmm

SCRATCH=/scratch.global/$USER/petase_solv_$SLURM_JOBID
mkdir -p $SCRATCH
cd $SCRATCH

# Copy inputs from previous step
cp ~/projects/repo/charmm/templates/solvate_ions.inp .
cp ~/petase_charmm/output/petase_clean.psf .
cp ~/petase_charmm/output/petase_clean.pdb .
cp -r ~/projects/repo/charmm/toppar .

# Run CHARMM
charmm < solvate_ions.inp > solvate_ions.log

# Copy results back
cp *.psf *.pdb *.log ~/petase_charmm/output/
