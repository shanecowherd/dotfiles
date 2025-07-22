#!/usr/bin/env bash
# update-tmux.sh — copies tmux configuration from dotfiles to ~/.tmux.conf

set -eo pipefail

echo "🔧 Updating tmux configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_CONFIG_FILE="$HOME/.tmux.conf"
SOURCE_FILE="$SCRIPT_DIR/tmux-config/tmux.conf"

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "❌ Error: Source file not found: $SOURCE_FILE"
  exit 1
fi

# Copy tmux configuration
echo "Copying tmux config from $SOURCE_FILE to $TMUX_CONFIG_FILE..."
cp -v "$SOURCE_FILE" "$TMUX_CONFIG_FILE"

# Check if TPM (Tmux Plugin Manager) is installed
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "📦 Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "✅ TPM installed. Press prefix + I inside tmux to install plugins."
else
  echo "✅ TPM already installed."
fi

echo "✅ Successfully updated tmux configuration"
echo ""
echo "💡 Tip: If tmux is running, reload the configuration with:"
echo "   tmux source-file ~/.tmux.conf"
echo "   or press prefix + r inside tmux"