# Dotfiles .zshrc
# Minimal entry point. Logic lives in $DOTFILES/config/shell/

# Base path: resolve the directory where this file is symlinked to.
# macOS readlink does not support -f, so we resolve the symlink manually.
_dotfiles_zshrc="${(%):-%N}"
if [[ -L "$_dotfiles_zshrc" ]]; then
  _dotfiles_zshrc="$(readlink "$_dotfiles_zshrc")"
fi
export DOTFILES="${DOTFILES:-$(cd "$(dirname "$_dotfiles_zshrc")/.." && pwd)}"

# 1. Load Path Configuration (CRITICAL FIRST STEP)
source "$DOTFILES/config/shell/path.zsh"

# 2. Load Environment Variables
source "$DOTFILES/config/shell/env.zsh"

# 3. Load Modules Logic
source "$DOTFILES/config/shell/aliases.zsh"
source "$DOTFILES/config/shell/functions.zsh"

# 4. Load OS-specific configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$DOTFILES/config/shell/macos_aliases.zsh"
fi

# 5. Tool Initializations (guarded — only init if installed)
command -v oh-my-posh &>/dev/null && eval "$(oh-my-posh init zsh)"
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"
command -v pyenv &>/dev/null && eval "$(pyenv init - zsh)"
command -v fzf &>/dev/null && eval "$(fzf --zsh)"
