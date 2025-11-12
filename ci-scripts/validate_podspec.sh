#!/bin/bash

set -euo pipefail

PODSPEC_PATH="PayTabsSDK.podspec"

source "$CM_ENV"

echo "Validating podspec..."
pod spec lint "$PODSPEC_PATH" --allow-warnings --skip-import-validation

echo "Podspec validation passed!"
