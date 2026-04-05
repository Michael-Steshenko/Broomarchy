#!/bin/bash
# system/install.sh - Stow system packages to /
cd "$(dirname "$0")" || exit

echo "Stowing system packages to /..."
sudo stow -v -t / */
