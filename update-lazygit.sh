#!/usr/bin/env bash
# update-lazygit.sh — copies lazygit configuration from dotfiles to ~/.config/lazygit/

set -eo pipefail

echo "🚀 Updating lazygit configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAZYGIT_CONFIG_DIR="$HOME/.config/lazygit"
SOURCE_DIR="$SCRIPT_DIR/lazygit-config"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

# Create lazygit config directory if it doesn't exist
if [ ! -d "$LAZYGIT_CONFIG_DIR" ]; then
  echo "Creating lazygit config directory: $LAZYGIT_CONFIG_DIR"
  mkdir -p "$LAZYGIT_CONFIG_DIR"
fi

# Check if delta is installed (required for diff views)
if ! command -v delta &>/dev/null; then
  echo "📦 Installing delta for enhanced git diffs..."
  brew install git-delta
else
  echo "✅ Delta is already installed."
fi

# Copy all config files
echo "Copying lazygit configs from $SOURCE_DIR to $LAZYGIT_CONFIG_DIR..."
for file in "$SOURCE_DIR"/*.yml; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp -v "$file" "$LAZYGIT_CONFIG_DIR/"
  fi
done

echo "✅ Successfully updated lazygit configuration"
echo ""
echo "💡 Usage:"
echo "   - lazygit       : Standard diff view"
echo "   - lazygit-sbs   : Side-by-side diff view"
echo ""
echo "Note: Make sure to run 'source ~/.zprofile' or restart your terminal for aliases to work."