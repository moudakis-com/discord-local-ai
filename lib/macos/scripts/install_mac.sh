#!/bin/bash

# Change into script directory and define base path
cd "$(dirname "$0")"
APP_DIR="$(cd "../../.." && pwd)"

echo "Installing Python and pip dependencies..."
brew install python

echo "Creating virtual environment..."
python3 -m venv "$APP_DIR/.venv"
source $APP_DIR/.venv/bin/activate

echo "Installing Python requirements..."
pip install -r "$APP_DIR/lib/homie/requirements.txt"

echo "Setting up environment..."
if [ ! -f "$APP_DIR/lib/homie/.env" ]; then
  read -p "Enter your DISCORD_BOT_TOKEN: " token
  echo "DISCORD_BOT_TOKEN=$token" > "$APP_DIR/lib/homie/.env"
fi

echo "Launching bot..."
python3 "$APP_DIR/lib/homie/homie.py"