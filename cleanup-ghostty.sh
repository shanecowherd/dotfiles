#!/usr/bin/env bash
# cleanup-ghostty.sh - Removes Ghostty and Nerd Fonts from the system

set -eo pipefail

echo "🧹 Starting Ghostty and Nerd Fonts cleanup..."
echo ""

# Track if anything was cleaned up
CLEANED=0

# 1. Uninstall Ghostty if installed
if brew list --cask ghostty &>/dev/null; then
    echo "📦 Uninstalling Ghostty..."
    brew uninstall --cask ghostty
    echo "✅ Ghostty uninstalled"
    CLEANED=1
else
    echo "ℹ️  Ghostty is not installed"
fi

# 2. Uninstall Hack Nerd Font if installed
if brew list --cask font-hack-nerd-font &>/dev/null; then
    echo "📦 Uninstalling Hack Nerd Font..."
    brew uninstall --cask font-hack-nerd-font
    echo "✅ Hack Nerd Font uninstalled"
    CLEANED=1
else
    echo "ℹ️  Hack Nerd Font is not installed"
fi

# 3. Remove Ghostty configuration directory
if [ -d "$HOME/.config/ghostty" ]; then
    echo "📁 Removing Ghostty configuration directory..."
    rm -rf "$HOME/.config/ghostty"
    echo "✅ Removed ~/.config/ghostty/"
    CLEANED=1
else
    echo "ℹ️  No Ghostty configuration directory found"
fi

# 4. Check for and notify about SSH config
if [ -f "$HOME/.ssh/config" ] && grep -q "xterm-ghostty" "$HOME/.ssh/config" 2>/dev/null; then
    echo ""
    echo "⚠️  Note: Your SSH config may still contain Ghostty-related TERM settings"
    echo "   The current dotfiles use xterm-256color which is compatible"
    echo "   Run ~/dotfiles/update-ssh.sh to update SSH configuration"
fi

echo ""
if [ $CLEANED -eq 1 ]; then
    echo "✅ Cleanup complete!"
    echo ""
    echo "📝 Next steps:"
    echo "   - Pull the latest dotfiles: cd ~/dotfiles && git pull"
    echo "   - Update configurations: run individual update scripts as needed"
else
    echo "✅ Nothing to clean up - your system is already clean!"
fi