#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

PACKAGE_FILE="$(pwd)/packages.txt"

if [ ! -f "$PACKAGE_FILE" ]; then
    echo "❌ Missing packages.txt"
    exit 1
fi

# --------------------------------------------------
# Detect package manager
# --------------------------------------------------

OS="$(uname)"

if [ "$OS" = "Darwin" ]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "→ Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
    fi
    PM="brew"
elif command -v apt >/dev/null 2>&1; then
    PM="apt"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
else
    echo "❌ Unsupported package manager"
    exit 1
fi

echo "→ Using package manager: $PM"

# --------------------------------------------------
# Install packages
# --------------------------------------------------

while read -r pkg; do
    [ -z "$pkg" ] && continue

    echo "→ Installing $pkg"

    case "$PM" in
        brew)
            command -v "$pkg" >/dev/null 2>&1 || brew list "$pkg" >/dev/null 2>&1 || brew install "$pkg"
            ;;
        apt)
            dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt install -y "$pkg"
            ;;
        pacman)
            pacman -Qi "$pkg" >/dev/null 2>&1 || sudo pacman -Sy --noconfirm "$pkg"
            ;;
    esac

done < "$PACKAGE_FILE"

echo "✔ Packages installed"