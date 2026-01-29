<p align="center">
  <img src="https://img.shields.io/badge/DEGENI-v1.0.0-06b6d4?style=for-the-badge" alt="DEGENI">
  <img src="https://img.shields.io/badge/by-BITZY.ID-10b981?style=for-the-badge" alt="BITZY.ID">
  <img src="https://img.shields.io/badge/Claude-Sonnet%204.5-8b5cf6?style=for-the-badge" alt="Claude">
  <img src="https://img.shields.io/badge/Gemini-3%20Pro-f59e0b?style=for-the-badge" alt="Gemini">
</p>

```
  ██████╗ ███████╗ ██████╗ ███████╗███╗   ██╗██╗
  ██╔══██╗██╔════╝██╔════╝ ██╔════╝████╗  ██║██║
  ██║  ██║█████╗  ██║  ███╗█████╗  ██╔██╗ ██║██║
  ██║  ██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║
  ██████╔╝███████╗╚██████╔╝███████╗██║ ╚████║██║
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝
         
       Claude + Gemini AI Terminal
            by BITZY.ID
```

<p align="center">
  <strong>🚀 Access Claude Sonnet 4.5 & Gemini 3 Pro FREE in your terminal!</strong>
</p>

---

## ✨ What is DEGENI?

**DEGENI** adalah AI terminal tool yang memberikan akses **GRATIS** ke:

- 🤖 **Claude Sonnet 4.5 Thinking** - Model AI terbaik untuk coding
- 🌟 **Claude Opus 4.5 Thinking** - Model reasoning terkuat
- 💎 **Gemini 3 Pro** - Model terbaru dari Google
- ⚡ **Gemini 2.5 Flash** - Model super cepat

**Tanpa biaya langganan!** Hemat $240-360/tahun dibanding Claude Pro.

---

## 🚀 Quick Start

### Install di PC/VPS Baru

```bash
# 1. Extract & run installer
tar -xzf DEGENI-by-BITZY.tar.gz
cd DEGENI
bash install.sh

# 2. Reload shell (REQUIRED)
source ~/.bashrc

# 3. Add Google AI account (REQUIRED - needs browser)
degeni add
# → Pilih [1] Antigravity
# → Buka URL yang muncul di browser
# → Login dengan akun Google
# → Authorize, lalu copy callback URL
# → Paste di terminal

# 4. Done! Start chatting
degeni "hello world"
```

### ⚠️ Important Notes

| Step | Auto/Manual | Keterangan |
|------|-------------|------------|
| Install dependencies | ✅ Auto | Node.js, Claude CLI, CLIProxyAPI |
| Copy DEGENI files | ✅ Auto | CLI tools, dashboard, sessions |
| Start proxy server | ✅ Auto | Background service |
| Reload shell | ⚡ Manual | `source ~/.bashrc` (sekali) |
| Add Google account | ⚡ Manual | `degeni add` (butuh browser) |

**Setelah setup awal, tinggal pakai `degeni` langsung!**

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| 🆓 **100% Free** | Gunakan Google AI Pro (gratis) |
| 🤖 **Multi-Model** | Claude + Gemini dalam satu tool |
| 💬 **Chat Mode** | Interactive seperti ChatGPT |
| ⚡ **Quick Ask** | Tanya cepat tanpa masuk chat |
| 💾 **Sessions** | Save & load chat history with timestamps |
| 🔄 **Auto-Balance** | Load balance multiple akun |
| 📊 **Live Dashboard** | Web UI real-time monitoring |
| 🎛️ **1-Click Actions** | Switch model, toggle account |
| 📦 **Portable** | Install sekali, pakai selamanya |

---

## 💻 Commands

### AI Chat

```bash
# Quick question
degeni "jelaskan docker dalam 3 kalimat"

# Interactive chat mode
degeni chat
```

### Session Commands (NEW!)

```bash
# In chat mode, use these commands:
/sessions        # List all saved sessions
/new [name]      # Start new session
/load <number>   # Load session by number
/history         # Show current session history
/clear           # Clear all sessions
/help            # Show help

# Or via degeni CLI:
degeni sessions              # List sessions
degeni session new "My Chat" # Create session
degeni session load 1        # Load session #1
degeni session delete 1      # Delete session
degeni session clear         # Clear all
```

### Troubleshooting (NEW!)

```bash
degeni diagnose     # 🔍 Diagnose all problems
degeni fix          # Same as diagnose + auto-fix options

# Checks:
# [1] Proxy Server - online/offline
# [2] Accounts - ada atau tidak
# [3] Rate Limits - quota exceeded
# [4] Auth Errors - token expired
# [5] Suspended - akun di-suspend
# [6] API Connection - responding atau tidak

# Auto-fix options jika ada masalah!
```

### Account Management

```bash
degeni              # Interactive menu
degeni list         # List accounts
degeni add          # Add new account
degeni disable      # Disable account
degeni enable       # Enable account
degeni restart      # Restart & unsuspend
degeni test         # Test accounts
```

### Model & Dashboard

```bash
degeni model        # Switch AI model
degeni dash         # Open live dashboard
degeni status       # System status
degeni errors       # View error logs
```

---

## 🌐 Live Dashboard

Dashboard dengan **real-time data** - bukan dummy!

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

## 🤖 Available Models

### Claude Wrappers (via Antigravity)

| Model | Best For |
|-------|----------|
| `gemini-claude-sonnet-4-5-thinking` ⭐ | Coding, Analysis |
| `gemini-claude-opus-4-5-thinking` | Complex reasoning |
| `gemini-claude-sonnet-4-5` | General tasks |

### Gemini Models

| Model | Best For |
|-------|----------|
| `gemini-3-pro-preview` | All-purpose, Latest |
| `gemini-2.5-pro` | Long context |
| `gemini-2.5-flash` | Quick tasks |

---

## 📁 Folder Structure

```
~/DEGENI/
├── install.sh           # One-shot installer
├── start-dashboard.sh   # Start live dashboard
├── bin/
│   ├── degeni           # Main CLI tool
│   ├── ai               # AI wrapper with session support
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

### Error: `auth_unavailable`

```bash
degeni restart
```

### Error: `payment_required`

```bash
# Add another account or switch model
degeni add
degeni model  # Select: gemini-3-pro-preview
```

### Dashboard not loading

```bash
# Start dashboard services
~/DEGENI/start-dashboard.sh
```

---

## 💰 Cost Comparison

| Service | Monthly | Yearly |
|---------|---------|--------|
| Claude Pro | $20-30 | $240-360 |
| ChatGPT Plus | $20 | $240 |
| **DEGENI** | **$0** | **$0** |

**You save: $240-360/year!** 🎉

---

## 📋 Requirements

- ✅ Linux (Ubuntu/Debian) atau macOS
- ✅ Google AI Pro account (free)
- ✅ Internet connection

**Auto-installed:**
- Node.js, Claude CLI, CLIProxyAPI

---

## 🔐 Security

- 🔒 All traffic local (localhost only)
- 🔒 Credentials in `~/.cli-proxy-api/`
- 🔒 No third-party data sharing
- 🔒 Open source & auditable

---

## 📞 Support

- 🌐 Website: [bitzy.id](https://bitzy.id)
- 📧 Email: support@bitzy.id

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
  <sub>Claude + Gemini AI Terminal</sub><br>
  <sub>by <a href="https://bitzy.id">BITZY.ID</a></sub>
</p>

<p align="center">
  <sub>Made with ❤️ in Indonesia</sub>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Free-Forever-10b981?style=flat-square" alt="Free">
  <img src="https://img.shields.io/badge/Live-Dashboard-06b6d4?style=flat-square" alt="Live">
  <img src="https://img.shields.io/badge/1--Click-Actions-8b5cf6?style=flat-square" alt="1-Click">
  <img src="https://img.shields.io/badge/Made%20in-Indonesia-ef4444?style=flat-square" alt="Indonesia">
</p>
