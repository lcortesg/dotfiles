export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# --------------------------------------------------
# History
# --------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory        # don't overwrite history
setopt incappendhistory     # write immediately
setopt sharehistory         # share across sessions
setopt hist_ignore_dups     # no duplicate entries
setopt hist_ignore_space    # ignore commands starting with space

# --------------------------------------------------
# Antidote (compiled bundle)
# --------------------------------------------------

if [ -f "$HOME/.zsh_plugins.zsh" ]; then
    source "$HOME/.zsh_plugins.zsh"
else
    echo "⚠️  Missing plugin bundle. Run setup.sh"
fi

# --------------------------------------------------
# Completion
# --------------------------------------------------

autoload -Uz compinit
compinit -C

# history substring search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --------------------------------------------------
# zoxide
# --------------------------------------------------

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd cd)"

# --------------------------------------------------
# fzf
# --------------------------------------------------

if [ -d "$HOME/.local/share/fzf/shell" ]; then
    source "$HOME/.local/share/fzf/shell/key-bindings.zsh"
    source "$HOME/.local/share/fzf/shell/completion.zsh"
fi

# --------------------------------------------------
# Starship
# --------------------------------------------------

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# --------------------------------------------------
# Conda (lazy)
# --------------------------------------------------

if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    conda() {
        unset -f conda
        source "$HOME/miniconda3/etc/profile.d/conda.sh"
        conda "$@"
    }
fi