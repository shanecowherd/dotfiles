#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Starting bootstrap…"

# 1) Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi
brew update

# 2) Install packages
echo "Installing git, tmux, lazygit…"
brew install git tmux lazygit

# 3) Clone or update dotfiles
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles to $DOTFILES_DIR…"
  git clone https://github.com/shanecowherd/dotfiles.git "$DOTFILES_DIR"
else
  echo "Dotfiles folder exists. Pulling latest…"
  git -C "$DOTFILES_DIR" pull
fi

# 4) If no SSH key, prompt to import and switch remote
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
  read -rp "No SSH key found in ~/.ssh. Import keys now? [y/N] " resp
  if [[ $resp =~ ^[Yy]$ ]]; then
    read -rp "Path to your SSH key folder: " SSH_SRC
    if [ -d "$SSH_SRC" ]; then
      echo "Copying SSH keys…"
      mkdir -p ~/.ssh
      cp -v "$SSH_SRC"/* ~/.ssh/
      chmod 700 ~/.ssh
      chmod 600 ~/.ssh/id_*
      echo "Switching dotfiles remote to SSH…"
      git -C "$DOTFILES_DIR" remote set-url origin git@github.com:shanecowherd/dotfiles.git
    else
      echo "Folder not found: $SSH_SRC. Skipping import."
    fi
  fi
fi

echo "✅ Bootstrap complete. Next: cd $DOTFILES_DIR && ./install.sh"
