#!/bin/bash
# Deploy PlugNPlay to GitHub Pages
# Run from /Users/KOOCHI/Desktop/plugnplay-live

set -e

if [ ! -f "index.html" ]; then
    echo "Error: Run from /Users/KOOCHI/Desktop/plugnplay-live"
    exit 1
fi

# Configure git
git config --global user.email "hermes@example.com" 2>/dev/null || true
git config --global user.name "Hermes Deploy" 2>/dev/null || true

# Initialize repo if needed
if [ ! -d .git ]; then
    git init
fi

# Set remote
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/wallatozed-cloud/plugnplay.git

# Add .nojekyll to prevent Jekyll processing
touch .nojekyll
git add .nojekyll 2>/dev/null || true

# Commit
git add -A
git commit -m "Deploy PlugNPlay v$(date +%Y%m%d%H%M%S)" --allow-empty

# Try to push
echo "Attempting to push to GitHub..."
git push origin main --force 2>&1 || {
    echo ""
    echo "=== DEPLOYMENT HELP ==="
    echo "GitHub authentication required."
    echo ""
    echo "Option 1: Set up Personal Access Token"
    echo "  1. Go to https://github.com/settings/tokens"
    echo "  2. Generate new token (no expiration)"
    echo "  3. Run: git push https://<TOKEN>@github.com/wallatozed-cloud/plugnplay.git main --force"
    echo ""
    echo "Option 2: Manual upload via GitHub web:"
    echo "  1. Create repo: https://github.com/wallatozed-cloud/plugnplay/new"
    echo "  2. Click 'Add file' → 'Upload files'"
    echo "  3. Drag all files from /Users/KOOCHI/Desktop/plugnplay-live/"
    echo "  4. Enable GitHub Pages in Settings → Pages"
    echo ""
    exit 1
}

echo "✓ Deploy successful!"
echo "Site: https://wallatozed-cloud.github.io/plugnplay/"