#if [ -r ~/.config/zshrc/.zshrc ]; then
#    source ~/.config/zshrc/.zshrc
#fi


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source ~/.bash_profile

#plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim


eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)
eval "$(/opt/homebrew/bin/brew shellenv)"

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#if [ "$TERM_PROGRAM" == "Apple Terminal" ]; then
#  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/theme.json)"
#fi

# Aliases

# VIM
alias v="/opt/homebrew/bin/nvim"
