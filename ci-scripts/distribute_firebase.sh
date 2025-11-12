#!/bin/bash
set -euo pipefail

: "${FIREBASE_APP_ID:?FIREBASE_APP_ID not set}"
: "${FIREBASE_GROUPS:?FIREBASE_GROUPS not set}"

if [[ -z "${FIREBASE_TOKEN:-}" ]]; then
  echo "Error: FIREBASE_TOKEN not set. Add it to your Codemagic environment group."
  exit 1
fi

IPA_PATH=$(ls $CM_BUILD_DIR/build/export/*.ipa | head -n1)
if [[ -z "${IPA_PATH}" ]]; then
  echo "Error: .ipa not found in export folder."
  exit 1
fi

# Distribute to Firebase App Distribution
# The --token flag authenticates the Firebase CLI
echo "Distributing IPA to Firebase App Distribution..."
firebase appdistribution:distribute "$IPA_PATH" \
  --app "$FIREBASE_APP_ID" \
  --groups "$FIREBASE_GROUPS" \
  --release-notes "${RELEASE_NOTES:-Automated build from Codemagic}" \
  --token "$FIREBASE_TOKEN"
