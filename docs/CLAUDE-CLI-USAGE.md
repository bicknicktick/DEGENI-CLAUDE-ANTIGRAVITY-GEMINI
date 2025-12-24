# 🎯 Using Claude Code CLI with Antigravity (Inside This CLI)

## ✅ Quick Setup

You have **3 options** to configure your Claude Code CLI session:

---

## **Option 1: WSL/Bash (Recommended)**

Open your WSL terminal in this directory and run:

```bash
source ./configure-claude.sh
```

This will:
- ✅ Set `ANTHROPIC_BASE_URL=http://127.0.0.1:8317`
- ✅ Set `ANTHROPIC_API_KEY` 
- ✅ Load Node.js via nvm
- ✅ Show available models

**Then use Claude CLI:**
```bash
# Interactive mode with Claude Sonnet 4.5
claude --model gemini-claude-sonnet-4-5-thinking

# Quick question
claude --dangerously-skip-permissions --model gemini-claude-sonnet-4-5-thinking -p "your question here"

# Use Claude Opus 4.5
claude --model gemini-claude-opus-4-5-thinking
```

---

## **Option 2: PowerShell**

```powershell
.\configure-claude.ps1
```

Then use the same `claude` commands as above.

---

## **Option 3: Manual Environment Variables**

### WSL/Bash:
```bash
export ANTHROPIC_BASE_URL="http://127.0.0.1:8317"
export ANTHROPIC_API_KEY="sk-ycY2nDJ7VvvnWPnYEAf3pc84n9sdDQFjD8tb8nlb2f7Du"
```

### PowerShell:
```powershell
$env:ANTHROPIC_BASE_URL = "http://127.0.0.1:8317"
$env:ANTHROPIC_API_KEY = "sk-ycY2nDJ7VvvnWPnYEAf3pc84n9sdDQFjD8tb8nlb2f7Du"
```

---

## 🎨 Available Models

| Model | ID | Best For |
|-------|-----|----------|
| **Claude Sonnet 4.5** ⭐ | `gemini-claude-sonnet-4-5-thinking` | Coding, balanced tasks |
| **Claude Opus 4.5** 💎 | `gemini-claude-opus-4-5-thinking` | Complex reasoning |
| **Gemini Flash** ⚡ | `gemini-2.5-flash` | Fast responses |
| **Gemini Pro** 🎯 | `gemini-2.5-pro` | General tasks |

---

## 💡 Example Commands

### Interactive Chat
```bash
# Start chat with Claude Sonnet 4.5
claude --model gemini-claude-sonnet-4-5-thinking

# Then chat naturally:
> Write a Python function to calculate factorial
> Debug this error: ...
> What's the difference between let and const in JavaScript?
```

### Quick Questions (Single Shot)
```bash
# Skip permissions for quick questions
claude --dangerously-skip-permissions \
  --model gemini-claude-sonnet-4-5-thinking \
  -p "Explain async/await in simple terms"

# Use Opus for complex reasoning
claude --dangerously-skip-permissions \
  --model gemini-claude-opus-4-5-thinking \
  -p "Design a microservices architecture for an e-commerce platform"
```

### Code Generation
```bash
claude --dangerously-skip-permissions \
  --model gemini-claude-sonnet-4-5-thinking \
  -p "Create a React component with TypeScript for a todo list"
```

---

## 📋 Complete Workflow Example

```bash
# 1. Navigate to project directory
cd "/mnt/d/Vibe Coding/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI"

# 2. Configure environment
source ./configure-claude.sh

# 3. Start Claude Code CLI
claude --model gemini-claude-sonnet-4-5-thinking

# 4. Chat with Claude!
# (The CLI will now connect to Antigravity proxy and use Claude models)
```

---

## 🔧 Troubleshooting

### "Invalid API key"
Make sure you ran the configuration script:
```bash
source ./configure-claude.sh
```

### "API Error: 404"
The proxy might not be running. Check:
```bash
ps aux | grep cli-proxy-api
```

If not running, restart it:
```bash
cd ~/cliproxyapi
nohup ./cli-proxy-api &
```

### "Unknown provider for model"
Make sure you're using one of the available models listed above.

---

## 🎯 Quick Reference Card

```bash
# Configure (run once per session)
source ./configure-claude.sh

# Interactive chat
claude --model gemini-claude-sonnet-4-5-thinking

# Quick ask
claude --dangerously-skip-permissions \
  --model gemini-claude-sonnet-4-5-thinking \
  -p "your question"

# Check version
claude --version

# List available models (via proxy)
curl http://localhost:8317/v1/models?key=sk-ycY2nDJ7VvvnWPnYEAf3pc84n9sdDQFjD8tb8nlb2f7Du
```

---

## ✅ Verified Working!

Test result (2025-12-16):
```
> claude --dangerously-skip-permissions --model gemini-claude-sonnet-4-5-thinking -p "Hello! Say hi"

Response: "Hi! I'm Claude, and I'm powered by the Sonnet 4.5 model. 
I'm here to help you with software engineering tasks, debugging, 
code exploration, and more. How can I assist you today?"
```

🎉 **It works!** You're now using Claude Code CLI with real Claude models via Antigravity!

---

**Happy coding! 🚀✨**
