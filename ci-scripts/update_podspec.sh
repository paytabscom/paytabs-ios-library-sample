#!/bin/bash

set -euo pipefail

PODSPEC_PATH="PayTabsSDK.podspec"

source "$CM_ENV"

if [[ -z "${NEW_VERSION:-}" ]]; then
  echo "Error: NEW_VERSION not set. Did you run extract_version.sh?"
  exit 1
fi

echo "Updating podspec version to $NEW_VERSION..."
if [[ "$(uname)" == "Darwin" ]]; then
  sed -i '' "s/s\.version[[:space:]]*=[[:space:]]*['\"][^'\"]*['\"]/s.version      = \"$NEW_VERSION\"/" "$PODSPEC_PATH"
else
  sed -i "s/s\.version[[:space:]]*=[[:space:]]*['\"][^'\"]*['\"]/s.version      = \"$NEW_VERSION\"/" "$PODSPEC_PATH"
fi

UPDATED_VERSION=$(grep -E '^\s*s\.version\s*=' "$PODSPEC_PATH" | sed -E 's/.*s\.version[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/' | head -n1)
echo "Updated podspec version: $UPDATED_VERSION"
if [[ "$UPDATED_VERSION" != "$NEW_VERSION" ]]; then
  echo "Error: Version update failed."
  exit 1
fi

git config user.name "Codemagic"
git config user.email "codemagic@paytabs.com"
git add "$PODSPEC_PATH"
git commit -m "Bump podspec version to $NEW_VERSION" || echo "No changes to commit or already committed."

if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  git remote set-url origin https://${GITHUB_TOKEN}@github.com/paytabscom/paytabs-ios-library-sample.git
fi

git push origin HEAD || echo "Push failed or already pushed."
