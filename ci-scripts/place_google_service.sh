#!/bin/bash
set -euo pipefail

if [[ -n "${GOOGLE_SERVICE_INFO_BASE64:-}" ]]; then
  echo "Decoding GOOGLE_SERVICE_INFO_BASE64 into GoogleService-Info.plist"
  echo "$GOOGLE_SERVICE_INFO_BASE64" | base64 --decode > sample-swiftui/sample-swiftui/GoogleService-Info.plist
else
  echo "GOOGLE_SERVICE_INFO_BASE64 not set - assuming file is already committed."
fi
