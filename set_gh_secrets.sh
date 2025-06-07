#!/bin/bash

# Simple script to set Docker secrets in the current GitHub repository

# --- Configuration ---
read -p "Docker Username: " DOCKER_USERNAME
read -p "Docker Repository (e.g., user/app): " DOCKER_REPOSITORY_NAME
read -s -p "Docker Password: " DOCKER_PASSWORD
echo


# --- Set secrets ---
gh secret set DOCKER_USERNAME -b"$DOCKER_USERNAME"
gh secret set DOCKER_PASSWORD -b"$DOCKER_PASSWORD"
gh secret set DOCKER_REPOSITORY_NAME -b"$DOCKER_REPOSITORY_NAME"

echo "✅ GitHub secrets set successfully."
