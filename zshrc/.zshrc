export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# --------------------------------------------------
# Plugins (dotfiles)
# --------------------------------------------------
ZSH_PLUGINS="$HOME/.config/zshrc/plugins"

# autosuggestions FIRST
[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

# history substring search (after autosuggestions)
[ -f "$ZSH_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh" ] && \
    source "$ZSH_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh"

# better completions (must be before compinit)
[ -d "$ZSH_PLUGINS/zsh-completions/src" ] && \
    fpath+=("$ZSH_PLUGINS/zsh-completions/src")

# --------------------------------------------------
# Completion system
# --------------------------------------------------
autoload -Uz compinit
compinit -C

# keybindings for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# optional helpers
[ -f "$ZSH_PLUGINS/alias-tips/alias-tips.plugin.zsh" ] && \
    source "$ZSH_PLUGINS/alias-tips/alias-tips.plugin.zsh"

[ -f "$ZSH_PLUGINS/you-should-use/you-should-use.plugin.zsh" ] && \
    source "$ZSH_PLUGINS/you-should-use/you-should-use.plugin.zsh"

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
#[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
if [ -f "$ZSH_PLUGINS/fzf/shell/key-bindings.zsh" ]; then
    source "$ZSH_PLUGINS/fzf/shell/key-bindings.zsh"
    source "$ZSH_PLUGINS/fzf/shell/completion.zsh"
fi

# --------------------------------------------------
# Starship
# --------------------------------------------------
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# --------------------------------------------------
# Conda (portable)
# --------------------------------------------------
#
conda() {
    unset -f conda
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
    conda "$@"
}
# CONDA_HOME="$HOME/miniconda3"

# if [ -x "$CONDA_HOME/bin/conda" ]; then
#     __conda_setup="$("$CONDA_HOME/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
#     if [ $? -eq 0 ]; then
#         eval "$__conda_setup"
#     elif [ -f "$CONDA_HOME/etc/profile.d/conda.sh" ]; then
#         . "$CONDA_HOME/etc/profile.d/conda.sh"
#     else
#         export PATH="$CONDA_HOME/bin:$PATH"
#     fi
#     unset __conda_setup
# fi
