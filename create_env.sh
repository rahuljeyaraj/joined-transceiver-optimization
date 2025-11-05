#!/usr/bin/env bash
set -e
source ~/miniconda3/etc/profile.d/conda.sh

env_name="jto"
py_ver="3.7"

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }

# 1️⃣ Check for existing environment
if conda info --envs | awk '{print $1}' | grep -xq "$env_name"; then
    info "⚠️  Environment '$env_name' already exists. Removing it for a clean setup..."
    conda deactivate || true
    conda remove -y --name $env_name --all
    info "✅ Old environment '$env_name' removed."
fi

# 2️⃣ Create a fresh environment
info "🚀 Creating a new environment '$env_name' with Python $py_ver..."
conda create -y -n $env_name python=$py_ver

# 3️⃣ Activate the new environment
info "Activating environment '$env_name'..."
conda activate $env_name

# 4️⃣ Install dependencies
info "📦 Installing dependencies..."
conda install -y pip
pip install --upgrade pip
pip install numpy==1.15.4 keras==2.2.4 tensorflow==1.13.1 protobuf==3.20.3 matplotlib==3.0.3

# 5️⃣ Confirm installation
info "✅ Environment '$env_name' created successfully with all dependencies."
info "Listing installed packages:"
pip list | tee env_packages.txt
