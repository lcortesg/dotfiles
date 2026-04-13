#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

# ensure base dirs exist
mkdir -p ~/.config

packages=(zsh bash starship wezterm plugins)

for pkg in "${packages[@]}"; do
    echo "→ Stowing $pkg"
    stow "$pkg"
done

echo "✔ Dotfiles installed"
