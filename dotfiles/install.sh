#!/bin/bash

# install.sh - Minimal dotfiles installer using GNU Stow
if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU Stow is not installed. Run: omarchy-pkg-add stow"
    exit 1
fi

# Move to the script's directory so paths are relative
cd "$(dirname "$0")" || exit

echo "Stowing all configuration directories to $HOME..."

# Stow all subdirectories (indicated by the trailing slash)
stow -v -t ~ */

echo "Done!"
