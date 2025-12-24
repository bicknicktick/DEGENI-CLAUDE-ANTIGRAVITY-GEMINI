# 🪟 DEGENI Windows Setup Guide

This guide explains how to use DEGENI natively on Windows **without WSL**.

## 🚀 Quick Start

### 1. Install Prerequisites

Make sure you have:
- **Node.js** (LTS version recommended) - [Download](https://nodejs.org/)
- **Claude Code CLI** - Install with: `npm install -g @anthropic-ai/claude-code`

### 2. Run Installation

Open PowerShell and run:

```powershell
cd "D:\Vibe Coding\DEGENI-CLAUDE-ANTIGRAVITY-GEMINI"
.\install-windows.ps1
```

This will:
- ✅ Download `cli-proxy-api.exe` (the proxy server)
- ✅ Add the `bin/` folder to your PATH
- ✅ Show next steps

### 3. Authenticate with Google AI

Run the proxy once to authenticate:

```powershell
.\bin\cli-proxy-api.exe
```

- A browser window will open
- Login with your Google account
- Authorize the app
- Close the terminal after authentication is complete

### 4. Start Using Claude!

```powershell
# From ANY folder:
claude                    # Interactive mode
claude "explain docker"   # Quick question
```

That's it! 🎉

---

### Enhanced Management with `degeni`

You can now use the `degeni` command for a full interactive experience:

```powershell
degeni                    # Opens main menu (Status, Chat, Accounts)
degeni chat               # Starts chat mode
degeni model              # Switch default model easily
degeni status             # Check system status
```

### Claude Commands

| Command | Description |
|---------|-------------|
| `claude` | Start interactive Claude session |
| `claude "question"` | Ask a quick question |
| `degeni` | Open DEGENI management menu |

### Proxy Management

| Command | Description |
|---------|-------------|
| `degeni restart` | Restart proxy server and clear errors |
| `.\bin\start-proxy.ps1` | Start proxy in background (manual) |
| `.\bin\stop-proxy.ps1` | Stop proxy (manual) |

---

## 🤖 Available Models

| Model | Best For |
|-------|----------|
| `gemini-claude-sonnet-4-5-thinking` ⭐ | Coding, debugging (default) |
| `gemini-claude-opus-4-5-thinking` 💎 | Complex reasoning |
| `gemini-2.5-flash` ⚡ | Fast responses |
| `gemini-2.5-pro` 🎯 | Balanced |

### Change Default Model

The easiest way is to use:
```powershell
degeni model
```

Or set environment variable:

```powershell
$env:DEGENI_DEFAULT_MODEL = "gemini-claude-opus-4-5-thinking"
```

Or add to your PowerShell profile for persistence.

---

## 🔧 Troubleshooting

### "claude" command not found

**Cause**: PATH not updated or terminal not restarted

**Fix**:
1. Close and reopen your terminal
2. Or add to PATH manually:
   ```powershell
   $env:Path += ";D:\Vibe Coding\DEGENI-CLAUDE-ANTIGRAVITY-GEMINI\bin"
   ```

### Proxy not starting

**Cause**: Port 8317 in use or firewall blocking

**Fix**:
1. Check what's using the port:
   ```powershell
   netstat -ano | findstr :8317
   ```
2. Kill the process or change port in config

### Authentication issues

**Cause**: Need to re-authenticate with Google

**Fix**:
1. Stop proxy: `.\bin\stop-proxy.ps1`
2. Delete credentials: `Remove-Item ~/.cli-proxy-api -Recurse -Force`
3. Re-run: `.\bin\cli-proxy-api.exe`
4. Complete authentication in browser

### Windows Defender blocks exe

**Cause**: Downloaded executable flagged

**Fix**:
1. Right-click `cli-proxy-api.exe`
2. Properties → Unblock → Apply
3. Or add exclusion in Windows Security

---

## 📁 File Structure

```
DEGENI-CLAUDE-ANTIGRAVITY-GEMINI/
├── bin/
│   ├── claude.ps1          # Main launcher (PowerShell)
│   ├── claude.cmd          # CMD wrapper
│   ├── cli-proxy-api.exe   # Proxy server
│   ├── start-proxy.ps1     # Start proxy
│   ├── stop-proxy.ps1      # Stop proxy
│   └── proxy-status.ps1    # Check status
├── install-windows.ps1     # Installation script
├── uninstall-windows.ps1   # Uninstallation script
└── WINDOWS-SETUP.md        # This file
```

---

## 🔄 Migrating from WSL

If you were using DEGENI with WSL before:

### Option 1: Use Windows native (recommended)
Just follow this guide. Your WSL setup will still work if you need it.

### Option 2: Share credentials
Credentials are stored in `~/.cli-proxy-api/`. You can:
1. Copy from WSL: `cp -r ~/.cli-proxy-api /mnt/c/Users/YourName/`
2. Or just re-authenticate on Windows

---

## ❓ FAQ

### Q: Do I still need WSL?
**A**: No! The proxy now runs natively on Windows. WSL is optional.

### Q: Is this faster than WSL?
**A**: Yes, slightly. No WSL overhead means faster startup.

### Q: Can I use both WSL and Windows?
**A**: Yes, but run only one proxy at a time (they use the same port).

### Q: How do I update CLIProxyAPI?
**A**: Re-run `install-windows.ps1` or download manually from [releases](https://github.com/router-for-me/CLIProxyAPI/releases).

---

## 🆘 Getting Help

- **Issues**: [GitHub Issues](https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI/issues)
- **CLIProxyAPI Docs**: [help.router-for.me](https://help.router-for.me/)
- **Discord**: (if available)

---

**Happy coding with Claude! 🚀✨**
