# Project Context

## Purpose
**DEGENI** (by BITZY.ID) is a CLI wrapper tool that enables users to run **Claude Code** (Anthropic's official CLI) using **Gemini Claude models** via the **Antigravity proxy**. 

### Core Goals:
- 🔗 Connect Claude Code CLI to custom model endpoints
- 🤖 Access Claude Sonnet 4.5 & Opus 4.5 via Gemini API
- 📊 Provide real-time dashboard for monitoring and management
- 💾 Support session management for saving/restoring conversations
- ⚡ Enable quick command access without entering full chat mode

### How It Works:
```
User → DEGENI CLI → Claude Code CLI → Local Proxy (8317) → Antigravity API → Gemini Claude Models
```

## Tech Stack

### Core Technologies
- **Bash/Shell Scripts** - Main CLI tools and automation
- **Node.js** - Runtime environment for Claude CLI
- **HTML/CSS/JavaScript** - Dashboard UI (no frameworks, vanilla)
- **PowerShell** - Windows configuration scripts

### CLI Components
| Component | Purpose |
|-----------|---------|
| `degeni` | Main CLI tool (21KB bash script) |
| `ai` | Claude Code wrapper |
| `degeni-api` | Backend API server for dashboard |
| `degeni-session` | Session management |

### External Dependencies
- **Claude Code CLI** - Official Anthropic CLI for terminal AI
- **CLIProxyAPI** - Local proxy server (localhost:8317)
- **Antigravity** - Third-party service for Gemini Claude models

### Available Models
| Model ID | Description |
|----------|-------------|
| `gemini-claude-sonnet-4-5-thinking` ⭐ | Claude Sonnet 4.5 via Gemini (best for coding) |
| `gemini-claude-opus-4-5-thinking` | Claude Opus 4.5 via Gemini (best for reasoning) |
| `gemini-2.5-pro` | Gemini 2.5 Pro (native) |
| `gemini-2.5-flash` | Gemini 2.5 Flash (fast) |

## Project Conventions

### Code Style
- **Shell Scripts**: Follow standard Bash conventions
- **Environment Variables**: Stored in `.env` file
- **File Naming**: Lowercase with hyphens (kebab-case)
- **Documentation**: Markdown files with emoji-enhanced formatting

### Architecture Patterns
```
~/DEGENI/
├── install.sh           # One-shot installer
├── start-dashboard.sh   # Dashboard launcher
├── bin/                 # CLI executables
│   ├── degeni           # Main CLI tool
│   ├── ai               # Claude Code wrapper
│   ├── degeni-api       # Backend API server
│   └── degeni-session   # Session manager
├── ui/                  # Web dashboard
│   ├── dashboard.html   # Live dashboard (single-page)
│   └── favicon.svg      # Dashboard icon
├── sessions/            # Saved chat sessions (JSON)
├── logs/                # Log files
└── config/              # Configuration files
```

### API Endpoints
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/status` | GET | Server status + account count |
| `/api/accounts` | GET | List all accounts |
| `/api/models` | GET | Available models |
| `/api/logs` | GET | Recent logs |
| `/api/config` | GET | Current model config |
| `/api/restart` | POST | Restart proxy server |
| `/api/test` | POST | Test API connection |
| `/api/account/toggle` | POST | Enable/disable account |
| `/api/model/switch` | POST | Switch AI model |

### Testing Strategy
- Test accounts with `degeni test`
- Diagnose issues with `degeni diagnose` (includes auto-fix)
- Manual verification via dashboard at `http://localhost:8080/dashboard.html`

### Git Workflow
- **Branching**: Standard feature branch workflow
- **Line Endings**: Unix-style (LF) - `.gitattributes` configured
- **Ignored Files**: 
  - Logs (`*.log`)
  - Sessions (`sessions/*.json`)
  - Environment files (`.env`, `.env.local`)
  - Distribution files (`*.tar.gz`, `*.zip`)

## Domain Context

### Key Concepts
- **Antigravity Proxy**: A service that provides access to Claude models through Gemini API endpoints
- **CLIProxyAPI**: Local proxy server running on port 8317 that redirects Claude Code requests
- **Multi-Account**: Load balancing across multiple Google AI accounts
- **Session**: Saved conversation history in JSON format

### Ports Used
| Port | Service |
|------|---------|
| 8317 | CLIProxyAPI (local proxy) |
| 8321 | DEGENI API server |
| 8080 | Dashboard web server |

## Important Constraints

### Legal & ToS Considerations
- ⚠️ **Educational/Personal Use Only** - Not for production or commercial use
- ⚠️ Using API via proxy may violate Google AI Terms of Service
- ⚠️ Redirecting Claude Code to custom endpoints may violate Anthropic ToS
- ⚠️ Antigravity is an unofficial third-party service

### Potential Risks
- Account suspension (Google AI account may be banned)
- Service termination (Antigravity may shut down without notice)
- Rate limiting (accounts may be permanently limited)
- No warranty - provided "AS IS"

### Platform Requirements
- ✅ Linux (Ubuntu/Debian) or macOS
- ✅ WSL for Windows users
- ✅ Google AI account (free tier works)
- ✅ Internet connection

## External Dependencies

### Required Services
| Service | URL | Purpose |
|---------|-----|---------|
| **Antigravity API** | (third-party) | Gemini Claude model access |
| **Google AI** | ai.google.com | Account authentication |
| **NPM Registry** | npmjs.com | Node.js packages |

### Auto-Installed by Installer
- Node.js
- Claude CLI (official @anthropic-ai/claude-code)
- CLIProxyAPI
- Antigravity support files

### Credential Storage
- All credentials stored in `~/.cli-proxy-api/`
- All traffic localhost only (ports 8317, 8321, 8080)
- No third-party data sharing from local instance
