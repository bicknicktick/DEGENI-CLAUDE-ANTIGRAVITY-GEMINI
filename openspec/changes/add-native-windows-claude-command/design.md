# Design: Native Windows Claude Command

## Context

Users on Windows currently need to:
1. Open WSL terminal
2. Navigate to DEGENI directory
3. Run `degeni` command
4. Select option 1 (chat)
5. Then Claude Code starts

This multi-step process is friction-heavy. The goal is to enable:
```powershell
PS C:\any\folder> claude
# Claude Code starts immediately with proxy connected
```

## Key Discovery 🔥

**CLIProxyAPI runs natively on Windows!**
- Official Windows binary available: `CLIProxyAPI_x.x.x_windows_amd64.zip`
- No WSL dependency at all
- Latest version: v6.6.39 (December 21, 2025)
- Source: https://github.com/router-for-me/CLIProxyAPI/releases

This changes everything - we can have a **100% native Windows solution**!

## Goals / Non-Goals

### Goals
- ✅ Single `claude` command works from any Windows terminal
- ✅ Automatically configure proxy connection
- ✅ Auto-start proxy if not running (**native Windows, not WSL**)
- ✅ Support all existing Claude/Gemini models
- ✅ Pass-through all Claude CLI arguments
- ✅ **Zero WSL dependency**

### Non-Goals
- ❌ Modify CLIProxyAPI source code
- ❌ Change Claude Code CLI internals
- ❌ Build our own proxy

## Decisions

### Decision 1: Native Windows CLIProxyAPI
**What**: Download and use official Windows binary `cli-proxy-api.exe`
**Why**: 
- Officially supported by CLIProxyAPI project
- No WSL overhead
- Can run as Windows background process
- Simpler architecture

### Decision 2: PowerShell as Primary, CMD as Wrapper
**What**: Use PowerShell script (`claude.ps1`) as main implementation, with CMD batch file wrapper.
**Why**: 
- PowerShell has better environment variable handling
- PowerShell can check process status and start background jobs
- CMD wrapper ensures compatibility with older workflows

### Decision 3: Environment Variables for Configuration
**What**: Configure Claude via environment variables:
```powershell
$env:ANTHROPIC_BASE_URL = "http://localhost:8317"
$env:ANTHROPIC_MODEL = "gemini-claude-sonnet-4-5-thinking"
```
**Why**: This is how Claude Code CLI reads custom endpoints - no code changes needed in Claude itself.

### Decision 4: Health Check Before Launch
**What**: Check if proxy is responding before launching Claude Code.
**Why**: Better error messages if proxy isn't running, and opportunity to auto-start.

### Decision 5: Proxy as Background Process
**What**: Start `cli-proxy-api.exe` as a hidden background process when needed.
**Why**:
- No console window clutter
- Stays running between Claude sessions
- Can be managed via Task Manager if needed

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    WINDOWS (PowerShell/CMD)                  │
├─────────────────────────────────────────────────────────────┤
│  claude.cmd ──► claude.ps1                                   │
│                    │                                         │
│                    ▼                                         │
│              Set ENV vars:                                   │
│              - ANTHROPIC_BASE_URL=http://localhost:8317     │
│              - ANTHROPIC_MODEL=gemini-claude-sonnet-4-5...  │
│                    │                                         │
│                    ▼                                         │
│              Check proxy health (localhost:8317)            │
│                    │                                         │
│         ┌─────────┴─────────┐                               │
│         ▼                   ▼                               │
│    [Proxy OK]         [Proxy Down]                          │
│         │                   │                               │
│         │                   ▼                               │
│         │            Start cli-proxy-api.exe                │
│         │            (background process)                   │
│         │                   │                               │
│         └─────────┬─────────┘                               │
│                   ▼                                         │
│            Launch: claude $args                             │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              cli-proxy-api.exe (localhost:8317)              │
├─────────────────────────────────────────────────────────────┤
│  - Runs as Windows background process                       │
│  - Stores credentials in ~/.cli-proxy-api/                  │
│  - Connects to Antigravity API                              │
│  - Routes Claude Code requests → Gemini Claude models       │
└─────────────────────────────────────────────────────────────┘
```

## Risks / Trade-offs

| Risk | Impact | Mitigation |
|------|--------|------------|
| Node.js not in Windows PATH | Claude CLI won't work | Check during install, guide user |
| Proxy takes time to start | Users wait or get errors | Add startup timeout with progress indicator |
| Windows Defender blocks exe | Proxy won't start | Document exclusion steps |
| Auth credentials not migrated | Need to re-login | Document migration from WSL or use shared path |

## File Structure

```
bin/
├── claude.ps1           # Main PowerShell script (NEW)
├── claude.cmd           # CMD wrapper (NEW)
├── cli-proxy-api.exe    # Native Windows proxy (NEW, from releases)
├── start-proxy.ps1      # Proxy management (NEW)
├── degeni               # Existing bash CLI (WSL)
├── ai                   # Existing Claude wrapper (WSL)
├── degeni-api           # Existing API server (WSL)
└── degeni-session       # Existing session manager (WSL)

install-windows.ps1      # Windows installation script (NEW)
```

## Installation Flow

```
1. Run install-windows.ps1
   ├── Download cli-proxy-api.exe from GitHub releases
   ├── Copy to bin/ folder
   ├── Add bin/ to user PATH
   └── Show instructions for authentication

2. User runs: cli-proxy-api.exe
   └── Opens browser for OAuth with Google AI

3. After auth, user can run: claude
   └── Everything works!
```

## Open Questions

1. ✅ ~~Should we support running without WSL at all?~~ **YES! CLIProxyAPI has Windows native binary**
2. Should we create a Windows service for the proxy instead of background process?
3. Do we need a tray icon for proxy status? (EasyCLI exists for this)
4. Should we bundle EasyCLI instead of raw executable?
