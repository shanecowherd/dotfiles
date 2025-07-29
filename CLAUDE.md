# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a minimal dotfiles repository for bootstrapping macOS development environments. The main purpose is to quickly set up a development machine with essential tools and configurations.

## Key Components

### bootstrap.sh
The main installation script that:
1. Installs Homebrew (if not present)
2. Installs development tools: git, tmux, lazygit, neovim
3. Sets up aliases in ~/.zprofile:
   - `vim` → `nvim`
   - `lazygit` → uses default.yml config
   - `lazygit-sbs` → uses side-by-side.yml config
4. Installs NVM (Node Version Manager)
5. Installs Node.js v20 and sets it as default
6. Installs Claude Code and ccusage CLI tools
7. Clones this dotfiles repository to ~/dotfiles
8. Runs update-claude.sh to install personal Claude preferences
9. Runs update-claude-commands.sh to install custom Claude commands from claude-config/commands
10. Runs update-claude-agents.sh to install Claude agents from claude-config/agents
11. Runs update-tmux.sh to install tmux configuration
12. Runs update-nvim.sh to install Neovim configuration and plugins
13. Runs update-lazygit.sh to install lazygit configurations
14. Handles SSH key import and switches remote to SSH if keys are imported
15. Runs update-ssh.sh to configure SSH (if SSH is set up)

### update-claude.sh
A helper script that copies personal Claude preferences from the dotfiles repository to ~/.claude/CLAUDE.md. This script:
- Creates ~/.claude directory if needed
- Copies CLAUDE.md from claude-config/ to ~/.claude/CLAUDE.md
- These preferences apply to all Claude Code sessions

### update-claude-commands.sh
A helper script that copies custom Claude commands from the dotfiles repository to ~/.claude/commands. This script:
- Creates ~/.claude/commands directory if needed
- Copies all .md files from the claude-config/commands/ directory
- Shows which commands were successfully copied

### update-claude-agents.sh
A helper script that copies Claude agents from the dotfiles repository to ~/.claude/agents. This script:
- Creates ~/.claude/agents directory if needed
- Copies all .md files from the claude-config/agents/ directory
- Shows which agents were successfully copied
- Agents define specialized AI personas with specific expertise

### update-tmux.sh
A helper script that copies tmux configuration from the dotfiles repository to ~/.tmux.conf. This script:
- Copies tmux.conf from tmux-config/ to ~/.tmux.conf
- Installs TPM (Tmux Plugin Manager) if not present
- Provides instructions for reloading configuration

### update-nvim.sh
A helper script that copies Neovim configuration from the dotfiles repository to ~/.config/nvim/. This script:
- Creates ~/.config/nvim/ directory if needed
- Copies init.lua from nvim-config/ to ~/.config/nvim/init.lua
- Automatically runs PackerSync to install/update all plugins
- Works in headless mode for full automation

### update-lazygit.sh
A helper script that copies lazygit configurations from the dotfiles repository to ~/.config/lazygit/. This script:
- Creates ~/.config/lazygit/ directory if needed
- Copies all .yml config files from lazygit-config/
- Installs delta (git-delta) if not present for enhanced diffs
- Provides usage instructions for both aliases

### update-ssh.sh
A helper script that configures SSH for better terminal compatibility. This script:
- Checks if ~/.ssh directory exists (requires SSH keys to be set up first)
- Creates or updates ~/.ssh/config to set TERM=xterm-256color for all SSH connections
- Provides better terminal compatibility on remote servers
- Only runs after SSH keys are configured

### export-ghostty-terminfo.sh
An optional helper script for advanced users that exports terminfo to remote servers:
- Exports terminfo for better terminal experience
- Not required for basic functionality (SSH config provides compatibility)
- Usage: `~/dotfiles/export-ghostty-terminfo.sh user@host`

### claude-config/
Contains Claude Code configuration:
- `CLAUDE.md` - Personal preferences and environment prompts that apply to all projects
- `commands/` - Custom Claude Code slash commands:
  - `change-terminal-to-blue.md` - Creates blue-themed VSCode workspace settings
  - `change-terminal-to-green.md` - Creates green-themed VSCode workspace settings
  - `change-terminal-to-red.md` - Creates red-themed VSCode workspace settings
  - `rules.md` - Enforces a structured workflow with todo.md planning
- `agents/` - Specialized Claude agents with domain expertise:
  - `ios-architect-tdd.md` - iOS architecture and test-driven development expert
  - `embedded-safety-engineer.md` - Embedded systems and safety-critical software specialist
  - `react-native-performance-expert.md` - React Native performance optimization specialist
  - `senior-code-reviewer.md` - Code review and best practices expert
  - `engineering-tech-lead.md` - Technical leadership and architecture coordination

### tmux-config/
Contains tmux configuration:
- `tmux.conf` - Main tmux configuration with plugins, status bar styling, and session management

### nvim-config/
Contains Neovim configuration:
- `init.lua` - Main Neovim configuration with Packer plugin management

### lazygit-config/
Contains lazygit configurations:
- `default.yml` - Standard unified diff view using delta
- `side-by-side.yml` - Side-by-side diff view using delta


### ssh-config/
Contains SSH configuration templates:
- `config` - SSH config that sets TERM=xterm-256color for better terminal compatibility

## Commands

### Initial Setup
```bash
curl -fsSL https://raw.githubusercontent.com/shanecowherd/dotfiles/main/bootstrap.sh | bash
```

### Update Dotfiles
```bash
cd ~/dotfiles && git pull
```

### Update Claude User Preferences Only
```bash
~/dotfiles/update-claude.sh
```

### Update Claude Commands Only
```bash
~/dotfiles/update-claude-commands.sh
```

### Update Claude Agents Only
```bash
~/dotfiles/update-claude-agents.sh
```

### Update Tmux Configuration Only
```bash
~/dotfiles/update-tmux.sh
```

### Update Neovim Configuration Only
```bash
~/dotfiles/update-nvim.sh
```

### Update Lazygit Configuration Only
```bash
~/dotfiles/update-lazygit.sh
```


### Update SSH Configuration (after SSH keys are set up)
```bash
~/dotfiles/update-ssh.sh
```

### Export Terminfo to Remote Servers (optional)
```bash
~/dotfiles/export-ghostty-terminfo.sh user@host
```

### Directory Structure
```
claude-config/
├── CLAUDE.md     # Personal preferences for all projects
├── commands/     # Custom Claude Code slash commands
│   ├── change-terminal-to-blue.md
│   ├── change-terminal-to-green.md
│   ├── change-terminal-to-red.md
│   └── rules.md
└── agents/       # Specialized Claude agents
    ├── ios-architect-tdd.md
    ├── embedded-safety-engineer.md
    ├── react-native-performance-expert.md
    ├── senior-code-reviewer.md
    └── engineering-tech-lead.md

tmux-config/
└── tmux.conf     # Tmux configuration file

nvim-config/
└── init.lua      # Neovim configuration with Packer

lazygit-config/
├── default.yml      # Standard unified diff view
└── side-by-side.yml # Side-by-side diff view


ssh-config/
└── config          # SSH configuration for better terminal compatibility
```

## Architecture

This is a simple, single-script bootstrap repository. The bootstrap.sh script is self-contained and idempotent - it can be run multiple times safely. It checks for existing installations before attempting to install tools.

The script uses:
- Homebrew for package management on macOS
- NVM for Node.js version management
- npm for global Node.js packages (Claude Code, ccusage)

## Development Notes

- The bootstrap script sets shell options for safety: `set -eo pipefail`
- SSH key management is optional and interactive
- The script automatically switches the dotfiles remote to SSH if SSH keys are imported