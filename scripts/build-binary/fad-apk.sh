#!/bin/bash
set -e
set -o pipefail

echo "🍿🏗️🤖 Build APK for FAD with flavor: $FLAVOR"

flutter build apk $BUILD_NUMBER_STRING --flavor $FLAVOR --target lib/main_production.dart --dart-define=SENTRY_DSN=$SENTRY_DSN
