#!/bin/bash
# =====================================================
# Raspberry Pi Deployment Script (streamlined)
# Author: Terry (GitHub: TSpiker)
# =====================================================

set -euo pipefail
LOGFILE="/var/log/setup_pi.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "🚀 Starting Pi setup at $(date)"

# --- 1️⃣ System updates ---
echo "📦 Updating system..."
sudo apt update -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# --- 2️⃣ Core tools ---
echo "🧰 Installing essential packages..."
sudo apt install -y git curl wget vim net-tools python3 python3-pip python3-venv make

# --- 3️⃣ Enable SSH (safe if already on) ---
echo "🔑 Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

# --- 4️⃣ Python virtual environment setup ---
if [ ! -d /opt/scripts/venv ]; then
  echo "🐍 Creating Python virtual environment..."
  sudo mkdir -p /opt/scripts
  sudo chown -R pi:pi /opt/scripts
  sudo -u pi python3 -m venv /opt/scripts/venv
else
  echo "🐍 Python venv already exists; skipping."
fi

echo "📦 Installing Python dependencies..."
sudo -u pi /opt/scripts/venv/bin/pip install --upgrade pip
sudo -u pi /opt/scripts/venv/bin/pip install -r /opt/pi-deploy/requirements.txt

# --- 5️⃣ Copy/update scripts and configs ---
echo "📂 Syncing scripts and configs..."
sudo cp -r /opt/pi-deploy/scripts/* /opt/scripts/
sudo cp -r /opt/pi-deploy/configs/* /opt/data/ 2>/dev/null || true

echo "✅ Pi setup complete at $(date)"
