#!/bin/bash
set -e
set -o pipefail

echo "🍿🏗️🤖 Build APK for FAD"

flutter build apk $BUILD_NUMBER_STRING --flavor production --target lib/main_production.dart
