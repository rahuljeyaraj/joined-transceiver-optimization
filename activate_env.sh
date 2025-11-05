#!/usr/bin/env bash
set -e
source ~/miniconda3/etc/profile.d/conda.sh
env_name="joined-transceiver-optimization"

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }

if conda info --envs | awk '{print $1}' | grep -xq "$env_name"; then
    info "Activating environment '$env_name'..."
    conda activate $env_name
else
    echo "❌ Environment '$env_name' does not exist. Run create_env.sh first."
    exit 1
fi

info "Listing installed packages..."
pip list | tee env_packages.txt
