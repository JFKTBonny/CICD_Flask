#!/bin/bash
set -x

# Set GitHub account details
export GITHUB_USERNAME="JFKTBonny"
export GITHUB_EMAIL_ADDRESS="jkamkotoyip@yahoo.com"
export GITHUB_REPOSITORY_NAME="CICD_Flask"

# Create GitHub repo only if it doesn't already exist
if ! gh repo view "${GITHUB_USERNAME}/${GITHUB_REPOSITORY_NAME}" > /dev/null 2>&1; then
  gh repo create "${GITHUB_REPOSITORY_NAME}" \
      --public \
      --description "CI/CD with ArgoCD, Helm and GitHub Actions" \
      --source=. \
      --remote=origin
else
  echo "Repository already exists on GitHub."
  git remote add origin git@github.com:${GITHUB_USERNAME}/${GITHUB_REPOSITORY_NAME}.git 2>/dev/null || \
  git remote set-url origin git@github.com:${GITHUB_USERNAME}/${GITHUB_REPOSITORY_NAME}.git
fi

# Git setup in current directory
git init
git config --global user.email "${GITHUB_EMAIL_ADDRESS}"
git config --global user.name "${GITHUB_USERNAME}"

# Download Python .gitignore file (if not already present)
[ -f .gitignore ] || curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore

# Commit and push to GitHub
git add .
git commit -m "first commit"
git branch -M main
git push -u origin main
