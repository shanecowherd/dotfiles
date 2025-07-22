Create a red-themed VSCode workspace configuration to distinguish this project visually.

Execute this bash command:

```bash
mkdir -p .vscode && cat > .vscode/settings.json << 'EOF'
{
  "workbench.colorCustomizations": {
    "activityBar.background": "#8B0000",
    "activityBar.foreground": "#FFFFFF",
    "titleBar.activeBackground": "#8B0000",
    "titleBar.activeForeground": "#FFFFFF",
    "statusBar.background": "#8B0000",
    "statusBar.foreground": "#FFFFFF",
    "sideBar.background": "#2D0000",
    "sideBar.foreground": "#FFFFFF",
    "editor.background": "#1A0000",
    "editor.foreground": "#FFFFFF",
    "editorCursor.foreground": "#FF0000",
    "terminal.background": "#1A0000",
    "terminal.foreground": "#FFFFFF"
  }
}
EOF
```

This helps visually distinguish different workspaces when working with multiple VSCode windows.