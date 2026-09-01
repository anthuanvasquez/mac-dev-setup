#!/usr/bin/env bash
# modules/rclone/install.sh: Verify rclone is available.

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/utils.sh
source "$DOTFILES_ROOT/lib/utils.sh"

info "Setting up rclone..."

if ! command -v rclone &>/dev/null; then
  warn "rclone not found. Install via: brew install rclone"
  exit 0
fi

success "rclone is ready. Configure remotes with: rclone config"
