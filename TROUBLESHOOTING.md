# DEGENI Troubleshooting Guide

## 🔧 Common Issues & Quick Fixes

### 1. **Error: `--dangerously-skip-permissions` (Termux)**
```bash
# Fixed in v1.1.0 - just reinstall
git clone https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI.git
cd DEGENI-CLAUDE-ANTIGRAVITY-GEMINI
bash install.sh
```

### 2. **Test API Failed (Already Logged In)**
```bash
# Quick fix - restart proxy
degeni restart

# Then test again
degeni test
```

### 3. **Error: `auth_unavailable`**
```bash
degeni restart
```

### 4. **Error: `payment_required`**
```bash
# Switch to free model
degeni model
# Select: gemini-3-pro-preview

# Or add another account
degeni add
```

### 5. **Dashboard Not Loading**
```bash
~/DEGENI/start-dashboard.sh
# Then open: http://localhost:8080/dashboard.html
```

### 6. **Proxy Not Responding**
```bash
degeni diagnose  # Auto-fix
```

### 7. **Line Ending Issues (Windows)**
```bash
# Fix CRLF to LF
dos2unix install.sh
# Or use sed
sed -i 's/\r$//' install.sh
```

### 8. **Termux Permission Issues**
```bash
# Run Termux-specific fix
bash fix-termux.sh

# Or manual fix
npm config set unsafe-perm true
npm install -g @anthropic-ai/claude-code --unsafe-perm
```

## 🚀 Auto-Diagnose

```bash
degeni diagnose  # One-command fix for most issues
```

## 📞 Still Having Issues?

1. Check logs: `~/DEGENI/logs/`
2. GitHub Issues: https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI/issues
3. Email: support@bitzy.id
