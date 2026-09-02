#!/usr/bin/env bash

# This script sets sensible macOS defaults.
# Skips GUI-dependent commands in CI/headless environments.

echo "Setting macOS defaults..."

IS_CI="${CI:-false}"

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change (skip in CI — no GUI)
if [[ "$IS_CI" == "false" ]]; then
    osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true
fi

# Enable key repeating (press and hold) in favor of the character picker
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a fast key repeat rate
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Create Dock spacers only if they don't already exist (skip in CI — no Dock)
if [[ "$IS_CI" == "false" ]]; then
  SPACER='{tile-type = "spacer-tile";}'
  CURRENT_DOCK="$(defaults read com.apple.dock persistent-apps 2>/dev/null || true)"

  if echo "$CURRENT_DOCK" | grep -qF "$SPACER"; then
    echo "   [INFO] Dock spacers already present. Skipping."
  else
    echo "   [INFO] Creating Dock spacers..."
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    killall Dock
  fi
fi

echo "✅ macOS defaults configured. Some changes require a logout/restart to take effect."
