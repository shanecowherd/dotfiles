#!/usr/bin/env bash
# update-ghostty.sh - Updates Ghostty configuration from dotfiles

set -eo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"

echo "🔧 Updating Ghostty configuration..."

# Create config directory if it doesn't exist
mkdir -p "$GHOSTTY_CONFIG_DIR"

# Copy Ghostty config
if [ -f "$DOTFILES_DIR/ghostty-config/config" ]; then
    cp "$DOTFILES_DIR/ghostty-config/config" "$GHOSTTY_CONFIG_DIR/config"
    echo "✅ Ghostty configuration copied to $GHOSTTY_CONFIG_DIR/config"
else
    echo "❌ Error: ghostty-config/config not found in dotfiles"
    exit 1
fi

# Check if Ghostty is running and provide reload instructions
if pgrep -x "ghostty" > /dev/null; then
    echo ""
    echo "📝 Ghostty is running. To apply the new configuration:"
    echo "   - Restart Ghostty, or"
    echo "   - Open a new Ghostty window"
else
    echo ""
    echo "📝 Configuration will be applied when you start Ghostty"
fi

echo ""
echo "🎨 Font configuration:"
echo "   - Using: Hack Nerd Font Mono"
echo "   - This font supports powerline symbols and tmux rounded corners"
echo ""
echo "If you don't see proper symbols, ensure Hack Nerd Font is installed:"
echo "   brew install --cask font-hack-nerd-font"