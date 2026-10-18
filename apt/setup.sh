#!/bin/bash
# Fast, deb822-compliant installer for WAIncognito APT repository
set -e

echo "Configuring WAIncognito APT repository..."

# Clean up legacy one-line entry to prevent duplicate target warnings
if [ -f "/etc/apt/sources.list.d/waincognito.list" ]; then
    sudo rm -f "/etc/apt/sources.list.d/waincognito.list"
fi

# Download and install GPG keyring into the standard /etc/apt/keyrings/ directory
sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://moodynooby.github.io/whatsapp-web-incognito/apt/waincognito.gpg" | sudo tee /etc/apt/keyrings/waincognito.gpg > /dev/null
sudo chmod 644 /etc/apt/keyrings/waincognito.gpg

# Install deb822 sources file with Signed-By verification and architecture restrictions
SOURCES_FILE="/etc/apt/sources.list.d/waincognito.sources"
sudo tee "$SOURCES_FILE" > /dev/null << 'EOF'
Types: deb
URIs: https://moodynooby.github.io/whatsapp-web-incognito/apt/
Suites: stable
Components: main
Architectures: amd64 arm64
Signed-By: /etc/apt/keyrings/waincognito.gpg
EOF
sudo chmod 644 "$SOURCES_FILE"


echo "Updating package list for WAIncognito..."
sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/waincognito.sources" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0" 2>/dev/null || sudo apt-get update

echo ""
echo "WAIncognito repository successfully configured with deb822 format!"
echo "Run: sudo apt install waincognito"
