export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

BREW_PREFIX="/opt/homebrew"

autoload -Uz compinit
compinit

# Plugins
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Conda (lazy)
# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lucas/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lucas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lucas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lucas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
