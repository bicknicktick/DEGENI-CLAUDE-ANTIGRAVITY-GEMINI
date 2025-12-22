# 🚀 Quick Start Guide - Claude Code CLI

## ✅ Setup Complete!

Your DEGENI system is fully configured with:
- ✅ Claude Code CLI v2.0.69
- ✅ Claude Sonnet 4.5 (Thinking Mode)
- ✅ Claude Opus 4.5 (Thinking Mode)
- ✅ Antigravity Proxy
- ✅ Your Google Account: `amrfortestingmem0@gmail.com`

---

## 🎯 How to Run Claude Code CLI

### Method 1: Double-Click Scripts (Easiest!)

Just **double-click** these files:

| Script | Model | Use Case |
|--------|-------|----------|
| **`claude-chat.bat`** | Claude Sonnet 4.5 | 🔥 **BEST** - Interactive chat, coding |
| **`claude-opus.bat`** | Claude Opus 4.5 | 💎 Advanced reasoning, complex tasks |
| **`claude-quick.bat`** | Claude Sonnet 4.5 | ⚡ Quick single questions |

### Method 2: From Command Line

```cmd
# Interactive chat with Claude Sonnet 4.5
claude-chat.bat

# Quick question
claude-quick.bat "explain what is Docker"

# Use Opus for complex reasoning
claude-opus.bat
```

---

## 💡 Example Usage

### Interactive Chat Mode
```bash
# Double-click claude-chat.bat or run:
claude-chat.bat

# Then chat naturally:
> Hello! Can you help me write a Python function?
> What's the best way to structure a React app?
> Debug this error: ...
```

### Quick Ask Mode
```cmd
claude-quick.bat "explain async/await in JavaScript"
claude-quick.bat "write a bash script to backup files"
claude-quick.bat "what are the SOLID principles?"
```

---

## 🧠 Available Models

| Model | Description | When to Use |
|-------|-------------|-------------|
| **Claude Sonnet 4.5** | Best for coding, balanced | Daily coding tasks ⭐ |
| **Claude Opus 4.5** | Most powerful reasoning | Complex architecture, debugging 💎 |

---

## 📁 Project Location
```
d:\Vibe Coding\DEGENI-CLAUDE-ANTIGRAVITY-GEMINI\
├── claude-chat.bat    ← Interactive chat (Sonnet)
├── claude-opus.bat    ← Interactive chat (Opus)
├── claude-quick.bat   ← Quick questions
└── HOW-TO-USE.md      ← This guide
```

---

## 🔧 Advanced: Manual WSL Commands

If you prefer using WSL directly:

```bash
# Open WSL terminal
wsl

# Set up environment
source ~/.nvm/nvm.sh && nvm use node
export ANTHROPIC_BASE_URL=http://127.0.0.1:8317
export ANTHROPIC_API_KEY=sk-ycY2nDJ7VvvnWPnYEAf3pc84n9sdDQFjD8tb8nlb2f7Du

# Run Claude Code CLI
claude --model gemini-claude-sonnet-4-5-thinking

# Or quick question
claude --dangerously-skip-permissions --model gemini-claude-sonnet-4-5-thinking -p "your question"
```

---

## 🎨 Claude Code CLI Features

Once you're in interactive mode, you can:

- 💬 **Chat naturally** - Ask coding questions
- 📝 **Write code** - Request functions, classes, scripts
- 🐛 **Debug** - Paste errors and get help
- 🔍 **Review code** - Get feedback on your code
- 📚 **Learn** - Ask for explanations and best practices
- 🚀 **Build projects** - Get architectural guidance

---

## 🆘 Troubleshooting

### If scripts don't work:

1. **Make sure WSL is running:**
   ```cmd
   wsl --list --verbose
   ```

2. **Restart the proxy if needed:**
   ```cmd
   wsl bash -c "pkill cli-proxy-api"
   wsl bash -c "cd ~/cliproxyapi && nohup ./cli-proxy-api &"
   ```

3. **Check if proxy is running:**
   ```cmd
   wsl bash -c "ps aux | grep cli-proxy"
   ```

---

## 🎉 You're All Set!

Just double-click **`claude-chat.bat`** to start chatting with Claude Sonnet 4.5!

Happy coding! 🚀✨
