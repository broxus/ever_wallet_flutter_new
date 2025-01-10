#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🍏 Build IPA for STORE with flavor: $FLAVOR"

flutter build ipa --release --export-options-plist ios/export_options_appstore.plist $BUILD_NUMBER_STRING --flavor $FLAVOR --target lib/main_production.dart --dart-define=SENTRY_DSN=$SENTRY_DSN