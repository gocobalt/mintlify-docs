#!/bin/bash
# sync-docs-repo.sh
# Syncs the mintlify-docs repository and sets up developer's personal doc branch

set -e

DOCS_DIR="mintlify-docs"
# TODO: Update this with your actual Cobalt mintlify-docs repository URL
DOCS_REPO_URL="git@github.com:gocobalt/mintlify-docs.git"

# Get developer's username/identifier
DEVELOPER_NAME=$(git config user.name | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
DEVELOPER_BRANCH="docs/$DEVELOPER_NAME"

echo "🔄 Syncing Cobalt documentation repository for $DEVELOPER_NAME..."

if [ ! -d "$DOCS_DIR" ]; then
    echo "📥 Cloning mintlify-docs repository..."
    git clone "$DOCS_REPO_URL" "$DOCS_DIR"
else
    echo "📡 Updating existing mintlify-docs repository..."
    cd "$DOCS_DIR"
    git fetch origin
    cd ..
fi

cd "$DOCS_DIR"

# Ensure we're on the latest main
echo "🔄 Syncing with main branch..."
git checkout main
git pull origin main

# Create or switch to developer's personal branch
if git branch -r | grep -q "origin/$DEVELOPER_BRANCH"; then
    echo "📋 Switching to existing branch: $DEVELOPER_BRANCH"
    git checkout "$DEVELOPER_BRANCH"
    git pull origin "$DEVELOPER_BRANCH"
else
    echo "🆕 Creating new documentation branch: $DEVELOPER_BRANCH"
    git checkout -b "$DEVELOPER_BRANCH"
    git push -u origin "$DEVELOPER_BRANCH"
fi

# Ensure v3 structure exists
echo "🏗️  Ensuring v3 documentation structure..."
mkdir -p v3/{welcome,platform,workflows,mcps,api-reference,integrations,releases}
mkdir -p images/v3-images

echo "✅ Documentation repository synced!"
echo "📝 Your documentation branch: $DEVELOPER_BRANCH"
echo "💡 All your documentation updates will go to this branch"

cd ..

---

