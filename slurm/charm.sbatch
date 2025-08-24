#!/bin/bash
#SBATCH -J charmm
#SBATCH -o slurm-%j.out
# Replace the next two with your MSI account/partition:
# #SBATCH -A <your_account>
# #SBATCH -p <partition>
# Example CPU request (adjust to your cluster norms):
#SBATCH -N 1
#SBATCH --ntasks=8
#SBATCH --time=02:00:00

set -euo pipefail
module purge
# Load CHARMM; adjust to the module name on MSI (check `module avail charmm`)
module load charmm

# Run inside the staged scratch folder
echo "RUNDIR: $PWD"

# Example: run successive steps using your templates
mkdir -p logs

# 1) cleanup / protonation prep (if you have it)
# charmm -i charmm/templates/prep_clean.inp -o logs/prep_clean.out

# 2) solvation + PBC setup
charmm -i charmm/templates/solvate_pbc.inp -o logs/solvate_pbc.out

# 3) minimization
charmm -i charmm/templates/min_cg.inp -o logs/min_cg.out

# 4) short NPT equilibration
charmm -i charmm/templates/npt_eq.inp -o logs/npt_eq.out

# 5) (optional) production
# charmm -i charmm/templates/prod_md.inp -o logs/prod_md.out

