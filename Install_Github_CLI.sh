#!/bin/bash

# Script to install GitHub CLI (gh) on a Debian-based system.

set -e  # Exit on error
set -u  # Treat unset variables as errors

echo "Starting GitHub CLI installation..."

# Check for curl and install if not present
if ! command -v curl >/dev/null 2>&1; then
  echo "curl not found. Installing curl..."
  sudo apt update
  sudo apt install curl -y
else
  echo "curl is already installed."
fi

# Download GitHub CLI GPG key and add to keyring
KEYRING_PATH="/usr/share/keyrings/githubcli-archive-keyring.gpg"

if [ ! -f "$KEYRING_PATH" ]; then
  echo "Adding GitHub CLI GPG key to keyring..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of="$KEYRING_PATH"
  sudo chmod go+r "$KEYRING_PATH"
else
  echo "GitHub CLI GPG keyring already exists."
fi

# Add GitHub CLI APT repository if not already added
SOURCE_LIST="/etc/apt/sources.list.d/github-cli.list"
REPO_LINE="deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING_PATH] https://cli.github.com/packages stable main"

if ! grep -q "^$REPO_LINE" "$SOURCE_LIST" 2>/dev/null; then
  echo "Adding GitHub CLI APT repository..."
  echo "$REPO_LINE" | sudo tee "$SOURCE_LIST" > /dev/null
else
  echo "GitHub CLI APT repository already present."
fi

# Update APT and install GitHub CLI
echo "Updating package list..."
sudo apt update

echo "Installing GitHub CLI..."
sudo apt install gh -y

echo "GitHub CLI installation complete."
