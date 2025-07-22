Create a dark green-themed VSCode workspace configuration to distinguish this project visually.

Execute this bash command:

```bash
mkdir -p .vscode && cat > .vscode/settings.json << 'EOF'
{
  "workbench.colorCustomizations": {
    "activityBar.background": "#0B5345",
    "activityBar.foreground": "#FFFFFF",
    "titleBar.activeBackground": "#0B5345",
    "titleBar.activeForeground": "#FFFFFF",
    "statusBar.background": "#0B5345",
    "statusBar.foreground": "#FFFFFF",
    "sideBar.background": "#0E6655",
    "sideBar.foreground": "#FFFFFF",
    "editor.background": "#073A2F",
    "editor.foreground": "#FFFFFF",
    "editorCursor.foreground": "#58D68D",
    "terminal.background": "#073A2F",
    "terminal.foreground": "#FFFFFF"
  }
}
EOF
```

This helps visually distinguish different workspaces when working with multiple VSCode windows.