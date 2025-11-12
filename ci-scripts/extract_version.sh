#!/bin/bash

set -euo pipefail

PODSPEC_PATH="PayTabsSDK.podspec"

if [[ ! -f "$PODSPEC_PATH" ]]; then
  echo "Error: $PODSPEC_PATH not found."
  exit 1
fi

CURRENT_VERSION=$(grep -E '^\s*s\.version\s*=' "$PODSPEC_PATH" | sed -E 's/.*s\.version[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/' | head -n1)
if [[ -z "$CURRENT_VERSION" ]]; then
  echo "Error: Failed to extract current version from $PODSPEC_PATH"
  exit 1
fi

echo "Current version: $CURRENT_VERSION"
echo "CURRENT_VERSION=$CURRENT_VERSION" >> "$CM_ENV"

IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

echo "New version: $NEW_VERSION"
echo "NEW_VERSION=$NEW_VERSION" >> "$CM_ENV"
