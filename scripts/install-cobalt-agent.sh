# Create install-cobalt-agent.sh for your team
cat > install-cobalt-agent.sh << 'EOF'
#!/bin/bash
# Cobalt Documentation Agent - Team Installer
# For internal use only

set -e

echo "🚀 Installing Cobalt Documentation Agent..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Please run this from your development repository root"
    exit 1
fi

# Clone the private repository
if [ -d "temp-cobalt-setup" ]; then
    rm -rf temp-cobalt-setup
fi

echo "📥 Cloning agent configuration..."
git clone git@github.com:abhishekjd/cobalt-docs-agent.git temp-cobalt-setup

# Copy configuration files
echo "📋 Installing configuration files..."
cp temp-cobalt-setup/config/.cursorrules .
cp -r temp-cobalt-setup/config/.cursor .
cp -r temp-cobalt-setup/scripts .

# Make scripts executable
chmod +x scripts/*.sh

# Clean up
rm -rf temp-cobalt-setup

echo ""
echo "✅ Cobalt Documentation Agent installed!"
echo ""
echo "🔧 Next steps:"
echo "1. Update scripts/sync-docs-repo.sh with your docs repository URL"
echo "2. Run: ./scripts/sync-docs-repo.sh"
echo "3. Open Cursor and test: @docs help me create a test guide"
echo ""
echo "📚 Happy documenting!"
EOF

chmod +x install-cobalt-agent.sh