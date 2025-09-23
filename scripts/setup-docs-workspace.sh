#!/bin/bash
# setup-developer-workspace.sh
# Sets up a developer's personal documentation workspace

set -e

echo "👋 Setting up your personal Cobalt documentation workspace..."

# Get developer information
DEVELOPER_NAME=$(git config user.name | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
DEVELOPER_EMAIL=$(git config user.email)

if [ -z "$DEVELOPER_NAME" ]; then
    echo "❌ Git user.name not configured. Please run:"
    echo "git config --global user.name 'Your Name'"
    exit 1
fi

echo "👤 Developer: $(git config user.name) ($DEVELOPER_EMAIL)"
echo "🌿 Your docs branch will be: docs/$DEVELOPER_NAME"

# Sync documentation repository
echo "🔄 Setting up your documentation workspace..."
./scripts/sync-docs-repo.sh

echo ""
echo "✅ Your personal documentation workspace is ready!"
echo ""
echo "🚀 Quick Start:"
echo "1. Use @docs in Cursor to create documentation"
echo "2. Run ./scripts/create-docs-pr.sh when ready to share"
echo "3. Your PR will be automatically analyzed and structured"
echo ""
echo "💡 Your documentation branch: docs/$DEVELOPER_NAME"
echo "📁 All changes go to: mintlify-docs/v3/"
echo "🖼️ Images go to: mintlify-docs/images/v3-images/"
echo ""
echo "🎯 Example usage:"
echo '@docs I built Salesforce OAuth integration with contact sync for SaaS teams'
echo ""
echo "Happy documenting! 📚✨"

---