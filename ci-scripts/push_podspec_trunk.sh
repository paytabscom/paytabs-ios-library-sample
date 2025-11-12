#!/bin/bash

set -euo pipefail

PODSPEC_PATH="PayTabsSDK.podspec"

source "$CM_ENV"

if [[ "${SKIP_TRUNK_PUSH:-false}" == "true" ]]; then
  echo "Skipping trunk push (credentials not set)."
  exit 0
fi

echo "Pushing podspec to CocoaPods trunk..."
pod trunk push "$PODSPEC_PATH" --allow-warnings --skip-import-validation

echo "Podspec pushed successfully!"
