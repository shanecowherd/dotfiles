#!/usr/bin/env bash
# bootstrap.sh — installs brew tools, dotfiles, and Node.js environment

# Exit on errors and fail on undefined commands in pipelines
set -eo pipefail

echo "🔧 Starting bootstrap…"

# 1) Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi
brew update

# 2) Install packages: git, tmux, lazygit, neovim
echo "Installing git, tmux, lazygit, neovim…"
brew install git tmux lazygit neovim

# 3) Add aliases to ~/.zprofile
# vim alias
if ! grep -qx "alias vim='nvim'" "$HOME/.zprofile"; then
  echo "alias vim='nvim'" >> "$HOME/.zprofile"
  echo "Added alias vim='nvim' to ~/.zprofile"
fi

# lazygit aliases
if ! grep -q "alias lazygit=" "$HOME/.zprofile"; then
  echo 'alias lazygit="lazygit --use-config-file=\"$HOME/.config/lazygit/default.yml\""' >> "$HOME/.zprofile"
  echo "Added alias lazygit to ~/.zprofile"
fi

if ! grep -q "alias lazygit-sbs=" "$HOME/.zprofile"; then
  echo 'alias lazygit-sbs="lazygit --use-config-file=\"$HOME/.config/lazygit/side-by-side.yml\""' >> "$HOME/.zprofile"
  echo "Added alias lazygit-sbs to ~/.zprofile"
fi

# 4) Install NVM (Node Version Manager)
if ! command -v nvm &>/dev/null; then
  echo "Installing NVM…"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# 5) Load NVM for this session
echo "Loading NVM…"
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# 6) Install Node.js 20, set as default, and use it
echo "Installing Node.js v20…"
nvm install 20
nvm alias default 20
nvm use 20

echo "Node.js $(nvm version) installed, set as default, and active."

# 7) Install Claude Code and ccusage CLI tools
echo "Installing Claude Code and ccusage…"
npm install -g @anthropic-ai/claude-code ccusage

# 8) Clone or update dotfiles
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles to $DOTFILES_DIR…"
  git clone https://github.com/shanecowherd/dotfiles.git "$DOTFILES_DIR"
else
  echo "Dotfiles folder exists. Pulling latest…"
  git -C "$DOTFILES_DIR" pull
fi

# 9) Update Claude commands
if [ -f "$DOTFILES_DIR/update-claude-commands.sh" ]; then
  echo "Updating Claude commands…"
  "$DOTFILES_DIR/update-claude-commands.sh"
else
  echo "Claude commands script not found. Skipping."
fi

# 10) Update tmux configuration
if [ -f "$DOTFILES_DIR/update-tmux.sh" ]; then
  echo "Updating tmux configuration…"
  "$DOTFILES_DIR/update-tmux.sh"
else
  echo "Tmux update script not found. Skipping."
fi

# 11) Update Neovim configuration
if [ -f "$DOTFILES_DIR/update-nvim.sh" ]; then
  echo "Updating Neovim configuration…"
  "$DOTFILES_DIR/update-nvim.sh"
else
  echo "Neovim update script not found. Skipping."
fi

# 12) Update lazygit configuration
if [ -f "$DOTFILES_DIR/update-lazygit.sh" ]; then
  echo "Updating lazygit configuration…"
  "$DOTFILES_DIR/update-lazygit.sh"
else
  echo "Lazygit update script not found. Skipping."
fi

# 13) If no SSH key, prompt to import and switch remote
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

echo "✅ Bootstrap complete."

