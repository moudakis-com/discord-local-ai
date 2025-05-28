#!/bin/bash

# Change into script directory
cd "$(dirname "$0")"

echo "Installing Python and pip dependencies..."
brew install python

echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo "Installing Python requirements..."
pip install -r requirements.txt

echo "Setting up environment..."
if [ ! -f .env ]; then
  read -p "Enter your DISCORD_BOT_TOKEN: " token
  echo "DISCORD_BOT_TOKEN=$token" > .env
fi

echo "Launching bot..."
python homie.py