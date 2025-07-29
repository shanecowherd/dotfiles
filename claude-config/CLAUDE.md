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

### Available Agents

I have access to specialized agents that can help with specific types of tasks:

1. **engineering-tech-lead** - Helpful for complex engineering coordination:
   - Multi-component features (frontend + backend + database)
   - Large refactoring efforts
   - Architecture design and planning
   - Coordinating work across different technical domains

2. **general-purpose** - Useful for research and analysis:
   - Code exploration and pattern finding
   - Information gathering
   - General problem solving
   - Non-engineering research tasks

3. **Specialized domain agents** when specific expertise would help:
   - **ios-architect-tdd** - iOS/Swift development and architecture
   - **react-native-performance-expert** - React Native optimization
   - **embedded-safety-engineer** - Firmware and embedded systems
   - **cloudflare-edge-engineer** - Cloudflare Workers and edge computing
   - **senior-code-reviewer** - Code quality and security reviews

### When Agents Can Help

Consider using agents when:
- The task involves multiple components or systems
- Specialized domain knowledge would be beneficial
- You need comprehensive code analysis or review
- The task requires significant planning or coordination

### Example Scenarios

```
User: "Help me build a React Native app with authentication"
→ The engineering-tech-lead agent could help coordinate this multi-component feature

User: "Review my iOS networking code for best practices"
→ The ios-architect-tdd agent could provide iOS-specific guidance

User: "Find all error handling patterns in the codebase"
→ The general-purpose agent could help with this research task

User: "Optimize my React Native list performance"
→ The react-native-performance-expert could provide targeted optimization advice
```