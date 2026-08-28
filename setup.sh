#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

echo "→ Starting setup"

# --------------------------------------------------
# System packages
# --------------------------------------------------

echo "→ Installing system packages"
./packages.sh

# --------------------------------------------------
# Tools
# --------------------------------------------------

echo "→ Installing tools"
./tools.sh

# --------------------------------------------------
# Dotfiles
# --------------------------------------------------

echo "→ Installing dotfiles"
./stow.sh

# --------------------------------------------------
# Plugins
# --------------------------------------------------

echo "→ Building plugins"
./plugins.sh

# --------------------------------------------------
# Default shell
# --------------------------------------------------

echo "→ Setting default shell"
./shell.sh

echo "✔ Setup complete"