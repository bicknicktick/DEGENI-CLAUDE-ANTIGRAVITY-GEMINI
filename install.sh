#!/bin/bash
#═══════════════════════════════════════════════════════════════════════════════
#
#  ██████╗ ███████╗ ██████╗ ███████╗███╗   ██╗██╗
#  ██╔══██╗██╔════╝██╔════╝ ██╔════╝████╗  ██║██║
#  ██║  ██║█████╗  ██║  ███╗█████╗  ██╔██╗ ██║██║
#  ██║  ██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║
#  ██████╔╝███████╗╚██████╔╝███████╗██║ ╚████║██║
#  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝
#
#  DEGENI - Claude + Gemini AI Terminal
#  by BITZY.ID
#
#  Installer v1.1.0
#
#═══════════════════════════════════════════════════════════════════════════════

set -e

VERSION="1.1.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEGENI_HOME="$HOME/DEGENI"
AUTH_DIR="$HOME/.cli-proxy-api"
PROXY_DIR="$HOME/cliproxyapi"

# Colors
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
C='\033[0;36m'
M='\033[0;35m'
W='\033[1;37m'
D='\033[0;90m'
NC='\033[0m'

clear

# Print banner
echo -e "${C}"
cat << 'BANNER'

  ██████╗ ███████╗ ██████╗ ███████╗███╗   ██╗██╗
  ██╔══██╗██╔════╝██╔════╝ ██╔════╝████╗  ██║██║
  ██║  ██║█████╗  ██║  ███╗█████╗  ██╔██╗ ██║██║
  ██║  ██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║
  ██████╔╝███████╗╚██████╔╝███████╗██║ ╚████║██║
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝

BANNER
echo -e "${NC}"
echo -e "${W}  Claude + Gemini AI Terminal${NC}"
echo -e "${D}  by BITZY.ID | Installer v$VERSION${NC}"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Helper functions
success() { echo -e " ${G}✓${NC} $1"; }
error() { echo -e " ${R}✗${NC} $1"; exit 1; }
warning() { echo -e " ${Y}!${NC} $1"; }
info() { echo -e " ${B}→${NC} $1"; }
step() { echo -e "\n${W}[$1/$TOTAL_STEPS]${NC} ${C}$2${NC}\n"; }

TOTAL_STEPS=5

#═══════════════════════════════════════════════════════════════════════════════
# STEP 1: Check System Requirements
#═══════════════════════════════════════════════════════════════════════════════
step 1 "Checking System Requirements"

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    success "Operating System: Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    success "Operating System: macOS"
else
    error "Unsupported OS: $OSTYPE"
fi

# Check curl
if command -v curl &> /dev/null; then
    success "curl: installed"
else
    warning "curl not found, installing..."
    if [[ "$OS" == "linux" ]]; then
        sudo apt-get update && sudo apt-get install -y curl
    else
        brew install curl
    fi
fi

# Check python3
if command -v python3 &> /dev/null; then
    success "Python: $(python3 --version 2>&1 | cut -d' ' -f2)"
else
    warning "Python3 not found, installing..."
    if [[ "$OS" == "linux" ]]; then
        sudo apt-get install -y python3
    else
        brew install python3
    fi
fi

#═══════════════════════════════════════════════════════════════════════════════
# STEP 2: Install Node.js & Claude CLI
#═══════════════════════════════════════════════════════════════════════════════
step 2 "Installing Node.js & Claude CLI"

# Check/Install Node.js
if command -v node &> /dev/null; then
    success "Node.js: $(node --version)"
else
    info "Installing Node.js via nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    success "Node.js installed: $(node --version)"
fi

# Ensure nvm is loaded
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Check/Install Claude CLI
if command -v claude &> /dev/null; then
    success "Claude CLI: installed"
else
    info "Installing Claude CLI..."
    npm install -g @anthropic-ai/claude-code
    success "Claude CLI installed"
fi

#═══════════════════════════════════════════════════════════════════════════════
# STEP 3: Install CLIProxyAPI
#═══════════════════════════════════════════════════════════════════════════════
step 3 "Installing CLIProxyAPI (AI Proxy Server)"

if [ -f "$PROXY_DIR/cli-proxy-api" ]; then
    success "CLIProxyAPI already installed"
else
    info "Downloading CLIProxyAPI..."
    cd ~
    curl -fsSL https://raw.githubusercontent.com/brokechubb/cliproxyapi-installer/refs/heads/master/cliproxyapi-installer | bash
    success "CLIProxyAPI installed"
fi

#═══════════════════════════════════════════════════════════════════════════════
# STEP 4: Setup DEGENI Files
#═══════════════════════════════════════════════════════════════════════════════
step 4 "Installing DEGENI Tools"

# Create directories
mkdir -p "$DEGENI_HOME"/{bin,ui,config,logs,sessions}
mkdir -p "$AUTH_DIR"

# Copy all files from source
if [ -d "$SCRIPT_DIR/bin" ]; then
    info "Copying CLI tools..."
    cp -f "$SCRIPT_DIR/bin/"* "$DEGENI_HOME/bin/" 2>/dev/null || true
    chmod +x "$DEGENI_HOME/bin/"*
    success "CLI tools installed"
fi

if [ -d "$SCRIPT_DIR/ui" ]; then
    info "Copying dashboard..."
    cp -f "$SCRIPT_DIR/ui/"* "$DEGENI_HOME/ui/" 2>/dev/null || true
    success "Dashboard installed"
fi

if [ -f "$SCRIPT_DIR/start-dashboard.sh" ]; then
    cp -f "$SCRIPT_DIR/start-dashboard.sh" "$DEGENI_HOME/"
    chmod +x "$DEGENI_HOME/start-dashboard.sh"
fi

if [ -f "$SCRIPT_DIR/README.md" ]; then
    cp -f "$SCRIPT_DIR/README.md" "$DEGENI_HOME/"
fi

# Copy config if exists
[ -f "$PROXY_DIR/config.yaml" ] && cp "$PROXY_DIR/config.yaml" "$DEGENI_HOME/config/" 2>/dev/null || true

success "DEGENI files installed to ~/DEGENI"

#═══════════════════════════════════════════════════════════════════════════════
# STEP 5: Configure Shell & Start Services
#═══════════════════════════════════════════════════════════════════════════════
step 5 "Configuring System"

# Detect shell config
SHELL_RC="$HOME/.bashrc"
[[ "$SHELL" == *"zsh"* ]] && SHELL_RC="$HOME/.zshrc"

# Add DEGENI to PATH if not already
if ! grep -q "DEGENI" "$SHELL_RC" 2>/dev/null; then
    info "Adding DEGENI to shell..."
    cat >> "$SHELL_RC" << 'SHELL_CONFIG'

#═══════════════════════════════════════════════════════════════════════════════
# DEGENI - Claude + Gemini AI Terminal | by BITZY.ID
#═══════════════════════════════════════════════════════════════════════════════
export PATH="$HOME/DEGENI/bin:$PATH"
alias degeni="$HOME/DEGENI/bin/degeni"
SHELL_CONFIG
    success "Shell configured"
else
    success "Shell already configured"
fi

# Export PATH for current session
export PATH="$HOME/DEGENI/bin:$PATH"

# Start proxy if not running
if ! pgrep -f "cli-proxy-api" > /dev/null 2>&1; then
    if [ -f "$PROXY_DIR/cli-proxy-api" ]; then
        info "Starting proxy server..."
        cd "$PROXY_DIR"
        nohup ./cli-proxy-api > cliproxyapi.log 2>&1 &
        sleep 2
        pgrep -f "cli-proxy-api" > /dev/null && success "Proxy server started" || warning "Proxy start failed"
    fi
else
    success "Proxy server already running"
fi

#═══════════════════════════════════════════════════════════════════════════════
# Installation Complete - Show Instructions
#═══════════════════════════════════════════════════════════════════════════════
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${G}  ✓ INSTALLATION COMPLETE!${NC}"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if accounts exist
ACCOUNT_COUNT=$(ls -1 "$AUTH_DIR"/antigravity-*.json 2>/dev/null | wc -l)

if [ "$ACCOUNT_COUNT" -gt 0 ]; then
    echo -e "  ${G}✓ Found $ACCOUNT_COUNT existing account(s)${NC}"
    echo ""
    echo -e "  ${W}You're ready! Run:${NC}"
    echo ""
    echo -e "     ${C}source ~/.bashrc${NC}         ${D}# Reload shell (once)${NC}"
    echo -e "     ${C}degeni \"hello\"${NC}           ${D}# Quick question${NC}"
    echo -e "     ${C}degeni chat${NC}              ${D}# Interactive chat${NC}"
    echo -e "     ${C}degeni${NC}                   ${D}# Management menu${NC}"
else
    echo -e "  ${Y}! No Google AI account found${NC}"
    echo ""
    echo -e "  ${W}SETUP REQUIRED (2 steps):${NC}"
    echo ""
    echo -e "  ${C}Step 1:${NC} Reload shell"
    echo -e "     ${W}source ~/.bashrc${NC}"
    echo ""
    echo -e "  ${C}Step 2:${NC} Add Google AI account"
    echo -e "     ${W}degeni add${NC}"
    echo ""
    echo -e "     ${D}This will:${NC}"
    echo -e "     ${D}1. Show a URL - open it in browser${NC}"
    echo -e "     ${D}2. Login with Google AI Pro account${NC}"
    echo -e "     ${D}3. Authorize and copy callback URL${NC}"
    echo -e "     ${D}4. Paste callback URL in terminal${NC}"
    echo ""
    echo -e "  ${C}Step 3:${NC} Start using AI"
    echo -e "     ${W}degeni \"hello world\"${NC}"
fi

echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${W}COMMANDS:${NC}"
echo ""
echo -e "  ${C}degeni \"question\"${NC}     Quick ask"
echo -e "  ${C}degeni chat${NC}           Interactive chat"
echo -e "  ${C}degeni${NC}                Management menu"
echo -e "  ${C}degeni add${NC}            Add Google AI account"
echo -e "  ${C}degeni dash${NC}           Open live dashboard"
echo -e "  ${C}degeni sessions${NC}       Manage chat sessions"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${D}DEGENI v1.0.0 | by BITZY.ID | https://bitzy.id${NC}"
echo -e "  ${D}Donate: paypal.me/bitzyid${NC}"
echo ""
