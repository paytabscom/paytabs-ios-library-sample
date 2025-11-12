#!/bin/bash
set -euo pipefail

: "${XCODE_WORKSPACE:?XCODE_WORKSPACE not set}"
: "${XCODE_SCHEME:?XCODE_SCHEME not set}"

xcodebuild \
  -workspace "$XCODE_WORKSPACE" \
  -scheme "$XCODE_SCHEME" \
  -configuration Release \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  clean archive \
  -archivePath $CM_BUILD_DIR/build/App.xcarchive \
  -allowProvisioningUpdates \
  IPHONEOS_DEPLOYMENT_TARGET=15.0 \
  CODE_SIGN_STYLE=Automatic \
  DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM
