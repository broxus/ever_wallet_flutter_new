#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🤖 Build AAB for STORE with flavor $FLAVOR, target $TARGET_FILE"

flutter build appbundle $BUILD_NUMBER_STRING --flavor $FLAVOR --target $TARGET_FILE --dart-define=SENTRY_DSN=$SENTRY_DSN
