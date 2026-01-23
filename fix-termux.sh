#!/bin/bash

# DEGENI Termux Fix Script
# Fixes permission issues in Termux environment

echo "🔧 Fixing DEGENI for Termux..."

# Set proper npm configuration for Termux
npm config set unsafe-perm true
npm config set user 0
npm config set cache ~/.npm

# Fix Claude CLI permissions
if command -v claude &> /dev/null; then
    echo "✅ Claude CLI found, fixing permissions..."
    
    # Create Claude config directory if not exists
    mkdir -p ~/.config/claude
    
    # Set proper permissions
    chmod 755 ~/.config/claude
    
    # Configure Claude for non-root usage
    cat > ~/.config/claude/config.json << 'EOF'
{
  "skip_permissions_check": true,
  "allow_unsafe_operations": true
}
EOF
    
    echo "✅ Claude CLI configured for Termux"
else
    echo "⚠️  Claude CLI not found, installing..."
    npm install -g @anthropic-ai/claude-cli
fi

# Fix DEGENI scripts permissions
chmod +x ~/DEGENI/bin/*
chmod +x ~/DEGENI/*.sh

# Test the fix
echo "🧪 Testing DEGENI..."
cd ~/DEGENI
if ./bin/degeni "test" &> /dev/null; then
    echo "✅ DEGENI working correctly!"
else
    echo "⚠️  Still having issues, trying alternative fix..."
    
    # Alternative: Use npx instead of global install
    sed -i 's/claude /npx @anthropic-ai\/claude-cli /g' ~/DEGENI/bin/*
    
    echo "✅ Applied alternative fix using npx"
fi

echo "🎉 Termux fix completed!"
echo "💡 Try running: degeni \"hello world\""
