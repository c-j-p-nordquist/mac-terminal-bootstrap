#!/bin/bash

# Install dependencies
brew install gnupg pinentry-mac

# Create .gnupg directory if it doesn't exist
mkdir -p ~/.gnupg

# Configure gpg-agent
cat << EOF > ~/.gnupg/gpg-agent.conf
default-cache-ttl 600
max-cache-ttl 7200
pinentry-program /usr/local/bin/pinentry-mac
enable-ssh-support
EOF

# Restart gpg-agent
gpgconf --kill gpg-agent
gpg-agent --daemon

# Generate a GPG key pair
echo "Generating a new GPG key pair..."
gpg --full-generate-key

# List the GPG keys and note the key ID
echo "Listing GPG keys..."
gpg --list-secret-keys --keyid-format LONG

# Instructions to configure Git to use the GPG key
echo "After noting the key ID, use the following commands to configure Git:"
echo "  git config --global user.signingkey <key-id>"
echo "  git config --global commit.gpgsign true"
