#!/usr/bin/env bash
set -e

info() { echo -e "\033[1;34m[INFO]\033[0m $*"; }

# 1️⃣ Remove any existing conda installation
if [ -d "$HOME/miniconda3" ]; then
    info "⚠️ Existing Miniconda installation detected — removing it for a clean setup..."
    rm -rf "$HOME/miniconda3" ~/.conda ~/.continuum ~/.condarc
    sed -i '/miniconda3\/etc\/profile\.d\/conda\.sh/d' ~/.bashrc || true
    info "✅ Old Miniconda installation removed."
fi

# 2️⃣ Download and install a fresh Miniconda
info "🚀 Downloading and installing Miniconda..."
installer="Miniconda3-latest-Linux-x86_64.sh"
wget -q https://repo.anaconda.com/miniconda/${installer} -O /tmp/${installer}
bash /tmp/${installer} -b -p "$HOME/miniconda3"
rm /tmp/${installer}

# 3️⃣ Initialize conda for bash
export PATH="$HOME/miniconda3/bin:$PATH"
source "$HOME/miniconda3/etc/profile.d/conda.sh"
conda init
info "✅ Miniconda installed successfully."

# 4️⃣ Accept Terms of Service automatically
info "Accepting Anaconda TOS..."
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main || true
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r || true

# 5️⃣ Ensure conda loads automatically in future terminals
if ! grep -q "miniconda3/etc/profile.d/conda.sh" ~/.bashrc; then
    echo "source ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc
    info "Added conda init line to ~/.bashrc"
fi

# 6️⃣ Reload conda and verify installation
source ~/.bashrc
info "Conda installed successfully:"
conda --version
