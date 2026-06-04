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
# Antidote (Zsh plugin manager)
# --------------------------------------------------

install_antidote() {
    ANTIDOTE_DIR="$HOME/.antidote"

    if [ ! -d "$ANTIDOTE_DIR/.git" ]; then
        echo "→ Installing antidote"
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
    else
        echo "→ Updating antidote"
        git -C "$ANTIDOTE_DIR" fetch --depth=1 origin
        git -C "$ANTIDOTE_DIR" reset --hard origin/main
    fi
}

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
# Meslo LG Nerd Font
# --------------------------------------------------

install_meslo() {
    if [ "$OS" = "Darwin" ]; then
        FONTS_DIR="$HOME/Library/Fonts"
    else
        FONTS_DIR="$HOME/.local/share/fonts"
    fi
    mkdir -p "$FONTS_DIR"

    if [ -f "$FONTS_DIR/MesloLGS NF Regular.ttf" ]; then
        echo "→ Meslo LG Nerd Font already installed"
        return
    fi

    echo "→ Installing Meslo LG Nerd Font"

    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT

    curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip" -o "$TEMP_DIR/Meslo.zip"
    unzip -q "$TEMP_DIR/Meslo.zip" -d "$TEMP_DIR"
    find "$TEMP_DIR" -name "*.ttf" -exec cp {} "$FONTS_DIR/" \;

    if command_exists fc-cache; then
        fc-cache -fv "$FONTS_DIR" >/dev/null 2>&1
    fi
}

# --------------------------------------------------
# Atkinson Hyperlegible Mono Nerd Font
# --------------------------------------------------

install_atkinson() {
    if [ "$OS" = "Darwin" ]; then
        FONTS_DIR="$HOME/Library/Fonts"
    else
        FONTS_DIR="$HOME/.local/share/fonts"
    fi
    mkdir -p "$FONTS_DIR"

    if [ -f "$FONTS_DIR/AtkinsonHyperlegibleMono-Regular.ttf" ]; then
        echo "→ Atkinson Hyperlegible Mono Nerd Font already installed"
        return
    fi

    echo "→ Installing Atkinson Hyperlegible Mono Nerd Font"

    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT

    curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/AtkinsonHyperlegibleMono.zip" -o "$TEMP_DIR/AtkinsonHyperlegibleMono.zip"
    unzip -q "$TEMP_DIR/AtkinsonHyperlegibleMono.zip" -d "$TEMP_DIR"
    find "$TEMP_DIR" -name "*.ttf" -exec cp {} "$FONTS_DIR/" \;

    if command_exists fc-cache; then
        fc-cache -fv "$FONTS_DIR" >/dev/null 2>&1
    fi
}

# --------------------------------------------------
# Run all installers
# --------------------------------------------------

install_antidote
install_fzf
install_starship
install_zoxide
install_miniconda
install_meslo
install_atkinson

echo "✔ Tools installed"