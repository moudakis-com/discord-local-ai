#!/bin/bash

cd "$(dirname "$0")"
APP_DIR="$(cd "../../.." && pwd)"

echo "Stopping any running bot process (if applicable)..."
pkill -f homie.py || true

echo "Removing virtual environment..."
echo $APP_DIR/.venv
rm -rf $APP_DIR/.venv

echo "Deleting .env file..."
rm -f $APP_DIR/lib/homie/.env

echo "Deleting .env file..."
rm -rf $APP_DIR/lib/homie/__pycache__/

echo "Deleting log and database files..."
rm -f $APP_DIR/logs/homieOfAi.log $APP_DIR/db/preferences.db

echo "Uninstall complete. Project source files remain untouched."