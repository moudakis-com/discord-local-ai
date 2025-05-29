#!/bin/bash
OS_TYPE="$(uname)"

if [ "$OS_TYPE" = "Darwin" ]; then
    echo "Running on macOS"
    # macOS-specific setup
    chmod +x ./lib/macos/scripts/install_mac.sh
    bash ./lib/macos/scripts/install_mac.sh
elif [ "$OS_TYPE" = "Linux" ]; then
    echo "Running on Linux"
    # Linux-specific setup
    chmod +x ./lib/linux/scripts/install_linux.sh
    bash ./lib/linux/scripts/install_linux.sh
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi