#!/bin/bash

# Exit on any error
set -e

# Function to check for dependencies
check_dependencies() {
  command -v gh >/dev/null 2>&1 || { echo >&2 "❌ GitHub CLI (gh) is not installed. Aborting."; exit 1; }
  command -v git >/dev/null 2>&1 || { echo >&2 "❌ Git is not installed. Aborting."; exit 1; }
  command -v jq >/dev/null 2>&1 || { echo >&2 "❌ jq is required but not installed. Install it and try again."; exit 1; }
}

# Run dependency check
check_dependencies

# Prompt for input
read -p "🔹 Enter the name of your new GitHub repository: " REPO_NAME
read -p "🔹 Enter a description (optional): " REPO_DESC
read -p "🔹 Make repository public or private? (public/private): " VISIBILITY

# Validate visibility
if [[ "$VISIBILITY" != "public" && "$VISIBILITY" != "private" ]]; then
  echo "❌ Invalid visibility option. Use 'public' or 'private'."
  exit 1
fi

# Check GitHub authentication
if ! gh auth status >/dev/null 2>&1; then
  echo "🔑 You need to authenticate with GitHub first."
  gh auth login
fi

# Get GitHub username
USERNAME=$(gh api user | jq -r .login)

# Create repo on GitHub
echo "🚀 Creating GitHub repo..."
gh repo create "$USERNAME/$REPO_NAME" --description "$REPO_DESC" --"$VISIBILITY" --confirm

# Initialize local repo and push
echo "📁 Setting up local repository..."
git init
echo "# $REPO_NAME" > README.md
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin "git@github.com:$USERNAME/$REPO_NAME.git"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$USERNAME
git push -u origin main

echo "✅ Done! Repository '$REPO_NAME' created and pushed to GitHub."
