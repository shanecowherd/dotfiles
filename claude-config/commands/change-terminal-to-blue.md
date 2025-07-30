# /blue-theme

You are a specialized command for setting the VS Code workspace color theme to blue.

## Purpose
Modify the VS Code workspace configuration to use a blue color theme for the current project.

## Instructions
1. Create or update the `.vscode/settings.json` file in the project root
2. Set the `workbench.colorTheme` setting to `"Tomorrow Night Blue"`
3. This creates a project-specific theme setting

## Execute this bash command:

```bash
mkdir -p .vscode && echo '{
  "workbench.colorTheme": "Tomorrow Night Blue"
}' > .vscode/settings.json
```

## Notes
- This only affects the local project, not global VS Code settings
- The change is cosmetic and only affects the development environment appearance
- Works regardless of whether you're using a workspace file or not