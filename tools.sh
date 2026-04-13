#!/usr/bin/env bash
set -e

# --------------------------------------------------
# Helpers
# --------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

OS="$(uname)"
ARCH="$(uname -m)"

echo "→ Installing tools ($OS $ARCH)"

# --------------------------------------------------
# fzf
# --------------------------------------------------

install_fzf() {
    FZF_DIR="$HOME/.local/share/fzf"

    if [ ! -d "$FZF_DIR/.git" ]; then
        echo "→ Installing fzf"
        git clone --depth=1 https://github.com/junegunn/fzf "$FZF_DIR"
    else
        echo "→ Updating fzf"
        git -C "$FZF_DIR" fetch --depth=1 origin
        git -C "$FZF_DIR" reset --hard origin/master || true
    fi

    "$FZF_DIR/install" --key-bindings --completion --no-update-rc || true
}

# --------------------------------------------------
# starship
# --------------------------------------------------

install_starship() {
    if ! command_exists starship; then
        echo "→ Installing starship"
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    else
        echo "→ starship already installed"
    fi
}

# --------------------------------------------------
# zoxide
# --------------------------------------------------

install_zoxide() {
    if ! command_exists zoxide; then
        echo "→ Installing zoxide"
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    else
        echo "→ zoxide already installed"
    fi
}

# --------------------------------------------------
# Miniconda
# --------------------------------------------------

install_miniconda() {
    if [ -d "$HOME/miniconda3" ]; then
        echo "→ Miniconda already installed"
        return
    fi

    echo "→ Installing Miniconda"

    if [ "$OS" = "Darwin" ]; then
        if [ "$ARCH" = "arm64" ]; then
            URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
        else
            URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
        fi
    else
        if [ "$ARCH" = "x86_64" ]; then
            URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
        else
            URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"
        fi
    fi

    curl -sSLo miniconda.sh "$URL"
    bash miniconda.sh -b -p "$HOME/miniconda3"
    rm -f miniconda.sh
}

# --------------------------------------------------
# Run all installers
# --------------------------------------------------

install_fzf
install_starship
install_zoxide
install_miniconda

echo "✔ Tools installed"