#!/usr/bin/env bash
# export-ghostty-terminfo.sh - Export Ghostty terminfo to remote servers

if [ $# -eq 0 ]; then
    echo "Usage: $0 user@host [user@host2 ...]"
    echo ""
    echo "This script exports Ghostty terminfo to remote servers for full terminal"
    echo "compatibility. This is optional - the SSH config already provides basic"
    echo "compatibility by setting TERM=xterm-256color."
    echo ""
    echo "Example:"
    echo "  $0 user@server.com"
    echo "  $0 user@server1.com user@server2.com"
    exit 1
fi

# Check if Ghostty terminfo exists locally
if ! infocmp xterm-ghostty >/dev/null 2>&1; then
    echo "❌ Error: xterm-ghostty terminfo not found on local system"
    echo "Make sure Ghostty is properly installed"
    exit 1
fi

# Export terminfo to temporary file
TEMP_TERMINFO=$(mktemp)
infocmp xterm-ghostty > "$TEMP_TERMINFO"

echo "🚀 Exporting Ghostty terminfo to remote servers..."

# Process each host
for HOST in "$@"; do
    echo ""
    echo "📡 Processing $HOST..."
    
    # Check if we can connect
    if ! ssh -o ConnectTimeout=5 "$HOST" "echo 'Connection successful'" >/dev/null 2>&1; then
        echo "❌ Failed to connect to $HOST"
        continue
    fi
    
    # Copy terminfo file and compile it on remote
    if scp -q "$TEMP_TERMINFO" "$HOST:/tmp/xterm-ghostty.terminfo"; then
        if ssh "$HOST" "tic /tmp/xterm-ghostty.terminfo && rm /tmp/xterm-ghostty.terminfo" 2>/dev/null; then
            echo "✅ Successfully installed xterm-ghostty terminfo on $HOST"
            echo "   You can now use Ghostty without TERM override on this host"
        else
            echo "⚠️  Failed to compile terminfo on $HOST (may need sudo access)"
            echo "   Try running on remote: sudo tic /tmp/xterm-ghostty.terminfo"
        fi
    else
        echo "❌ Failed to copy terminfo to $HOST"
    fi
done

# Cleanup
rm -f "$TEMP_TERMINFO"

echo ""
echo "🎉 Export complete!"
echo ""
echo "Note: The SSH config TERM override will still work as a fallback."