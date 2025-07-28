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

## Agent Usage

- **Prioritize specialized agents** - Always use the appropriate specialized agent for domain-specific tasks to keep the main context focused and leverage expert knowledge
- **Use agents proactively** - Don't wait for explicit requests; invoke agents whenever their expertise is relevant
- **Delegate complex tasks** - For multi-step or complex domain-specific work, delegate to the appropriate agent rather than handling everything in the main context

### Available Agents and When to Use Them:

- **ios-architect-tdd** - For iOS/Swift development, architecture decisions, and mobile app best practices
- **embedded-safety-engineer** - For embedded systems, firmware, microcontroller code, and hardware programming
- **react-native-performance-expert** - For React Native development, performance optimization, and cross-platform mobile
- **senior-code-reviewer** - After writing any significant code, for security and quality review
- **engineering-tech-lead** - For complex multi-component features or architectural coordination

### Benefits of Agent Usage:

- Keeps main conversation context cleaner and more focused
- Provides domain-specific expertise without cluttering the main assistant's context
- Enables better parallel processing of complex tasks
- Ensures consistent application of best practices in specialized domains