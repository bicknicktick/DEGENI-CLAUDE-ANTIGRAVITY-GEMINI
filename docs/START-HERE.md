# 🚀 Claude Code CLI - Ready to Use!

## ✅ **Setup Complete! Everything is Working!**

You can now use **Claude Code CLI** with **real Claude models** (Sonnet 4.5 & Opus 4.5) via Antigravity proxy!

---

## 🎯 **Simplest Way to Use (Recommended)**

### 🪟 Windows Native (NEW! No WSL!)

```powershell
# From ANY folder in PowerShell or CMD:
claude                    # Interactive mode
claude "your question"    # Quick question
```

**First time setup:**
```powershell
.\install-windows.ps1     # Install (once)
.\bin\cli-proxy-api.exe   # Authenticate (once)
```

📖 **Full guide**: [WINDOWS-SETUP.md](WINDOWS-SETUP.md)

---

### In WSL Terminal (Alternative):

```bash
# Navigate to project
cd "/mnt/d/Vibe Coding/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI"

# Interactive chat with Claude Sonnet 4.5
./claude.sh

# Or ask a quick question
./claude.sh "your question here"
```

**That's it!** The `claude.sh` script automatically:
- ✅ Configures environment variables
- ✅ Loads Node.js
- ✅ Connects to Antigravity proxy
- ✅ Uses Claude Sonnet 4.5 model

---

## 📚 **All Available Methods**

### **Method 1: Windows Native** ⭐ NEW!
```powershell
claude                           # Interactive mode
claude "explain Docker"          # Quick question
```

### **Method 2: WSL Script**
```bash
./claude.sh                          # Interactive mode
./claude.sh "explain Docker"         # Quick question
```

### **Method 3: Configure Once, Use Anywhere**
```bash
source ./configure-claude.sh         # Run once per session
claude --model gemini-claude-sonnet-4-5-thinking
```

### **Method 4: Windows Launcher (Double-Click)**
- `claude-chat.bat` - Interactive with Sonnet 4.5
- `claude-opus.bat` - Interactive with Opus 4.5
- `claude-quick.bat "question"` - Quick questions


---

## 🧠 **Available Models**

| Model | Command | Best For |
|-------|---------|----------|
| **Claude Sonnet 4.5** ⭐ | `gemini-claude-sonnet-4-5-thinking` | Coding, debugging, most tasks |
| **Claude Opus 4.5** 💎 | `gemini-claude-opus-4-5-thinking` | Complex reasoning, architecture |
| **Gemini Flash** ⚡ | `gemini-2.5-flash` | Fast responses |
| **Gemini Pro** 🎯 | `gemini-2.5-pro` | Balanced performance |

---

## 💡 **Example Usage**

### Interactive Chat
```bash
$ ./claude.sh

🤖 Starting Claude Code CLI (Sonnet 4.5 via Antigravity)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

> Write me a Python function to reverse a string
> Explain async/await in JavaScript
> Debug this error: ...
> exit
```

### Quick Questions
```bash
./claude.sh "What is the difference between Git and GitHub?"
./claude.sh "Write a bash script to backup files"
./claude.sh "Explain SOLID principles"
```

### Using Opus for Hard Problems
```bash
source ./configure-claude.sh
claude --model gemini-claude-opus-4-5-thinking
```

---

## 📁 **Project Files**

```
DEGENI-CLAUDE-ANTIGRAVITY-GEMINI/
├── 📘 README.md                    - Original project info
├── 📗 CLAUDE-CLI-USAGE.md          - Detailed CLI usage guide
├── 📙 HOW-TO-USE.md                - Windows launcher guide
├── 📄 START-HERE.md                - This quick start (you are here!)
│
├── 🔧 configure-claude.sh          - Environment setup (Bash)
├── 🔧 configure-claude.ps1         - Environment setup (PowerShell)
├── 🔧 .env                         - Environment variables
│
├── ⚡ claude.sh                    - Simple launcher (WSL)
├── 💬 claude-chat.bat              - Windows launcher (Sonnet)
├── 💎 claude-opus.bat              - Windows launcher (Opus)
└── ⚡ claude-quick.bat             - Windows quick ask
```

---

## 🎬 **Quick Start (Copy-Paste)**

Open **WSL terminal** and run:

```bash
cd "/mnt/d/Vibe Coding/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI"
./claude.sh
```

Start chatting with Claude! 🎉

---

## 🧪 **Verified Working**

Test performed: `2025-12-16 01:36`

```bash
$ ./claude.sh "Explain what is Git in one sentence"

Response: "Git is a distributed version control system that tracks 
changes in your code while maintaining a complete history of all 
modifications."
```

✅ **Status**: Fully operational with Claude Sonnet 4.5!

---

## 🆘 **Troubleshooting**

### Proxy not running?
```bash
ps aux | grep cli-proxy-api
# If not running:
cd ~/cliproxyapi
nohup ./cli-proxy-api &
```

### Permission denied on scripts?
```bash
chmod +x claude.sh configure-claude.sh
```

### Model not found?
Make sure you're using one of the available models:
- `gemini-claude-sonnet-4-5-thinking` ⭐
- `gemini-claude-opus-4-5-thinking` 💎

---

## 📖 **Documentation**

- **Quick Start**: `START-HERE.md` (this file)
- **Detailed CLI Usage**: `CLAUDE-CLI-USAGE.md`
- **Windows Launchers**: `HOW-TO-USE.md`
- **Original DEGENI**: `README.md`

---

## 🎉 **You're All Set!**

Just run `./claude.sh` and start coding with Claude Sonnet 4.5!

**Happy coding! 🚀✨**

---

_Powered by Antigravity Proxy + Claude Code CLI + Gemini-wrapped Claude Models_
