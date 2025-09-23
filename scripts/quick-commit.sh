#!/bin/bash
# quick-commit.sh - Fixed version with proper staging

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

DOCS_DIR="mintlify-docs"
DEVELOPER_NAME=$(git config user.name 2>/dev/null | tr '[:upper:]' '[:lower:]' | tr ' ' '-' || echo "unknown")
DOCS_BRANCH="docs/${DEVELOPER_NAME}"

echo "⚡ Quick Commit - Work in Progress"
echo "Developer: $DEVELOPER_NAME"
echo ""

# Check if documentation directory exists
if [ ! -d "$DOCS_DIR" ]; then
    print_error "mintlify-docs directory not found"
    echo "💡 Run: ./scripts/sync-docs-repo.sh first"
    exit 1
fi

cd "$DOCS_DIR"

# Ensure we're on the developer's branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$DOCS_BRANCH" ]; then
    print_status "Switching to your documentation branch: $DOCS_BRANCH"
    
    # Check if branch exists
    if git show-ref --verify --quiet "refs/heads/$DOCS_BRANCH" 2>/dev/null; then
        git checkout "$DOCS_BRANCH"
        print_success "Switched to $DOCS_BRANCH"
    else
        print_error "Your documentation branch doesn't exist: $DOCS_BRANCH"
        echo "💡 Run: ./scripts/setup-docs-workspace.sh first"
        cd ..
        exit 1
    fi
fi

# Check for ANY changes (staged OR unstaged)
if git diff --quiet HEAD && git diff --cached --quiet; then
    print_success "No changes to commit. Documentation is up to date."
    cd ..
    exit 0
fi

print_status "Analyzing changes..."

# Show what's changed (before staging)
CHANGED_FILES=$(git diff --name-only HEAD)
STAGED_FILES=$(git diff --name-only --cached)

# Add all changes to staging area
print_status "Staging all changes..."
git add .

# Now get the complete list of staged files
ALL_STAGED=$(git diff --name-only --cached)
ADDED_FILES=$(git diff --name-only --diff-filter=A --cached)
MODIFIED_FILES=$(git diff --name-only --diff-filter=M --cached)
DELETED_FILES=$(git diff --name-only --diff-filter=D --cached)

echo "📋 Changes staged for commit:"
if [ -n "$ADDED_FILES" ]; then
    echo "  📄 New files:"
    echo "$ADDED_FILES" | sed 's/^/    /'
fi

if [ -n "$MODIFIED_FILES" ]; then
    echo "  ✏️  Modified files:"
    echo "$MODIFIED_FILES" | sed 's/^/    /'
fi

if [ -n "$DELETED_FILES" ]; then
    echo "  🗑️  Deleted files:"
    echo "$DELETED_FILES" | sed 's/^/    /'
fi

echo ""

# Determine commit type based on files changed
COMMIT_TYPE="docs"
COMMIT_SCOPE=""

# Analyze file paths to determine scope and type
for file in $ALL_STAGED; do
    case "$file" in
        v3/integrations/*)
            COMMIT_SCOPE="integration"
            ;;
        v3/workflows/*)
            COMMIT_SCOPE="workflow"
            ;;
        v3/api-reference/*)
            COMMIT_SCOPE="api"
            ;;
        v3/mcps/*)
            COMMIT_SCOPE="mcp"
            ;;
        v3/platform/*)
            COMMIT_SCOPE="platform"
            ;;
        v3/releases/*)
            COMMIT_SCOPE="release"
            ;;
        v3/welcome/*)
            COMMIT_SCOPE="welcome"
            ;;
        images/v3-images/*)
            COMMIT_SCOPE="images"
            ;;
    esac
done

# Build commit message
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
COMMIT_MSG_BASE="$COMMIT_TYPE"

if [ -n "$COMMIT_SCOPE" ]; then
    COMMIT_MSG_BASE="$COMMIT_TYPE($COMMIT_SCOPE)"
fi

# Count files
TOTAL_FILES=$(echo "$ALL_STAGED" | wc -l | tr -d ' ')

# Create descriptive commit message
if [ -n "$ADDED_FILES" ] && [ -n "$MODIFIED_FILES" ]; then
    CHANGE_DESCRIPTION="Add and update documentation"
elif [ -n "$ADDED_FILES" ]; then
    CHANGE_DESCRIPTION="Add new documentation"
elif [ -n "$MODIFIED_FILES" ]; then
    CHANGE_DESCRIPTION="Update documentation"
elif [ -n "$DELETED_FILES" ]; then
    CHANGE_DESCRIPTION="Remove documentation"
else
    CHANGE_DESCRIPTION="Update documentation"
fi

COMMIT_MSG="$COMMIT_MSG_BASE: $CHANGE_DESCRIPTION - WIP

Work in progress commit by $DEVELOPER_NAME
Time: $TIMESTAMP
Files changed: $TOTAL_FILES

Changes:
$(echo "$ALL_STAGED" | sed 's/^/- /')

Note: This is a work-in-progress commit. 
Use ./scripts/create-docs-pr.sh when ready for review."

# Option to add custom message
echo "💬 Commit message preview:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$COMMIT_MSG_BASE: $CHANGE_DESCRIPTION - WIP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "Add custom message? (y/N): " ADD_CUSTOM
if [[ "$ADD_CUSTOM" =~ ^[Yy]$ ]]; then
    echo "Enter custom description (press Enter for default):"
    read -r CUSTOM_DESC
    
    if [ -n "$CUSTOM_DESC" ]; then
        COMMIT_MSG="$COMMIT_MSG_BASE: $CUSTOM_DESC - WIP

Work in progress commit by $DEVELOPER_NAME
Time: $TIMESTAMP
Files changed: $TOTAL_FILES

Custom description: $CUSTOM_DESC

Changes:
$(echo "$ALL_STAGED" | sed 's/^/- /')

Note: This is a work-in-progress commit.
Use ./scripts/create-docs-pr.sh when ready for review."
    fi
fi

# Show staging summary
echo "📦 Final staging summary:"
git diff --cached --stat

echo ""
print_status "Creating commit..."

# Create the commit
git commit -m "$COMMIT_MSG"

print_success "Committed changes locally!"

# Push to remote
print_status "Pushing to remote branch: $DOCS_BRANCH"

# Check if remote branch exists
if git ls-remote --heads origin "$DOCS_BRANCH" | grep -q "$DOCS_BRANCH"; then
    git push origin "$DOCS_BRANCH"
    print_success "Pushed to remote successfully!"
else
    # First time pushing this branch
    git push -u origin "$DOCS_BRANCH"
    print_success "Created and pushed remote branch: $DOCS_BRANCH"
fi

echo ""
echo "✅ Quick commit completed!"
echo ""
echo "📊 Summary:"
echo "  Branch: $DOCS_BRANCH"
echo "  Files: $TOTAL_FILES changed"
echo "  Type: $CHANGE_DESCRIPTION"
echo ""
echo "💡 Next steps:"
echo "  • Continue working on documentation"
echo "  • Run ./scripts/quick-commit.sh again for more WIP commits"
echo "  • Run ./scripts/create-docs-pr.sh when ready for review"
echo ""
echo "🔗 View your branch:"
echo "  git log --oneline -5"

cd ..

# Optional: Show recent commit history
echo ""
echo "📝 Recent commits on your branch:"
cd "$DOCS_DIR"
git log --oneline -3 --color=always | sed 's/^/  /'
cd ..