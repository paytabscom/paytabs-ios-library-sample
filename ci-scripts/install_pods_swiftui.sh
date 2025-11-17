#!/bin/bash
set -euo pipefail
cd sample-swiftui
rm -rf Pods
rm -f Podfile.lock
pod install --repo-update
