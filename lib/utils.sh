#!/usr/bin/env bash
# utils.sh: Shared helpers used across the dotfiles installer.

set -euo pipefail

# Resolve the dotfiles root from any script located under it.
# Usage: dotfiles_root
export DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Print helpers
info() { echo "   [INFO] $*"; }
success() { echo "   [OK] $*"; }
warn() { echo "   [WARN] $*" >&2; }
error() { echo "   [ERROR] $*" >&2; }

# Ensure a command exists.
require() {
  if ! command -v "$1" &>/dev/null; then
    error "$1 is required but not installed"
    return 1
  fi
}

# Detect the OS family.
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if grep -qE "(Microsoft|WSL)" /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}

# Ask for confirmation.
confirm() {
  local prompt="${1:-Are you sure?}"
  read -rp "$prompt [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]]
}
