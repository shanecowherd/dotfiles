#!/usr/bin/env bash
# update-nvim.sh — copies neovim configuration from dotfiles to ~/.config/nvim/

set -eo pipefail

echo "🚀 Updating Neovim configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
SOURCE_FILE="$SCRIPT_DIR/nvim-config/init.lua"

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "❌ Error: Source file not found: $SOURCE_FILE"
  exit 1
fi

# Create nvim config directory if it doesn't exist
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  echo "Creating Neovim config directory: $NVIM_CONFIG_DIR"
  mkdir -p "$NVIM_CONFIG_DIR"
fi

# Copy init.lua
echo "Copying init.lua from $SOURCE_FILE to $NVIM_CONFIG_DIR/init.lua..."
cp -v "$SOURCE_FILE" "$NVIM_CONFIG_DIR/init.lua"

# Check if nvim is installed
if ! command -v nvim &>/dev/null; then
  echo "⚠️  Neovim is not installed. Skipping plugin installation."
  echo "   Install with: brew install neovim"
  exit 0
fi

# Install/update Packer plugins automatically
echo "📦 Installing/updating Neovim plugins with Packer..."
echo "   This may take a moment on first run..."

# Run PackerSync in headless mode
# The autocmd ensures nvim quits after Packer completes
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2>&1 | grep -v "^$" || true

# Give it a moment to ensure everything is written
sleep 1

echo "✅ Successfully updated Neovim configuration"
echo ""
echo "💡 Tips:"
echo "   - Open Neovim with: nvim"
echo "   - Manage plugins with: :PackerSync"
echo "   - View plugin status with: :PackerStatus"