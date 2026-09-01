#!/usr/bin/env bash
# modules/git/install.sh: Git LFS setup.
# Static config lives in home/.gitconfig (symlinked).

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/utils.sh
source "$DOTFILES_ROOT/lib/utils.sh"

info "Configuring Git..."

if command -v git-lfs &>/dev/null; then
  info "Setting up Git LFS..."
  git lfs install
else
  warn "git-lfs not found. Skipping."
fi

success "Git configuration complete."
