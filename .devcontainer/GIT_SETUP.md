# Dev Container Git Setup

This dev container automatically copies your Git configuration, SSH keys, and GPG setup from your host machine, enabling seamless Git usage with commit signing.

## What Gets Copied

- **Git Configuration**: `~/.gitconfig` (user settings, signing configuration)
- **SSH Keys**: All SSH keys including signing keys (`~/.ssh/`)
- **GPG Configuration**: GPG keys and configuration (`~/.gnupg/`)

## How It Works

The setup script runs automatically when the container starts and:
1. Mounts your home directory as `/host-home`
2. Copies Git config, SSH keys, and GPG setup
3. Sets proper file permissions
4. Configures Git repository safety settings

## Usage

### Automatic Setup
When you rebuild the dev container, everything is set up automatically. You can immediately:

```bash
# Check Git configuration
git config --global --list

# Make signed commits (automatic signing is enabled)
git commit -m "Your commit message"

# Verify commit signatures
git log --show-signature -1
```

## Troubleshooting

### Common Issues:
- **Git signing fails**: Check `ssh-add -l` and verify key is loaded
- **Repository unsafe warning**: Rebuild container to apply safety settings
- **Setup script fails**: Check container logs and verify `/host-home/` mount

### Manual Commands:
```bash
# Test Git configuration
git config --global --list

# Check SSH keys
ssh-add -l

# Test commit signing
git log --show-signature -1
```
