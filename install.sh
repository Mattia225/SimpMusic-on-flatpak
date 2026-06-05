#!/bin/bash
set -e

echo "=================================================="
echo "  SimpMusic Flatpak All-In-One Installer"
echo "=================================================="

# Check for required tools
for cmd in git flatpak flatpak-builder; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: '$cmd' is required but not installed."
        echo "Please install all dependencies before running this installer."
        exit 1
    fi
done

REPO_URL="https://github.com/Mattia225/simpmusic-flatpak.git"
TARGET_DIR="simpmusic-flatpak"

# Clone or update the repository
if [ -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' already exists. Navigating and updating..."
    cd "$TARGET_DIR"
    git pull origin main
else
    echo "Cloning the manifest repository from GitHub..."
    git clone "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR"
fi

# Clean potentially corrupted or old build caches
echo "Clearing build environments and local caches..."
rm -rf .flatpak-builder/ build-dir/

# Trigger the Flatpak build mechanism
echo "Initiating Flatpak build and local installation process..."
flatpak-builder --user --install build-dir io.github.simpmusic.SimpMusic.yml --force-clean

echo "=================================================="
echo "Installation process finalized successfully."
echo "You can now execute: flatpak run io.github.simpmusic.SimpMusic"
echo "=================================================="
