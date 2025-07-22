Create a dark blue-themed VSCode workspace configuration to distinguish this project visually.

Execute this bash command:

```bash
mkdir -p .vscode && cat > .vscode/settings.json << 'EOF'
{
  "workbench.colorCustomizations": {
    "activityBar.background": "#1B4F72",
    "activityBar.foreground": "#FFFFFF",
    "titleBar.activeBackground": "#1B4F72",
    "titleBar.activeForeground": "#FFFFFF",
    "statusBar.background": "#1B4F72",
    "statusBar.foreground": "#FFFFFF",
    "sideBar.background": "#154360",
    "sideBar.foreground": "#FFFFFF",
    "editor.background": "#0E3A5F",
    "editor.foreground": "#FFFFFF",
    "editorCursor.foreground": "#5DADE2",
    "terminal.background": "#0E3A5F",
    "terminal.foreground": "#FFFFFF"
  }
}
EOF
```

This helps visually distinguish different workspaces when working with multiple VSCode windows.