#!/usr/bin/env bash
# modules/python/install.sh: Python setup via pyenv.

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/utils.sh
source "$DOTFILES_ROOT/lib/utils.sh"

info "Setting up Python environment..."

if ! command -v pyenv &>/dev/null; then
  warn "pyenv not found. Skipping Python setup."
  exit 0
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

info "Installing Python 3.12..."
pyenv install -s 3.12
pyenv global 3.12

success "Python environment setup complete!"
