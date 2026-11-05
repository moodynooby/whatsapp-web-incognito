#!/bin/bash
# Fast installer for WAIncognito Arch Linux repository
set -e

CONF="/etc/pacman.conf"
REPO_NAME="waincognito"

echo "Configuring WAIncognito Arch Linux repository..."

# 1. Import and locally sign the GPG key
TEMP_KEY=$(mktemp)
curl -fsSL "https://moodynooby.github.io/whatsapp-web-incognito/arch/waincognito.asc" -o "$TEMP_KEY"
sudo pacman-key --add "$TEMP_KEY"
KEY_ID=$(gpg --show-keys --with-colons "$TEMP_KEY" | awk -F: '/^pub/ {print $5}' | tail -n 1)
rm -f "$TEMP_KEY"

if [ -n "$KEY_ID" ]; then
    echo "Locally signing repository key $KEY_ID..."
    sudo pacman-key --lsign-key "$KEY_ID"
fi


# 2. Add [waincognito] section to /etc/pacman.conf if not already present
if ! grep -q "^[$REPO_NAME]" "$CONF"; then
    echo "Adding repository entry to $CONF..."
    sudo tee -a "$CONF" > /dev/null << 'EOF'

[waincognito]
SigLevel = Optional TrustAll
Server = https://moodynooby.github.io/whatsapp-web-incognito/arch/$arch
EOF
fi

# 3. Synchronize repository
echo "Syncing pacman databases..."
sudo pacman -Sy

echo ""
echo "WAIncognito Arch repository successfully configured!"
echo "Run: sudo pacman -S waincognito"
