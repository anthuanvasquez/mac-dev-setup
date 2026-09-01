#!/usr/bin/env bash
# modules/node/install.sh: Node.js setup via fnm and corepack.

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/utils.sh
source "$DOTFILES_ROOT/lib/utils.sh"

info "Setting up Node.js environment..."

if ! command -v fnm &>/dev/null; then
  warn "fnm not found. Skipping Node setup."
  exit 0
fi

# Evaluate fnm env so we can use it in the script
eval "$(fnm env)"

info "Installing Node.js v22.22.2..."
fnm install 22.22.2
fnm use 22.22.2
fnm default 22.22.2

info "Enabling Corepack for modern package managers..."
corepack enable pnpm
corepack prepare pnpm@latest --activate

info "Configuring npm to ignore scripts..."
npm config set ignore-scripts true

success "Node.js environment setup complete!"
