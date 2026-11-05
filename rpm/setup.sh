#!/bin/bash
# Fast installer for WAIncognito DNF / RPM repository
set -e

echo "Configuring WAIncognito DNF/RPM repository..."

# Download and install GPG key into /etc/pki/rpm-gpg
sudo mkdir -p /etc/pki/rpm-gpg
curl -fsSL "https://moodynooby.github.io/whatsapp-web-incognito/rpm/RPM-GPG-KEY-waincognito" | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-waincognito > /dev/null
sudo chmod 644 /etc/pki/rpm-gpg/RPM-GPG-KEY-waincognito

# Install repo configuration
sudo curl -fsSL "https://moodynooby.github.io/whatsapp-web-incognito/rpm/waincognito.repo" -o /etc/yum.repos.d/waincognito.repo
sudo chmod 644 /etc/yum.repos.d/waincognito.repo


echo ""
echo "WAIncognito RPM repository successfully configured!"
echo "Run: sudo dnf install waincognito"
