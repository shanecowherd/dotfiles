#!/usr/bin/env bash
# update-claude.sh — copies CLAUDE.md from dotfiles to ~/.claude/

# Exit on errors and fail on undefined commands in pipelines
set -eo pipefail

DOTFILES_DIR="$HOME/dotfiles"
SOURCE_FILE="$DOTFILES_DIR/claude-config/CLAUDE.md"
CLAUDE_DIR="$HOME/.claude"
TARGET_FILE="$CLAUDE_DIR/CLAUDE.md"

echo "📝 Updating Claude user preferences..."

# Create ~/.claude directory if it doesn't exist
if [ ! -d "$CLAUDE_DIR" ]; then
  echo "Creating $CLAUDE_DIR directory..."
  mkdir -p "$CLAUDE_DIR"
fi

# Copy CLAUDE.md to ~/.claude/
if [ -f "$SOURCE_FILE" ]; then
  echo "Copying CLAUDE.md to $TARGET_FILE..."
  cp "$SOURCE_FILE" "$TARGET_FILE"
  echo "✅ Claude user preferences updated successfully!"
else
  echo "❌ Error: CLAUDE.md not found at $SOURCE_FILE"
  exit 1
fi

echo ""
echo "Your personal Claude preferences have been installed at ~/.claude/CLAUDE.md"
echo "These preferences will be applied to all Claude Code sessions."