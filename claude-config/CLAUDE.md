# CLAUDE.md - Personal Preferences

This file contains personal preferences and environment-specific prompts that apply across all projects.

## Development Environment

- I use macOS for development
- My primary terminal is Ghostty with tmux
- I prefer Neovim as my editor with vim keybindings
- I use Homebrew for package management

## Code Style Preferences

- Use 2-space indentation for JavaScript/TypeScript
- Use 4-space indentation for Python
- Prefer const over let in JavaScript/TypeScript
- Use descriptive variable names
- Keep functions small and focused
- Write self-documenting code with minimal comments

## Git Workflow

- I use lazygit for git operations
- Prefer conventional commits format: type(scope): description
- Keep commits atomic and focused
- Write meaningful commit messages

## Testing Preferences

- Write tests for critical functionality
- Use descriptive test names that explain what is being tested
- Prefer unit tests over integration tests when possible
- Run tests before committing changes

## General Preferences

- Explain complex logic when necessary
- Provide context for architectural decisions
- Use existing patterns in the codebase
- Check for existing utilities before creating new ones
- Validate assumptions by checking the codebase first

## Tool Usage

- Always use ripgrep (rg) instead of grep
- Use the Task tool for complex searches
- Batch multiple tool calls when possible
- Read files before editing them