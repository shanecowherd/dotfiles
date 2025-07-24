#!/usr/bin/env bash
# update-claude-agents.sh — copies Claude agents from dotfiles to ~/.claude/agents

set -eo pipefail

echo "🤖 Updating Claude agents..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"
SOURCE_DIR="$SCRIPT_DIR/claude-config/agents"

# Create Claude agents directory if it doesn't exist
if [ ! -d "$CLAUDE_AGENTS_DIR" ]; then
  echo "Creating Claude agents directory: $CLAUDE_AGENTS_DIR"
  mkdir -p "$CLAUDE_AGENTS_DIR"
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

# Copy all .md files from claude-config/agents to ~/.claude/agents
echo "Copying agents from $SOURCE_DIR to $CLAUDE_AGENTS_DIR..."
count=0
for file in "$SOURCE_DIR"/*.md; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp -v "$file" "$CLAUDE_AGENTS_DIR/"
    ((count++))
  fi
done

if [ $count -eq 0 ]; then
  echo "⚠️  No .md files found in $SOURCE_DIR"
else
  echo "✅ Successfully copied $count agent(s) to $CLAUDE_AGENTS_DIR"
  echo "Available agents:"
  for file in "$CLAUDE_AGENTS_DIR"/*.md; do
    if [ -f "$file" ]; then
      basename "$file" .md | sed 's/^/  - /'
    fi
  done
fi