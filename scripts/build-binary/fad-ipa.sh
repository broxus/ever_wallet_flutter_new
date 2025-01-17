#!/bin/bash
set -e
set -o pipefail

echo "🍿🏗️🍏 Build IPA for FAD with flavor $FLAVOR, target $TARGET_FILE"

flutter build ipa --release --export-options-plist ios/export_options_adhoc.plist $BUILD_NUMBER_STRING --flavor $FLAVOR --target $TARGET_FILE --dart-define=SENTRY_DSN=$SENTRY_DSN
