#!/bin/bash

set -euo pipefail

source "$CM_ENV"

if [[ -z "${NEW_VERSION:-}" ]]; then
  echo "Error: NEW_VERSION not set."
  exit 1
fi

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "Warning: GITHUB_TOKEN not set. Skipping git tag creation."
  echo "SKIP_TAG=true" >> "$CM_ENV"
  exit 0
fi

git config user.name "Codemagic"
git config user.email "codemagic@paytabs.com"

echo "Creating git tag $NEW_VERSION..."
git tag -a "$NEW_VERSION" -m "Release version $NEW_VERSION" || echo "Tag may already exist locally."

git remote set-url origin https://${GITHUB_TOKEN}@github.com/paytabscom/paytabs-ios-library-sample.git
git push origin "$NEW_VERSION" || echo "Tag may already exist on remote or push failed."
echo "Git tag created and pushed: $NEW_VERSION"
echo "SKIP_TAG=false" >> "$CM_ENV"
