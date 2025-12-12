# Troubleshooting DEGENI Installation Issues

## Line Ending Issues (CRLF Error)

### Symptoms
When running `bash install.sh`, you see errors like:
```bash
install.sh: line 17: $'\r': command not found
: invalid option 18: set: -
install.sh: line 76: syntax error near unexpected token `elif'
```

### Root Cause
This happens when the shell scripts have Windows-style line endings (CRLF - `\r\n`) instead of Unix-style line endings (LF - `\n`). This typically occurs when:
- You cloned the repository on Windows
- Git auto-converted LF to CRLF based on your git config

### Solution 1: Convert Line Endings with dos2unix (Recommended)

#### On Linux/Mac:
```bash
# Install dos2unix if not already installed
# Ubuntu/Debian:
sudo apt-get install dos2unix

# macOS:
brew install dos2unix

# Convert all shell scripts
dos2unix install.sh
dos2unix uninstall.sh
dos2unix start-dashboard.sh
dos2unix bin/degeni
dos2unix bin/ai

# Now run the installer
bash install.sh
```

### Solution 2: Convert with sed (No installation required)

```bash
# Convert install.sh
sed -i 's/\r$//' install.sh

# Convert all shell scripts at once
find . -name "*.sh" -type f -exec sed -i 's/\r$//' {} \;
find ./bin -type f -exec sed -i 's/\r$//' {} \;

# Now run the installer
bash install.sh
```

### Solution 3: Re-clone with Correct Git Settings

```bash
# Configure git to not auto-convert line endings
git config --global core.autocrlf false

# Remove the repository and clone again
cd ..
rm -rf DEGENI
git clone https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI.git DEGENI
cd DEGENI

# Now run the installer
bash install.sh
```

### Prevention
The repository now includes a `.gitattributes` file that enforces LF line endings. After pulling the latest changes, future clones will automatically use the correct line endings.

---

## Other Common Issues

### Python Not Found
**Error:** `python3: command not found`

**Solution:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install python3

# macOS
brew install python3
```

### Node.js/npm Not Installed
**Error:** `node: command not found` or `npm: command not found`

**Solution:**
```bash
# Install nvm first
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload shell
source ~/.bashrc  # or ~/.zshrc

# Install Node.js
nvm install --lts
nvm use --lts
```

### Permission Denied
**Error:** `Permission denied` when running scripts

**Solution:**
```bash
# Make scripts executable
chmod +x install.sh
chmod +x uninstall.sh
chmod +x start-dashboard.sh
chmod +x bin/*

# Now run the installer
bash install.sh
```

### Port Already in Use
**Error:** `Address already in use: 8317` or `8321` or `8080`

**Solution:**
```bash
# Find and kill the process using the port
# For port 8317 (proxy):
lsof -ti:8317 | xargs kill -9

# For port 8321 (API):
lsof -ti:8321 | xargs kill -9

# For port 8080 (dashboard):
lsof -ti:8080 | xargs kill -9

# Restart DEGENI
degeni restart
```

### Claude CLI Installation Fails
**Error:** `Failed to install Claude CLI`

**Solution:**
```bash
# Manually install Claude CLI
npm install -g @anthropic-ai/claude-code

# Verify installation
which claude
claude --version
```

### ClipProxyAPI Installation Fails
**Error:** `Failed to clone cliproxyapi-installer`

**Solution:**
```bash
# Manually clone and install
cd ~
git clone https://github.com/antigravityai/cliproxyapi-installer.git cliproxyapi
cd cliproxyapi
bash install.sh
```

---

## Getting Help

If you encounter an issue not listed here:

1. Run diagnostics:
   ```bash
   degeni diagnose
   ```

2. Check logs:
   ```bash
   cat ~/DEGENI/logs/api.log
   cat ~/DEGENI/logs/dashboard.log
   ```

3. Report the issue:
   - GitHub Issues: https://github.com/bicknicktick/DEGENI-CLAUDE-ANTIGRAVITY-GEMINI/issues
   - Include the output of `degeni diagnose`
   - Include relevant error messages
   - Mention your OS and version

---

## Quick Diagnostic Commands

```bash
# Check all services status
degeni status

# Test API connection
degeni test

# Check installed dependencies
which python3
which node
which npm
which git
which curl

# Check file permissions
ls -la ~/DEGENI/bin/

# Check port usage
lsof -i :8317
lsof -i :8321
lsof -i :8080
```
