#!/bin/bash
#═══════════════════════════════════════════════════════════════════════════════
#
#  DEGENI Uninstaller
#  by BITZY.ID
#
#═══════════════════════════════════════════════════════════════════════════════

# Colors
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
C='\033[0;36m'
W='\033[1;37m'
D='\033[0;90m'
NC='\033[0m'

clear

echo -e "${R}"
cat << 'BANNER'

  ██████╗ ███████╗ ██████╗ ███████╗███╗   ██╗██╗
  ██╔══██╗██╔════╝██╔════╝ ██╔════╝████╗  ██║██║
  ██║  ██║█████╗  ██║  ███╗█████╗  ██╔██╗ ██║██║
  ██║  ██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║
  ██████╔╝███████╗╚██████╔╝███████╗██║ ╚████║██║
  ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝

            UNINSTALLER

BANNER
echo -e "${NC}"

echo -e "${Y}⚠️  This will remove DEGENI from your system${NC}"
echo ""
echo -e "${W}What will be removed:${NC}"
echo -e "  ${D}→ ~/DEGENI/ folder${NC}"
echo -e "  ${D}→ Shell aliases (degeni, ai)${NC}"
echo -e "  ${D}→ Running proxy processes${NC}"
echo ""
echo -e "${W}What will be KEPT (optional):${NC}"
echo -e "  ${D}→ ~/cliproxyapi/ (CLIProxyAPI)${NC}"
echo -e "  ${D}→ ~/.cli-proxy-api/ (Accounts)${NC}"
echo -e "  ${D}→ Claude CLI${NC}"
echo ""

read -p "$(echo -e ${Y}Proceed with uninstall? [y/N]: ${NC})" confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo -e "\n${G}Uninstall cancelled.${NC}\n"
    exit 0
fi

echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${W}Uninstalling DEGENI...${NC}"
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Stop processes
echo -e " ${Y}[1/4]${NC} Stopping processes..."
pkill -9 -f "cli-proxy-api" 2>/dev/null && echo -e "       ${G}✓${NC} Stopped proxy server" || echo -e "       ${D}→ Proxy not running${NC}"
pkill -9 -f "degeni-api" 2>/dev/null && echo -e "       ${G}✓${NC} Stopped API server" || echo -e "       ${D}→ API not running${NC}"
pkill -9 -f "http.server 8080" 2>/dev/null && echo -e "       ${G}✓${NC} Stopped dashboard server" || echo -e "       ${D}→ Dashboard not running${NC}"

# Remove shell config
echo ""
echo -e " ${Y}[2/4]${NC} Removing shell configuration..."
SHELL_RC="$HOME/.bashrc"
[[ "$SHELL" == *"zsh"* ]] && SHELL_RC="$HOME/.zshrc"

if grep -q "DEGENI" "$SHELL_RC" 2>/dev/null; then
    # Create backup
    cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remove DEGENI block
    sed -i '/# DEGENI/,/^$/d' "$SHELL_RC" 2>/dev/null
    sed -i '/DEGENI/d' "$SHELL_RC" 2>/dev/null
    
    echo -e "       ${G}✓${NC} Removed from $SHELL_RC"
else
    echo -e "       ${D}→ No DEGENI config found${NC}"
fi

# Remove DEGENI folder
echo ""
echo -e " ${Y}[3/4]${NC} Removing DEGENI folder..."
if [ -d "$HOME/DEGENI" ]; then
    rm -rf "$HOME/DEGENI"
    echo -e "       ${G}✓${NC} Removed ~/DEGENI/"
else
    echo -e "       ${D}→ ~/DEGENI/ not found${NC}"
fi

# Ask about CLIProxyAPI and accounts
echo ""
echo -e " ${Y}[4/4]${NC} Additional cleanup (optional)..."
echo ""

read -p "$(echo -e "       ${Y}Also remove CLIProxyAPI? [y/N]: ${NC}")" remove_proxy
if [[ "$remove_proxy" == "y" || "$remove_proxy" == "Y" ]]; then
    rm -rf "$HOME/cliproxyapi" 2>/dev/null && echo -e "       ${G}✓${NC} Removed ~/cliproxyapi/" || echo -e "       ${D}→ Not found${NC}"
    rm -f "$HOME/cliproxyapi.pid" 2>/dev/null
fi

read -p "$(echo -e "       ${Y}Also remove saved accounts? [y/N]: ${NC}")" remove_accounts
if [[ "$remove_accounts" == "y" || "$remove_accounts" == "Y" ]]; then
    rm -rf "$HOME/.cli-proxy-api" 2>/dev/null && echo -e "       ${G}✓${NC} Removed ~/.cli-proxy-api/" || echo -e "       ${D}→ Not found${NC}"
fi

# Done
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${G}  ✓ DEGENI has been uninstalled${NC}"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${D}To complete removal, run:${NC}"
echo -e "  ${W}source ~/.bashrc${NC}"
echo ""
echo -e "  ${D}Thank you for using DEGENI!${NC}"
echo -e "  ${D}by BITZY.ID | https://bitzy.id${NC}"
echo ""
