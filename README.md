<p align="center">
  <img src="https://img.shields.io/badge/DEGENI-v1.0.0-06b6d4?style=for-the-badge" alt="DEGENI">
  <img src="https://img.shields.io/badge/by-BITZY.ID-10b981?style=for-the-badge" alt="BITZY.ID">
  <img src="https://img.shields.io/badge/Claude%20Code-Wrapper-8b5cf6?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/Gemini%20Claude-Proxy-f59e0b?style=for-the-badge" alt="Gemini Claude">
</p>

```
  ██████╗ ███████╗ ██████╗ ███████╗███╗   ██╗██╗
  ██╔══██╗██╔════╝██╔════╝ ██╔════╝████╗  ██║██║
  ██║  ██║█████╗  ██║  ███╗█████╗  ██╔██╗ ██║██║
  ██║  ██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║
  ██████╔╝███████╗╚██████╔╝███████╗██║ ╚████║██║
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝

    Claude Code Terminal Wrapper
            by BITZY.ID
```

<p align="center">
  <strong>🚀 Run Claude Code using Gemini Claude models via Antigravity proxy!</strong>
</p>

---

## ⚠️ DISCLAIMER

**IMPORTANT - READ BEFORE USE:**

This tool is provided **for educational and personal use only**. By using DEGENI, you acknowledge and accept the following:

### Legal & ToS Considerations:

| Aspect | Status | Notes |
|--------|--------|-------|
| **Criminal Law** | ✅ Legal | No hacking or unauthorized access |
| **Google AI ToS** | ⚠️ **Gray Area** | Using API via proxy may violate Terms of Service |
| **Anthropic ToS** | ⚠️ **Gray Area** | Redirecting Claude Code to custom endpoints may violate ToS |
| **Antigravity Service** | ⚠️ **Unofficial** | Third-party service, not endorsed by Google or Anthropic |

### Potential Risks:

- 🚫 **Account Suspension** - Your Google AI account may be suspended or banned
- 🚫 **Service Termination** - Antigravity service may shut down without notice
- 🚫 **Rate Limiting** - Accounts may be permanently rate-limited
- 🚫 **Data Loss** - Sessions and configurations may be lost at any time
- 🚫 **No Warranty** - Tool provided "AS IS" without any guarantees

### Recommendations:

- ✅ **Personal Use Only** - Do NOT use for production or commercial purposes
- ✅ **Educational Purposes** - Treat as a learning/experimental project
- ✅ **Backup Plans** - Have alternative solutions ready
- ✅ **Read Official ToS** - Review Google AI and Anthropic Terms of Service
- ✅ **Consider Official Services** - For reliable access, consider [Claude Pro](https://claude.ai/pro) ($20/month)

**USE AT YOUR OWN RISK. The developers are not responsible for any account suspensions, service disruptions, or ToS violations.**

---

## ✨ What is DEGENI?

**DEGENI** adalah CLI wrapper tool yang memungkinkan Anda menjalankan **Claude Code** (official CLI dari Anthropic) menggunakan **Gemini Claude models** melalui **Antigravity proxy**.

### Cara Kerja:
```
You → DEGENI CLI → Claude Code CLI → Local Proxy → Antigravity API → Gemini Claude Models
```

### Features:
- 🤖 **Claude Code Integration** - Run Claude Code CLI with custom models
- 🌟 **Gemini Claude Models** - Access Claude Sonnet 4.5 & Opus 4.5 via Gemini
- 🔄 **Multi-Account Support** - Load balance multiple Google AI accounts
- 💬 **Interactive Chat** - Full Claude Code terminal experience
- 📊 **Live Dashboard** - Monitor accounts, models, and proxy status
- 💾 **Session Management** - Save and restore chat sessions
- ⚡ **Quick Commands** - Fast access to AI without full chat mode

---

## 🧩 Architecture

**DEGENI** terdiri dari beberapa komponen:

| Component | Purpose |
|-----------|---------|
| **Claude Code CLI** | Official Anthropic CLI for terminal AI |
| **CLIProxyAPI** | Local proxy server (localhost:8317) |
| **Antigravity** | Service provider for Gemini Claude models |
| **DEGENI Wrapper** | Management CLI + Dashboard UI |

### Available Models:

| Model ID | Description |
|----------|-------------|
| `gemini-claude-sonnet-4-5-thinking` ⭐ | Claude Sonnet 4.5 via Gemini (best for coding) |
| `gemini-claude-opus-4-5-thinking` | Claude Opus 4.5 via Gemini (best for reasoning) |
| `gemini-claude-sonnet-4-5` | Claude Sonnet 4.5 via Gemini (general tasks) |
| `gemini-3-pro-preview` | Gemini 3 Pro (native) |
| `gemini-2.5-pro` | Gemini 2.5 Pro (native) |
| `gemini-2.5-flash` | Gemini 2.5 Flash (fast) |

---

## 🚀 Quick Start

### Method 1: Install from GitHub (Recommended)

```bash
# 1. Clone repository
git clone https://github.com/bicknicktick/AVSTUDIO-USER.git
cd AVSTUDIO-USER

# 2. Run installer
bash install.sh
```

### Method 2: Install from Archive

```bash
# 1. Extract & run installer
tar -xzf DEGENI-by-BITZY.tar.gz
cd DEGENI
bash install.sh
```

### After Installation (Both Methods)

```bash
# 1. Reload shell (REQUIRED - only once)
source ~/.bashrc

# 2. Add Google AI account (REQUIRED - needs browser)
degeni add
# → Choose [1] Antigravity (for Claude wrappers)
# → Open the URL shown in your browser
# → Login with your Google account
# → Authorize the app
# → Copy the callback URL from browser
# → Paste it in terminal

# 3. Done! Start using Claude Code
degeni "hello world"
```

### ⚠️ Important Notes

| Step | Auto/Manual | Keterangan |
|------|-------------|------------|
| Install dependencies | ✅ Auto | Node.js, Claude CLI, CLIProxyAPI |
| Copy DEGENI files | ✅ Auto | CLI tools, dashboard |
| Start proxy server | ✅ Auto | Background service |
| Reload shell | ⚡ Manual | `source ~/.bashrc` (once) |
| Add Google account | ⚡ Manual | `degeni add` (needs browser) |

**Setelah setup awal, tinggal pakai `degeni` langsung!**

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| 🔧 **Claude Code Wrapper** | Run official Claude CLI with custom endpoints |
| 🤖 **Multi-Model** | Switch between Claude & Gemini models |
| 💬 **Interactive Chat** | Full terminal chat experience via Claude Code |
| ⚡ **Quick Ask** | One-liner questions without chat mode |
| 🔄 **Auto-Balance** | Load balance across multiple accounts |
| 📊 **Live Dashboard** | Real-time monitoring & management |
| 🎛️ **1-Click Actions** | Switch models, toggle accounts via UI |
| 💾 **Session Support** | Save & restore conversation history |
| 📦 **Portable** | All-in-one installer, easy setup |

---

## 💻 Commands

### AI Chat

```bash
# Quick question
degeni "explain docker in 3 sentences"

# Interactive chat mode (full Claude Code experience)
degeni chat
```

### Account Management

```bash
degeni              # Interactive menu
degeni list         # List accounts
degeni add          # Add new account
degeni disable      # Disable account
degeni enable       # Enable account
degeni restart      # Restart proxy & unsuspend
degeni test         # Test accounts
```

### Model & System

```bash
degeni model        # Switch AI model
degeni status       # System status
degeni diagnose     # 🔍 Diagnose problems + auto-fix
degeni fix          # Same as diagnose
degeni dash         # Open live dashboard
```

---

## 🌐 Live Dashboard

Real-time dashboard untuk management dan monitoring.

```bash
# Start dashboard
~/DEGENI/start-dashboard.sh

# Open in browser
# http://localhost:8080/dashboard.html
```

### Dashboard Features

| Feature | Action | Status |
|---------|--------|--------|
| **Server Status** | Auto-refresh | ✅ LIVE |
| **Account List** | Click to toggle | ✅ LIVE |
| **Switch Model** | Click to switch | ✅ LIVE |
| **Restart Proxy** | Click button | ✅ LIVE |
| **Test Connection** | Click button | ✅ LIVE |
| **System Logs** | Auto-refresh 5s | ✅ LIVE |

**Semua aksi tinggal KLIK - langsung execute!**

---

## 📁 Folder Structure

```
~/DEGENI/
├── install.sh           # One-shot installer
├── start-dashboard.sh   # Start live dashboard
├── bin/
│   ├── degeni           # Main CLI tool
│   ├── ai               # Claude Code wrapper
│   ├── degeni-api       # Backend API server
│   └── degeni-session   # Session manager
├── ui/
│   ├── dashboard.html   # Live dashboard
│   └── favicon.svg      # Dashboard icon
├── sessions/            # Saved chat sessions (JSON)
├── config/
├── logs/
└── README.md
```

---

## 🔧 API Endpoints

Dashboard menggunakan backend API untuk real-time data:

| Endpoint | Method | Fungsi |
|----------|--------|--------|
| `/api/status` | GET | Server status + account count |
| `/api/accounts` | GET | List all accounts |
| `/api/models` | GET | Available models |
| `/api/logs` | GET | Recent logs |
| `/api/config` | GET | Current model config |
| `/api/restart` | POST | Restart proxy server |
| `/api/test` | POST | Test API connection |
| `/api/account/toggle` | POST | Enable/disable account |
| `/api/model/switch` | POST | Switch AI model |

**API Server:** `http://localhost:8321`

---

## 🔧 Troubleshooting

### Common Issues & Quick Fixes

| Issue | Quick Fix |
|-------|-----------|
| **Test API Failed** | `degeni restart` |
| **auth_unavailable** | `degeni restart` |
| **payment_required** | `degeni model` → select free model |
| **Dashboard not loading** | `~/DEGENI/start-dashboard.sh` |
| **Proxy not responding** | `degeni diagnose` |
| **Termux permissions** | `bash fix-termux.sh` |

### Error: `$'\r': command not found` (Line Ending Issue)

**Cause:** Windows-style line endings (CRLF) instead of Unix-style (LF).

**Quick Fix:**
```bash
# Option 1: Using dos2unix
sudo apt-get install dos2unix  # or: brew install dos2unix
dos2unix install.sh
bash install.sh

# Option 2: Using sed
sed -i 's/\r$//' install.sh
bash install.sh

# Option 3: Re-clone with correct settings
git config --global core.autocrlf false
git clone https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI.git
```

**For more details, see:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 📋 Requirements

- ✅ Linux (Ubuntu/Debian) atau macOS
- ✅ Google AI account (free tier works)
- ✅ Internet connection

**Auto-installed by installer:**
- Node.js
- Claude CLI (official)
- CLIProxyAPI
- Antigravity support

---

## 🔐 Security

- 🔒 All traffic localhost only (port 8317, 8321, 8080)
- 🔒 Credentials stored in `~/.cli-proxy-api/`
- 🔒 No third-party data sharing
- 🔒 Open source & auditable

---

## 🤔 FAQ

### Q: Is this free Gemini AI access?
**A:** No. DEGENI is a **wrapper tool** that runs Claude Code CLI using Gemini Claude models via Antigravity proxy. You need a Google AI account to use it.

### Q: What is Antigravity?
**A:** Antigravity is a service that provides access to Claude models through Gemini API endpoints.

### Q: Do I need a Claude API key?
**A:** No. DEGENI uses local proxy + Google AI account instead of direct Claude API.

### Q: Can I use this for free?
**A:** Yes, if you use free Google AI quota. Some models may require paid quota.

---

## 📞 Support

- 🌐 Website: [bitzy.id](https://bitzy.id)
- 📧 Email: support@bitzy.id
- 💬 Issues: [GitHub Issues](https://github.com/bicknicktick/AVSTUDIO-USER/issues)

---

## ☕ Donate

Jika DEGENI bermanfaat, dukung pengembangan dengan donasi:

<p align="center">
  <a href="https://paypal.me/bitzyid">
    <img src="https://img.shields.io/badge/PayPal-Donate-00457C?style=for-the-badge&logo=paypal&logoColor=white" alt="Donate via PayPal">
  </a>
</p>

<p align="center">
  <strong>paypal.me/bitzyid</strong>
</p>

---

<p align="center">
  <strong>DEGENI v1.0.0</strong><br>
  <sub>Claude Code Terminal Wrapper</sub><br>
  <sub>by <a href="https://bitzy.id">BITZY.ID</a></sub>
</p>

<p align="center">
  <sub>Made with ❤️ in Indonesia</sub>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Claude%20Code-Official%20CLI-8b5cf6?style=flat-square" alt="Claude Code">
  <img src="https://img.shields.io/badge/Gemini%20Claude-Proxy-f59e0b?style=flat-square" alt="Gemini Claude">
  <img src="https://img.shields.io/badge/Live-Dashboard-06b6d4?style=flat-square" alt="Live">
  <img src="https://img.shields.io/badge/Made%20in-Indonesia-ef4444?style=flat-square" alt="Indonesia">
</p>
