#!/bin/bash
# user/install.sh - Stow user packages to Home
cd "$(dirname "$0")" || exit

# Handle secrets template
if [ ! -f secrets/.secrets ]; then
    echo "Creating .secrets from template..."
    cp secrets/.secrets.template secrets/.secrets
fi

echo "Stowing user packages to $HOME..."
stow -v -t ~ */
