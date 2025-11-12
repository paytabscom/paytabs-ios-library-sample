#!/bin/bash
set -euo pipefail

cat > ExportOptions.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key>
  <string>${EXPORT_METHOD}</string>
  <key>signingStyle</key>
  <string>automatic</string>
  <key>stripSwiftSymbols</key>
  <true/>
  <key>uploadSymbols</key>
  <true/>
</dict>
</plist>
PLIST

xcodebuild -exportArchive \
  -archivePath $CM_BUILD_DIR/build/App.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath $CM_BUILD_DIR/build/export
