#!/usr/bin/env bash
# update-claude-commands.sh — copies Claude commands from dotfiles to ~/.claude/commands

set -eo pipefail

echo "📋 Updating Claude commands..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"
SOURCE_DIR="$SCRIPT_DIR/claude-config/commands"

# Create Claude commands directory if it doesn't exist
if [ ! -d "$CLAUDE_COMMANDS_DIR" ]; then
  echo "Creating Claude commands directory: $CLAUDE_COMMANDS_DIR"
  mkdir -p "$CLAUDE_COMMANDS_DIR"
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

# Copy all .md files from claude-commands to ~/.claude/commands
echo "Copying commands from $SOURCE_DIR to $CLAUDE_COMMANDS_DIR..."
count=0
for file in "$SOURCE_DIR"/*.md; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp -v "$file" "$CLAUDE_COMMANDS_DIR/"
    ((count++))
  fi
done

if [ $count -eq 0 ]; then
  echo "⚠️  No .md files found in $SOURCE_DIR"
else
  echo "✅ Successfully copied $count command(s) to $CLAUDE_COMMANDS_DIR"
  echo "Available commands:"
  for file in "$CLAUDE_COMMANDS_DIR"/*.md; do
    if [ -f "$file" ]; then
      basename "$file" .md | sed 's/^/  - /'
    fi
  done
fi