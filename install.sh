#!/usr/bin/env bash
set -e

echo "📥 Cloning dotfiles..."
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/shanecowherd/dotfiles.git "$DOTFILES_DIR"
else
  echo "📦 Dotfiles already cloned. Pulling latest..."
  git -C "$DOTFILES_DIR" pull
fi

cd "$DOTFILES_DIR"
