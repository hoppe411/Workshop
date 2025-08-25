#!/usr/bin/env bash
set -euo pipefail

# --- config you might edit once ---
REPO_DIR="${REPO_DIR:-$HOME/projects/Workshop}"
SCRATCH_BASE="${SCRATCH_BASE:-/scratch/$USER/charmm}"
RUNID="${RUNID:-$(date +%Y%m%d-%H%M%S)}"
JOBNAME="${JOBNAME:-charmm-test}"
QUEUE_ARGS="${QUEUE_ARGS:---time=02:00:00 -N 1 -n 8}"  # tweak for MSI

# --- make run folder in scratch ---
RUNDIR="$SCRATCH_BASE/$RUNID"
mkdir -p "$RUNDIR"
echo "Run directory: $RUNDIR"

# stage inputs: copy only what you need
rsync -a --delete "$REPO_DIR/charmm/" "$RUNDIR/charmm/"
rsync -a "$REPO_DIR/slurm/charmm.sbatch" "$RUNDIR/"

# keep a symlink back to the repo for reference
ln -s "$REPO_DIR" "$RUNDIR/code"

# submit
cd "$RUNDIR"
sbatch $QUEUE_ARGS --job-name="$JOBNAME" charmm.sbatch

