#!/bin/bash

# DEGENI History Cleaner
# WARNING: This will rewrite git history!

echo "🧹 DEGENI Git History Cleaner"
echo "============================="
echo ""
echo "⚠️  WARNING: This will REWRITE git history!"
echo "⚠️  All contributors will need to re-clone!"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

echo "🔄 Cleaning git history..."

# Remove API keys from history using git filter-repo (safer than filter-branch)
if command -v git-filter-repo &> /dev/null; then
    echo "Using git-filter-repo (recommended)..."
    git filter-repo --replace-text <(echo "sk-OeMG7duPNQb7wSPPqMLng3UnqhgCXxhfkhM4VNAxRH8dR==>sk-REMOVED-FOR-SECURITY")
    git filter-repo --replace-text <(echo "sk-znzJSZlljOg2EfRN8cIt3FKzQrzZg8lIVH5E9B57EHD0Z==>sk-REMOVED-FOR-SECURITY")
else
    echo "Installing git-filter-repo..."
    pip3 install git-filter-repo
    
    echo "Cleaning history with filter-repo..."
    git filter-repo --replace-text <(echo "sk-OeMG7duPNQb7wSPPqMLng3UnqhgCXxhfkhM4VNAxRH8dR==>sk-REMOVED-FOR-SECURITY")
    git filter-repo --replace-text <(echo "sk-znzJSZlljOg2EfRN8cIt3FKzQrzZg8lIVH5E9B57EHD0Z==>sk-REMOVED-FOR-SECURITY")
fi

echo "✅ Git history cleaned!"
echo ""
echo "🚀 Next steps:"
echo "1. Force push: git push --force-with-lease origin main"
echo "2. All users must re-clone the repository"
echo "3. Update README with new security notice"
