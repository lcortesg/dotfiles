#!/usr/bin/env bash
set -e

echo "→ Setting default shell to zsh"

ZSH_PATH="$(command -v zsh)"

if [ -z "$ZSH_PATH" ]; then
    echo "❌ zsh not found"
    exit 1
fi

if [ "$SHELL" = "$ZSH_PATH" ]; then
    echo "✔ zsh is already the default shell"
    exit 0
fi

if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
    echo "→ Adding $ZSH_PATH to /etc/shells"
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

chsh -s "$ZSH_PATH"

echo "✔ Default shell set to zsh (takes effect on next login)"
