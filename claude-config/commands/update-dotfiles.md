Update or install dotfiles by running the bootstrap script from GitHub.

Execute this bash command:

```bash
curl -fsSL https://raw.githubusercontent.com/shanecowherd/dotfiles/main/bootstrap.sh | bash
```

This will:
- Install all required tools if not present (Homebrew, git, tmux, lazygit, neovim, etc.)
- Clone or update the dotfiles repository
- Update all configurations (Claude, tmux, nvim, lazygit, Ghostty)
- Set up aliases and preferences
- Handle SSH configuration if needed

Works from any directory and handles both initial setup and updates.