export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

BREW_PREFIX="/opt/homebrew"

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
export PATH="$HOME/miniconda3/bin:$PATH"
