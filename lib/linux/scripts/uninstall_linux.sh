#!/bin/bash

set -e

APP_DIR="/opt/discord-local-ai"
SYSTEMD_FILE="/etc/systemd/system/discord-ai.service"
ENV_FILE="$APP_DIR/.env"
DB_FILE="$APP_DIR/preferences.db"
LOG_FILE="$APP_DIR/homieOfAi.log"

echo "Stopping and disabling systemd service..."
sudo systemctl stop discord-ai || true
sudo systemctl disable discord-ai || true

echo "Removing systemd service file..."
sudo rm -f "$SYSTEMD_FILE"
sudo systemctl daemon-reload

echo "Removing environment file, logs, and database..."
sudo rm -f "$ENV_FILE" "$DB_FILE" "$LOG_FILE"

echo "Removing app directory (code will remain if edited manually)..."
sudo rm -rf "$APP_DIR"

echo "Uninstall complete."
