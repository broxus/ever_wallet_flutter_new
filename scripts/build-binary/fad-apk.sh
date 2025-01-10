#!/bin/bash
set -e
set -o pipefail

echo "🍿🏗️🤖 Build APK for FAD with flavor $FLAVOR, target $TARGET_FILE"

flutter build apk $BUILD_NUMBER_STRING --flavor $FLAVOR --target $TARGET_FILE --dart-define=SENTRY_DSN=$SENTRY_DSN
