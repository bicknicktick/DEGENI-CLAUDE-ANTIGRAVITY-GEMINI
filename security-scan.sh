#!/bin/bash

# DEGENI Security Scanner
# Scans for hardcoded API keys and secrets

echo "🔒 DEGENI Security Scanner"
echo "=========================="

# Colors
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
NC='\033[0m'

FOUND_ISSUES=0

# Scan for API keys
echo "🔍 Scanning for hardcoded API keys..."

# Check for sk- keys (Anthropic/OpenAI format)
SK_KEYS=$(grep -r "sk-[A-Za-z0-9]" . --exclude-dir=.git --exclude-dir=logs --exclude-dir=sessions 2>/dev/null | grep -v "sk-dummy" | grep -v "sk-default" | grep -v "sk-atSM" | grep -v "#")
if [ ! -z "$SK_KEYS" ]; then
    echo -e "${R}❌ CRITICAL: Found hardcoded API keys!${NC}"
    echo "$SK_KEYS"
    FOUND_ISSUES=1
fi

# Check for AIza keys (Google format)
GOOGLE_KEYS=$(grep -r "AIza[A-Za-z0-9]" . --exclude-dir=.git --exclude-dir=logs --exclude-dir=sessions 2>/dev/null | grep -v "#")
if [ ! -z "$GOOGLE_KEYS" ]; then
    echo -e "${R}❌ CRITICAL: Found Google API keys!${NC}"
    echo "$GOOGLE_KEYS"
    FOUND_ISSUES=1
fi

# Check for other sensitive patterns
TOKENS=$(grep -r -i "token.*['\"][A-Za-z0-9]{20,}" . --exclude-dir=.git --exclude-dir=logs --exclude-dir=sessions 2>/dev/null | grep -v "dummy" | grep -v "example")
if [ ! -z "$TOKENS" ]; then
    echo -e "${Y}⚠️  WARNING: Found potential tokens!${NC}"
    echo "$TOKENS"
fi

# Check git history for leaked keys
echo "🔍 Checking git history for leaked keys..."
GIT_LEAKS=$(git log --all --full-history -- . | grep -i "sk-[A-Za-z0-9]" | grep -v "sk-dummy" | grep -v "sk-default")
if [ ! -z "$GIT_LEAKS" ]; then
    echo -e "${R}❌ CRITICAL: Found API keys in git history!${NC}"
    echo "Run: git filter-branch to clean history"
    FOUND_ISSUES=1
fi

if [ $FOUND_ISSUES -eq 0 ]; then
    echo -e "${G}✅ No hardcoded API keys found!${NC}"
    echo -e "${G}✅ Repository is secure${NC}"
else
    echo -e "${R}❌ SECURITY ISSUES FOUND!${NC}"
    echo -e "${Y}🔧 Run 'bash clean-secrets.sh' to fix${NC}"
    exit 1
fi
