#!/bin/bash
# create-docs-pr.sh
# Intelligently creates PR based on documentation changes made

set -e

DOCS_DIR="mintlify-docs"

if [ ! -d "$DOCS_DIR" ]; then
    echo "❌ mintlify-docs directory not found. Run ./scripts/sync-docs-repo.sh first."
    exit 1
fi

cd "$DOCS_DIR"

# Get current branch and developer info
CURRENT_BRANCH=$(git branch --show-current)
DEVELOPER_NAME=$(git config user.name)

# Ensure we're on a documentation branch
if [[ ! "$CURRENT_BRANCH" == docs/* ]]; then
    echo "❌ Not on a documentation branch. Current: $CURRENT_BRANCH"
    echo "💡 Run ./scripts/sync-docs-repo.sh to set up your documentation branch"
    exit 1
fi

# Check if there are changes to commit
if git diff --quiet && git diff --cached --quiet; then
    echo "❌ No changes to commit. Create your documentation first using @docs"
    exit 1
fi

echo "🚀 Creating intelligent documentation PR..."
echo "👤 Developer: $DEVELOPER_NAME"
echo "🌿 Branch: $CURRENT_BRANCH"
echo ""

# Analyze changes to generate intelligent PR description
echo "🔍 Analyzing documentation changes..."

# Get list of changed files
CHANGED_FILES=$(git diff --name-only HEAD)
NEW_FILES=$(git diff --name-only --diff-filter=A HEAD)
MODIFIED_FILES=$(git diff --name-only --diff-filter=M HEAD)

# Categorize changes
INTEGRATIONS_CHANGED=""
WORKFLOWS_CHANGED=""
API_CHANGED=""
MCPS_CHANGED=""
PLATFORM_CHANGED=""
RELEASES_CHANGED=""

for file in $CHANGED_FILES; do
    case $file in
        v3/integrations/*)
            INTEGRATIONS_CHANGED="$INTEGRATIONS_CHANGED $file"
            ;;
        v3/workflows/*)
            WORKFLOWS_CHANGED="$WORKFLOWS_CHANGED $file"
            ;;
        v3/api-reference/*)
            API_CHANGED="$API_CHANGED $file"
            ;;
        v3/mcps/*)
            MCPS_CHANGED="$MCPS_CHANGED $file"
            ;;
        v3/platform/*)
            PLATFORM_CHANGED="$PLATFORM_CHANGED $file"
            ;;
        v3/releases/*)
            RELEASES_CHANGED="$RELEASES_CHANGED $file"
            ;;
    esac
done

# Generate intelligent PR title and description
echo "📝 Generating PR details based on changes..."

# Determine primary change type
PRIMARY_TYPE=""
if [ -n "$INTEGRATIONS_CHANGED" ]; then
    PRIMARY_TYPE="integration"
elif [ -n "$WORKFLOWS_CHANGED" ]; then
    PRIMARY_TYPE="workflow"
elif [ -n "$API_CHANGED" ]; then
    PRIMARY_TYPE="api"
elif [ -n "$MCPS_CHANGED" ]; then
    PRIMARY_TYPE="mcp"
elif [ -n "$PLATFORM_CHANGED" ]; then
    PRIMARY_TYPE="platform"
elif [ -n "$RELEASES_CHANGED" ]; then
    PRIMARY_TYPE="release"
else
    PRIMARY_TYPE="docs"
fi

# Extract feature names from file paths and content
FEATURE_NAMES=""
for file in $NEW_FILES $MODIFIED_FILES; do
    if [[ "$file" == *.mdx ]] || [[ "$file" == *.md ]]; then
        # Extract title from frontmatter or filename
        if [ -f "$file" ]; then
            TITLE=$(grep -m1 "^title:" "$file" 2>/dev/null | sed 's/title: *"\([^"]*\)".*/\1/' | sed "s/title: *'\([^']*\)'.*/\1/" | sed 's/title: *//')
            if [ -n "$TITLE" ] && [ "$TITLE" != "title:" ]; then
                FEATURE_NAMES="$FEATURE_NAMES $TITLE"
            else
                # Fallback to filename
                BASENAME=$(basename "$file" .mdx)
                BASENAME=$(basename "$BASENAME" .md)
                FEATURE_NAMES="$FEATURE_NAMES $BASENAME"
            fi
        fi
    fi
done

# Clean up feature names
FEATURE_NAMES=$(echo "$FEATURE_NAMES" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | tr -s ' ')

# Generate PR title
if [ -n "$FEATURE_NAMES" ]; then
    FIRST_FEATURE=$(echo "$FEATURE_NAMES" | awk '{print $1}')
    if [ $(echo "$FEATURE_NAMES" | wc -w) -gt 1 ]; then
        PR_TITLE="docs(v3): Add documentation for $FIRST_FEATURE and related features"
    else
        PR_TITLE="docs(v3): Add $PRIMARY_TYPE documentation for $FIRST_FEATURE"
    fi
else
    PR_TITLE="docs(v3): Update $PRIMARY_TYPE documentation"
fi

# Generate detailed description
PR_DESCRIPTION="## Documentation Changes by $DEVELOPER_NAME

**Primary Change Type**: $PRIMARY_TYPE
**Files Changed**: $(echo "$CHANGED_FILES" | wc -w) files

### Changes Summary"

if [ -n "$NEW_FILES" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION
**New Documentation Added**:"
    for file in $NEW_FILES; do
        PR_DESCRIPTION="$PR_DESCRIPTION
- \`$file\`"
    done
fi

if [ -n "$MODIFIED_FILES" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION

**Documentation Updated**:"
    for file in $MODIFIED_FILES; do
        PR_DESCRIPTION="$PR_DESCRIPTION
- \`$file\`"
    done
fi

# Add section-specific details
if [ -n "$INTEGRATIONS_CHANGED" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION

### 🔌 Integration Documentation
Updated integration guides to help SaaS teams connect and automate with external platforms."
fi

if [ -n "$WORKFLOWS_CHANGED" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION

### ⚡ Workflow Documentation  
Added automation patterns to help teams streamline business processes between systems."
fi

if [ -n "$API_CHANGED" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION

### 🛠️ API Documentation
Enhanced API reference with production-ready examples and integration context."
fi

if [ -n "$MCPS_CHANGED" ]; then
    PR_DESCRIPTION="$PR_DESCRIPTION

### 🤖 MCP Documentation
Added AI-powered integration capabilities using Model Context Protocols."
fi

# Add standard quality checklist
PR_DESCRIPTION="$PR_DESCRIPTION

### ✅ Cobalt Standards Compliance
- [x] Follows v3 documentation structure
- [x] Uses Cobalt platform terminology consistently
- [x] Includes business value for SaaS teams
- [x] Provides production deployment guidance
- [x] Contains working, copy-paste code examples
- [x] Includes \"What's Next?\" sections for discovery

### 📊 Documentation Quality
- [x] All code examples tested and verified
- [x] Images properly placed in \`images/v3-images/\`
- [x] Internal links verified and functional  
- [x] Integration-specific troubleshooting included
- [x] 15-minute setup wins provided where applicable

### 🎯 Integration Focus
This documentation helps developers:
- Get integrations working quickly
- Deploy to production safely  
- Scale integrations reliably
- Maintain integrations efficiently

---
*Generated automatically by Cobalt Documentation Agent*"

# Commit changes with intelligent message
COMMIT_MSG="docs(v3): $PRIMARY_TYPE documentation updates

- Updated by: $DEVELOPER_NAME
- Files changed: $(echo "$CHANGED_FILES" | wc -w)
- Primary focus: $PRIMARY_TYPE documentation"

if [ -n "$FEATURE_NAMES" ]; then
    COMMIT_MSG="$COMMIT_MSG
- Features: $FEATURE_NAMES"
fi

git add .
git commit -m "$COMMIT_MSG"

# Push changes
git push origin "$CURRENT_BRANCH"

# Create PR using GitHub CLI if available
if command -v gh &> /dev/null; then
    echo "$PR_DESCRIPTION" | gh pr create \
        --title "$PR_TITLE" \
        --body-file - \
        --base main \
        --head "$CURRENT_BRANCH" \
        --label "documentation,v3,cobalt-agent"
    
    echo "✅ Intelligent PR created successfully!"
    echo "📋 Title: $PR_TITLE"
    echo "🏷️ Labels: documentation, v3, cobalt-agent"
else
    echo "📝 PR Details for Manual Creation:"
    echo "========================================="
    echo "Title: $PR_TITLE"
    echo ""
    echo "$PR_DESCRIPTION"
    echo ""
    echo "💡 Install GitHub CLI (gh) for automatic PR creation"
fi

cd ..

---