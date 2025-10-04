#!/bin/bash

# Script to set up Git configuration and keys in dev container
# This script copies Git config, SSH keys, and GPG setup from host to container

set -e

# Check if we're running in a container
if [ ! -d "/host-home" ]; then
    echo "Warning: /host-home mount not found. Skipping Git setup."
    echo "Make sure the devcontainer.json has the correct mount configuration."
    exit 0
fi

echo "Setting up Git configuration in dev container..."

# Create necessary directories
mkdir -p ~/.ssh
mkdir -p ~/.gnupg

# Copy Git configuration
if [ -f "/host-home/.gitconfig" ]; then
    echo "Copying Git configuration..."
    cp /host-home/.gitconfig ~/.gitconfig
else
    echo "No Git configuration found on host"
fi

# Copy SSH keys and configuration
if [ -d "/host-home/.ssh" ]; then
    echo "Copying SSH keys and configuration..."
    cp -r /host-home/.ssh/* ~/.ssh/ 2>/dev/null || true
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_* 2>/dev/null || true
    chmod 644 ~/.ssh/id_*.pub 2>/dev/null || true
    chmod 600 ~/.ssh/allowed_signers 2>/dev/null || true
    chmod 600 ~/.ssh/config 2>/dev/null || true
    chmod 600 ~/.ssh/known_hosts 2>/dev/null || true
else
    echo "No SSH directory found on host"
fi

# Copy GPG configuration
if [ -d "/host-home/.gnupg" ]; then
    echo "Copying GPG configuration..."
    cp -r /host-home/.gnupg/* ~/.gnupg/ 2>/dev/null || true
    chmod 700 ~/.gnupg
    chmod 600 ~/.gnupg/* 2>/dev/null || true
else
    echo "No GPG directory found on host"
fi

# Start SSH agent and add keys
echo "Starting SSH agent..."
eval "$(ssh-agent -s)" || echo "SSH agent already running"

# Add SSH signing key if it exists
if [ -f "$HOME/.ssh/id_ed25519_signing" ]; then
    echo "Adding SSH signing key to agent..."
    ssh-add ~/.ssh/id_ed25519_signing 2>/dev/null || echo "Key already added or failed to add"
fi

# Set up GPG agent
echo "Setting up GPG agent..."
gpgconf --kill gpg-agent 2>/dev/null || true
gpgconf --launch gpg-agent 2>/dev/null || echo "GPG agent setup failed"

# Fix Git configuration paths for container environment
echo "Fixing Git configuration paths..."

# Get the current signing key path
CURRENT_SIGNING_KEY=$(git config --global user.signingkey 2>/dev/null || echo "")
if [ -n "$CURRENT_SIGNING_KEY" ] && [[ "$CURRENT_SIGNING_KEY" == /home/* ]]; then
    echo "Updating signing key path from host to container..."
    echo "  Old path: $CURRENT_SIGNING_KEY"
    echo "  New path: $HOME/.ssh/id_ed25519_signing.pub"
    git config --global user.signingkey "$HOME/.ssh/id_ed25519_signing.pub"
fi

# Get the current allowedsigners file path
CURRENT_ALLOWEDSIGNERS=$(git config --global gpg.ssh.allowedsignersfile 2>/dev/null || echo "")
if [ -n "$CURRENT_ALLOWEDSIGNERS" ] && [[ "$CURRENT_ALLOWEDSIGNERS" == /home/* ]]; then
    echo "Updating allowedsigners file path..."
    echo "  Old path: $CURRENT_ALLOWEDSIGNERS"
    echo "  New path: $HOME/.ssh/allowed_signers"
    git config --global gpg.ssh.allowedsignersfile "$HOME/.ssh/allowed_signers"
fi

# Fix Git repository safety issue
echo "Fixing Git repository safety..."
git config --global --add safe.directory '*'

# Test Git configuration
echo "Testing Git configuration..."
git config --global --list | grep -E "(user|signing|gpg)" || echo "No Git config found"

echo "Git setup complete!"
echo "You can now use Git with commit signing in the dev container."
echo ""
echo "To test:"
echo "  git config --global --list"
echo "  git log --show-signature -1"