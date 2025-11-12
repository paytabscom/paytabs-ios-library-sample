#!/bin/bash

set -euo pipefail

if [[ -z "${COCOAPODS_USERNAME:-}" ]] || [[ -z "${COCOAPODS_PASSWORD:-}" ]]; then
  echo "Warning: COCOAPODS_USERNAME or COCOAPODS_PASSWORD not set. Skipping trunk push."
  echo "SKIP_TRUNK_PUSH=true" >> "$CM_ENV"
  exit 0
fi

echo "Setting up CocoaPods trunk authentication..."
cat <<NETRC > ~/.netrc
machine trunk.cocoapods.org
  login $COCOAPODS_USERNAME
  password $COCOAPODS_PASSWORD
NETRC
chmod 0600 ~/.netrc

echo "SKIP_TRUNK_PUSH=false" >> "$CM_ENV"
