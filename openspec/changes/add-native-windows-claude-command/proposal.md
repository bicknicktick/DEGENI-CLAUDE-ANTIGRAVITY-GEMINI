# Change: Add Native Windows Claude Command

## Why

Currently, users on Windows must:
1. Open WSL terminal
2. Run `degeni` command
3. Select option `1` to start Claude Code

This workflow is inconvenient and creates friction. Users want to simply type `claude` in Windows Terminal (PowerShell/CMD) and have it work directly with the Antigravity proxy - **no WSL required**.

## What Changes

### Core Changes
- **ADDED**: PowerShell script (`claude.ps1`) that configures environment and launches Claude Code with proxy settings
- **ADDED**: Batch file (`claude.cmd`) as a simple wrapper for CMD users
- **ADDED**: Installation script to add `claude` command to Windows PATH
- **ADDED**: Native Windows CLIProxyAPI (`cli-proxy-api.exe`) from [official releases](https://github.com/router-for-me/CLIProxyAPI/releases)
- **ADDED**: Auto-start proxy as Windows background process (no WSL needed!)

### Discovery: CLIProxyAPI supports Windows natively!
- Latest version: `v6.6.39` (released 2025-12-21)
- Windows binary: `CLIProxyAPI_6.6.39_windows_amd64.zip`
- Also available: [EasyCLI](https://github.com/router-for-me/EasyCLI) - Desktop GUI with system tray

## Impact

- **Affected specs**: `windows-cli` (new capability)
- **Affected code**: 
  - New files: `bin/claude.ps1`, `bin/claude.cmd`, `bin/cli-proxy-api.exe`
  - New: `install-windows.ps1`
  - Modified: Documentation
- **WSL Dependency**: ❌ **REMOVED** - No longer needed for basic usage!
- **User Experience**: 
  - ✅ Type `claude` in any Windows terminal → works immediately
  - ✅ Automatically connected to Antigravity proxy
  - ✅ Proxy runs as native Windows process

## Success Criteria

1. User can open PowerShell/CMD anywhere and type `claude`
2. Claude Code starts with correct proxy configuration
3. If proxy isn't running, it starts automatically (native Windows, not WSL!)
4. Works with all existing models (Sonnet 4.5, Opus 4.5, etc.)
5. Zero WSL dependency for normal usage
