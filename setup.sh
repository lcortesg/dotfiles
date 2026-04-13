#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

# --------------------------------------------------
# Helpers
# --------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

clone_if_missing() {
    local repo="$1"
    local dir="$2"

    if [ ! -d "$dir" ]; then
        echo "→ Installing $(basename "$dir")"
        git clone --depth=1 "$repo" "$dir"
    else
        echo "→ $(basename "$dir") already installed"
    fi
}

# --------------------------------------------------
# OS detection
# --------------------------------------------------

OS="$(uname)"

case "$OS" in
    Darwin) PLATFORM="mac" ;;
    Linux)  PLATFORM="linux" ;;
    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "→ Detected OS: $PLATFORM"

# --------------------------------------------------
# Base dirs
# --------------------------------------------------

mkdir -p ~/.config
mkdir -p ~/.config/plugins

ZSH_PLUGINS="$HOME/.config/plugins"

# --------------------------------------------------
# Ensure dependencies
# --------------------------------------------------

if ! command_exists git; then
    echo "❌ git is required"
    exit 1
fi

if ! command_exists stow; then
    echo "→ Installing stow"

    if command_exists brew; then
        brew install stow
    elif command_exists apt; then
        sudo apt update && sudo apt install -y stow
    elif command_exists pacman; then
        sudo pacman -Sy --noconfirm stow
    else
        echo "❌ Install stow manually"
        exit 1
    fi
fi

# --------------------------------------------------
# ZSH plugins
# --------------------------------------------------

plugins=(
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-history-substring-search"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-completions"
  "djui/alias-tips"
  "MichaelAquilina/zsh-you-should-use"
)

for plugin in "${plugins[@]}"; do
    name=$(basename "$plugin")
    clone_if_missing "https://github.com/$plugin" "$ZSH_PLUGINS/$name"
done

# --------------------------------------------------
# fzf
# --------------------------------------------------

FZF_DIR="$ZSH_PLUGINS/fzf"

if [ ! -d "$FZF_DIR" ]; then
    echo "→ Installing fzf"
    git clone --depth=1 https://github.com/junegunn/fzf "$FZF_DIR"
fi

# Always ensure keybindings/completions are installed
"$FZF_DIR/install" --key-bindings --completion --no-update-rc || true

# --------------------------------------------------
# starship
# --------------------------------------------------

if ! command_exists starship; then
    echo "→ Installing starship"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "→ starship already installed"
fi

# --------------------------------------------------
# zoxide
# --------------------------------------------------

if ! command_exists zoxide; then
    echo "→ Installing zoxide"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
    echo "→ zoxide already installed"
fi

# --------------------------------------------------
# Miniconda (cross-platform + CPU detection)
# --------------------------------------------------

if [ ! -d "$HOME/miniconda3" ]; then
    echo "→ Installing Miniconda"

    ARCH="$(uname -m)"

    if [ "$PLATFORM" = "mac" ]; then
        if [ "$ARCH" = "arm64" ]; then
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
        else
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
        fi
    else
        if [ "$ARCH" = "x86_64" ]; then
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
        elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"
        else
            echo "❌ Unsupported architecture: $ARCH"
            exit 1
        fi
    fi

    echo "→ Downloading for $PLATFORM ($ARCH)"

    curl -sSLo miniconda.sh "$MINICONDA_URL"
    bash miniconda.sh -b -p "$HOME/miniconda3"
    rm -f miniconda.sh
else
    echo "→ Miniconda already installed"
fi

# --------------------------------------------------
# Stow dotfiles
# --------------------------------------------------

./stow.sh

echo "✔ Setup complete"