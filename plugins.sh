#!/usr/bin/env zsh
set -e

echo "→ Building plugin bundle (antidote)"

ANTIDOTE_DIR="$HOME/.antidote"
PLUGIN_FILE="$HOME/.config/zsh/plugins.txt"
OUTPUT_FILE="$HOME/.zsh_plugins.zsh"

# --------------------------------------------------
# Checks
# --------------------------------------------------

if [ ! -d "$ANTIDOTE_DIR" ]; then
    echo "❌ Antidote not installed"
    exit 1
fi

if [ ! -f "$PLUGIN_FILE" ]; then
    echo "❌ Missing plugins.txt at $PLUGIN_FILE"
    exit 1
fi

# --------------------------------------------------
# Build bundle
# --------------------------------------------------

source "$ANTIDOTE_DIR/antidote.zsh"

antidote bundle < "$PLUGIN_FILE" > "$OUTPUT_FILE"

echo "✔ Plugin bundle generated at $OUTPUT_FILE"