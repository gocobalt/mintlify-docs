#!/bin/bash
# validate-docs.sh
# Validates Cobalt documentation setup and quality

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

echo "🔍 Validating Cobalt Documentation Agent Setup"
echo "Developer: $DEVELOPER_NAME"
echo ""

# Check if documentation directory exists
if [ ! -d "$DOCS_DIR" ]; then
    print_error "mintlify-docs directory not found"
    echo "💡 Run: ./scripts/sync-docs-repo.sh"
    exit 1
fi

cd "$DOCS_DIR"

print_status "Checking repository setup..."

# Check if developer branch exists
if git show-ref --verify --quiet "refs/heads/$DOCS_BRANCH" 2>/dev/null; then
    print_success "Your documentation branch exists: $DOCS_BRANCH"
else
    print_warning "Your documentation branch not found: $DOCS_BRANCH"
    echo "💡 Run: ./scripts/setup-docs-workspace.sh"
fi

# Check remote repository connection
if git remote get-url origin >/dev/null 2>&1; then
    REMOTE_URL=$(git remote get-url origin)
    print_success "Connected to remote: $REMOTE_URL"
else
    print_warning "No remote repository configured"
fi

print_status "Validating v3 documentation structure..."

# Check and create v3 structure
v3_dirs=(
    "v3/welcome"
    "v3/platform" 
    "v3/workflows"
    "v3/mcps"
    "v3/api-reference"
    "v3/integrations"
    "v3/releases"
)

structure_issues=0
for dir in "${v3_dirs[@]}"; do
    if [ -d "$dir" ]; then
        print_success "$dir exists"
    else
        print_warning "$dir missing"
        mkdir -p "$dir"
        print_success "Created $dir"
        structure_issues=$((structure_issues + 1))
    fi
done

# Check images directory
if [ -d "images/v3-images" ]; then
    print_success "v3 images directory exists"
else
    print_warning "v3 images directory missing"
    mkdir -p "images/v3-images"
    print_success "Created images/v3-images"
    structure_issues=$((structure_issues + 1))
fi

if [ $structure_issues -gt 0 ]; then
    print_warning "Fixed $structure_issues structure issues"
fi

print_status "Checking documentation quality..."

# Validate existing documentation files
doc_files=$(find v3 -name "*.mdx" -o -name "*.md" 2>/dev/null || true)
total_files=0
issues_found=0

if [ -n "$doc_files" ]; then
    echo "$doc_files" | while IFS= read -r file; do
        if [ -f "$file" ]; then
            total_files=$((total_files + 1))
            echo "📄 Checking: $file"
            
            # Check frontmatter
            if grep -q "^title:" "$file" && grep -q "^description:" "$file"; then
                echo "  ✅ Has proper frontmatter"
            else
                echo "  ⚠️  Missing title/description in frontmatter"
                issues_found=$((issues_found + 1))
            fi
            
            # Check for Info blocks (Cobalt standard)
            if grep -q "<Info>" "$file"; then
                echo "  ✅ Has Info block"
            else
                echo "  💡 Consider adding Info block with Goal/Time/Prerequisites"
            fi
            
            # Check for What's Next section
            if grep -qi "what.*next" "$file"; then
                echo "  ✅ Has What's Next section"
            else
                echo "  💡 Should include What's Next section"
            fi
            
            # Check for Steps component (for guides)
            if grep -q "<Steps>" "$file"; then
                echo "  ✅ Uses Steps component"
            fi
            
            # Check for code examples
            if grep -q "```" "$file"; then
                echo "  ✅ Contains code examples"
            fi
            
            # Check for business value (Cobalt focus)
            if grep -qi "saas\|business\|integration\|production" "$file"; then
                echo "  ✅ Includes business/integration context"
            else
                echo "  💡 Consider adding business value for SaaS teams"
            fi
            
            echo ""
        fi
    done
else
    print_status "No documentation files found yet"
fi

print_status "Checking mint.json configuration..."

# Validate mint.json if it exists
if [ -f "mint.json" ]; then
    if command -v jq &> /dev/null; then
        if jq empty mint.json 2>/dev/null; then
            print_success "mint.json is valid JSON"
        else
            print_error "mint.json has syntax errors"
            issues_found=$((issues_found + 1))
        fi
    else
        print_warning "jq not installed, skipping mint.json validation"
        echo "💡 Install jq for JSON validation: brew install jq / apt install jq"
    fi
else
    print_warning "mint.json not found"
fi

print_status "Checking for common issues..."

# Check for TODO/FIXME comments
todo_count=$(find v3 -name "*.md" -o -name "*.mdx" 2>/dev/null | xargs grep -c "TODO\|FIXME" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
if [ "$todo_count" -gt 0 ]; then
    print_warning "Found $todo_count TODO/FIXME comments"
    echo "💡 Consider resolving these before creating PRs"
else
    print_success "No TODO/FIXME comments found"
fi

# Check for broken internal links (basic check)
print_status "Checking internal links..."
broken_links=0
if [ -n "$doc_files" ]; then
    echo "$doc_files" | while IFS= read -r file; do
        if [ -f "$file" ]; then
            # Look for markdown links to other docs
            grep -n "\](/" "$file" 2>/dev/null | while IFS= read -r link_line; do
                link_path=$(echo "$link_line" | sed -n 's/.*](\([^)]*\)).*/\1/p')
                if [[ "$link_path" == /* ]]; then
                    # Remove leading slash and check if file exists
                    check_path="${link_path#/}"
                    if [ ! -f "$check_path" ] && [ ! -f "${check_path}.mdx" ] && [ ! -f "${check_path}.md" ]; then
                        echo "  ⚠️  Potential broken link in $file: $link_path"
                        broken_links=$((broken_links + 1))
                    fi
                fi
            done
        fi
    done
fi

print_status "Checking Mintlify components..."

# Check for proper Mintlify component usage
if [ -n "$doc_files" ]; then
    echo "$doc_files" | while IFS= read -r file; do
        if [ -f "$file" ]; then
            # Check for unclosed components
            open_tags=$(grep -o "<[A-Z][^>]*>" "$file" 2>/dev/null | grep -v "/>" | wc -l)
            close_tags=$(grep -o "</[A-Z][^>]*>" "$file" 2>/dev/null | wc -l)
            
            if [ "$open_tags" -ne "$close_tags" ] && [ "$open_tags" -gt 0 ]; then
                echo "  ⚠️  Potential unclosed components in $file"
            fi
        fi
    done
fi

cd ..

print_status "Checking Cursor agent configuration..."

# Check if agent configuration exists
if [ -f ".cursorrules" ]; then
    print_success ".cursorrules file exists"
else
    print_error ".cursorrules file missing"
    echo "💡 This is required for @docs command to work"
fi

if [ -f ".cursor/docs-agent-config.md" ]; then
    print_success "Docs agent configuration exists"
else
    print_error "Docs agent configuration missing"
    echo "💡 .cursor/docs-agent-config.md is required"
fi

if [ -f ".cursor/mintlify-standards.md" ]; then
    print_success "Mintlify standards configuration exists"
else
    print_warning "Mintlify standards configuration missing"
    echo "💡 .cursor/mintlify-standards.md provides component guidelines"
fi

echo ""
echo "📊 Validation Summary"
echo "===================="

if [ $issues_found -eq 0 ] && [ $structure_issues -eq 0 ]; then
    print_success "All validations passed! 🎉"
    echo ""
    echo "✅ Repository structure is correct"
    echo "✅ Documentation quality looks good"
    echo "✅ Agent configuration is in place"
    echo ""
    echo "🚀 You're ready to create great Cobalt documentation!"
else
    echo "Issues found: $issues_found documentation issues, $structure_issues structure issues"
    echo ""
    echo "📋 Recommendations:"
    [ $issues_found -gt 0 ] && echo "• Review documentation files for missing frontmatter"
    [ $structure_issues -gt 0 ] && echo "• v3 structure has been auto-corrected"
    echo "• Use @docs command in Cursor to create new documentation"
    echo "• Run ./scripts/create-docs-pr.sh when ready to submit"
fi

echo ""
echo "💡 Next Steps:"
echo "1. Use @docs in Cursor to create documentation"
echo "2. Run ./scripts/create-docs-pr.sh to submit changes"
echo "3. Check ./scripts/setup-docs-workspace.sh if branch issues"
echo ""
echo "📚 Happy documenting with Cobalt standards!"