export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# --------------------------------------------------
# Zsh setup
# --------------------------------------------------
autoload -Uz compinit
compinit

# --------------------------------------------------
# Plugins (dotfiles)
# --------------------------------------------------
ZSH_PLUGINS="$HOME/.config/zshrc/plugins"

# autosuggestions FIRST
[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

# syntax highlighting LAST
[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --------------------------------------------------
# zoxide
# --------------------------------------------------
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd cd)"

# --------------------------------------------------
# fzf
# --------------------------------------------------
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# --------------------------------------------------
# Starship
# --------------------------------------------------
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# --------------------------------------------------
# Conda (portable)
# --------------------------------------------------
CONDA_HOME="$HOME/miniconda3"

if [ -x "$CONDA_HOME/bin/conda" ]; then
    __conda_setup="$("$CONDA_HOME/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$CONDA_HOME/etc/profile.d/conda.sh" ]; then
        . "$CONDA_HOME/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_HOME/bin:$PATH"
    fi
    unset __conda_setup
fi