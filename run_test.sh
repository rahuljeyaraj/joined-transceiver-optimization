#!/usr/bin/env bash
set -e

# === CONFIG ===
ENV_NAME="jto"

# === FUNCTIONS ===
info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }

# === Activate Conda ===
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
else
    echo "❌ Conda environment not found. Please run setup_conda.sh first."
    exit 1
fi

# Activate environment
info "Activating conda environment '$ENV_NAME'..."
conda activate "$ENV_NAME"

# === Run model testing ===
info "📊 Running model testing..."
python test_model_LBC_AWGN.py

# === Done ===
info "✅ Testing complete!"
conda deactivate
