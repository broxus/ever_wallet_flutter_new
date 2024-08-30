#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🍏 Build IPA for STORE"

flutter build ipa --release --export-options-plist ios/export_options_appstore.plist $BUILD_NUMBER_STRING --flavor production --target lib/main_production.dart --dart-define=SENTRY_DSN=$SENTRY_DSN

IPA_PATH=$(find build/ios/ipa -name "*.ipa" | head -n 1)
if [ -f "$IPA_PATH" ]; then
  echo "Created IPA file: $IPA_PATH"
else
  echo "Error: IPA file not found!"
  exit 1
fi