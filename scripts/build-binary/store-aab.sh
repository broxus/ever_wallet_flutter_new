#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🤖 Build AAB for STORE with flavor: $FLAVOR"

flutter build appbundle $BUILD_NUMBER_STRING --flavor $FLAVOR --target lib/main_production.dart --dart-define=SENTRY_DSN=$SENTRY_DSN
