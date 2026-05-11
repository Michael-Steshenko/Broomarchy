#!/bin/bash
# install.sh - Centralized installer for dotfiles
cd "$(dirname "$0")" || exit

# 1. Run user installation
sh user/install.sh

# 2. Run system installation
sh system/install.sh

echo ""
echo "Finish"
