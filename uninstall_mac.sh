#!/bin/bash

echo "Stopping any running bot process (if applicable)..."
pkill -f homie.py || true

echo "Removing virtual environment..."
rm -rf venv

echo "Deleting .env file..."
rm -f .env

echo "Deleting log and database files..."
rm -f homieOfAi.log preferences.db

echo "Uninstall complete. Project source files remain untouched."