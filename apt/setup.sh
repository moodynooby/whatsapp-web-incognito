#!/bin/bash
# One-line installer for WAIncognito APT repository
set -e

echo "Configuring WAIncognito APT repository..."
SOURCES_FILE="/etc/apt/sources.list.d/waincognito.list"
echo "deb [trusted=yes] https://moodynooby.github.io/whatsapp-web-incognito/apt/ stable main" | sudo tee "$SOURCES_FILE" > /dev/null
sudo chmod 644 "$SOURCES_FILE"

echo "Updating package list..."
sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/waincognito.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0" || sudo apt-get update

echo ""
echo "WAIncognito repository is configured!"
echo "Run: sudo apt install waincognito"
