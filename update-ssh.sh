#!/usr/bin/env bash
# update-ssh.sh - Update SSH configuration for Ghostty terminal compatibility

echo "📡 Updating SSH configuration..."

# Check if .ssh directory exists
if [ ! -d "$HOME/.ssh" ]; then
    echo "⚠️  SSH directory not found at ~/.ssh"
    echo "Please set up SSH keys first (run bootstrap.sh and import keys when prompted)"
    echo "Then run this script again to configure SSH for Ghostty compatibility"
    exit 1
fi

# Create .ssh/config if it doesn't exist
if [ ! -f "$HOME/.ssh/config" ]; then
    echo "Creating ~/.ssh/config..."
    touch "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

# Source directory for SSH config
SSH_CONFIG_SOURCE="$(dirname "$0")/ssh-config/config"

# Check if our Ghostty compatibility section already exists
if grep -q "# SSH Config for Ghostty Terminal Compatibility" "$HOME/.ssh/config"; then
    echo "Ghostty SSH compatibility already configured."
    echo "To update, please manually edit ~/.ssh/config"
else
    echo "Adding Ghostty terminal compatibility to SSH config..."
    
    # If the config file is empty or only contains whitespace, just copy our config
    if [ ! -s "$HOME/.ssh/config" ] || [ -z "$(grep -v '^[[:space:]]*$' "$HOME/.ssh/config")" ]; then
        cp "$SSH_CONFIG_SOURCE" "$HOME/.ssh/config"
    else
        # Otherwise, prepend our config to the existing file
        echo "" >> "$HOME/.ssh/config"
        echo "# --- Added by dotfiles update-ssh.sh ---" >> "$HOME/.ssh/config"
        cat "$SSH_CONFIG_SOURCE" >> "$HOME/.ssh/config"
    fi
    
    chmod 600 "$HOME/.ssh/config"
    echo "✅ SSH config updated successfully!"
fi

echo ""
echo "Your SSH connections will now use TERM=xterm-256color to ensure compatibility"
echo "with servers that don't have Ghostty terminfo installed."
echo ""
echo "For servers you control, you can optionally run:"
echo "  ~/dotfiles/export-ghostty-terminfo.sh user@host"
echo "to export full Ghostty terminfo for the best experience."