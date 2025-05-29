#!/bin/bash

set -e

# Configuration
APP_DIR="$(pwd)/../../../.."
REPO_URL="https://github.com/moudakis-com/discord-local-ai.git"
ENV_FILE="$APP_DIR/.env"
SYSTEMD_FILE="/etc/systemd/system/discord-ai.service"
PYTHON_BIN="$(which python3)"

echo "Installing required packages..."
sudo apt update
sudo apt install -y python3 python3-pip git

echo "Cloning repository..."
sudo git clone "$REPO_URL" "$APP_DIR" || echo "Repo already cloned."

echo "Installing Python dependencies..."
sudo pip3 install -r "$APP_DIR/requirements.txt"

echo "Setting up .env file..."
if [ ! -f "$ENV_FILE" ]; then
  read -p "Enter your DISCORD_BOT_TOKEN: " TOKEN
  echo "DISCORD_BOT_TOKEN=$TOKEN" | sudo tee "$ENV_FILE" > /dev/null
  sudo chmod 600 "$ENV_FILE"
fi

echo "Creating systemd service..."
sudo tee "$SYSTEMD_FILE" > /dev/null <<EOF
[Unit]
Description=Discord Local AI Bot
After=network.target

[Service]
WorkingDirectory=$APP_DIR
ExecStart=$PYTHON_BIN $APP_DIR/home/homie.py
EnvironmentFile=$ENV_FILE
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading and starting systemd service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now discord-ai

echo "Discord AI bot installed and running."