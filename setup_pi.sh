#!/bin/bash
# =====================================================
# Raspberry Pi Deployment Script
# Author: Terry  (GitHub: TSpiker)
# =====================================================

set -euo pipefail
LOGFILE="/var/log/setup_pi.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "🚀 Starting full Pi setup at $(date)"

# --- 1️⃣ System updates ---
echo "📦 Updating system..."
sudo apt update -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# --- 2️⃣ Core tools ---
echo "🧰 Installing base packages..."
sudo apt install -y git curl wget vim net-tools python3 python3-pip python3-venv

# --- 3️⃣ Hostname (optional) ---
NEW_HOSTNAME="rpi-deploy"
sudo hostnamectl set-hostname "$NEW_HOSTNAME"
if ! grep -q "$NEW_HOSTNAME" /etc/hosts; then
  echo "127.0.1.1  $NEW_HOSTNAME" | sudo tee -a /etc/hosts
fi

# --- 4️⃣ Enable SSH ---
echo "🔑 Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

# --- 5️⃣ Folder structure ---
sudo mkdir -p /opt/scripts /opt/logs /opt/data
sudo chown -R pi:pi /opt

# --- 6️⃣ Python environment ---
sudo -u pi python3 -m venv /opt/scripts/venv
sudo -u pi /opt/scripts/venv/bin/pip install --upgrade pip
sudo -u pi /opt/scripts/venv/bin/pip install -r /opt/pi-deploy/requirements.txt

# --- 7️⃣ Copy scripts/configs ---
sudo cp -r /opt/pi-deploy/scripts/* /opt/scripts/
sudo cp -r /opt/pi-deploy/configs/* /opt/data/

echo "✅ Setup complete at $(date)"
