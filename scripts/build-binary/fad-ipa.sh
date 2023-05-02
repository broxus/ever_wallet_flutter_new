#!/bin/bash
set -e
set -o pipefail

echo "🍿🏗️🍏 Build IPA for FAD"

flutter build ipa --release --export-options-plist ios/export_options_adhoc.plist $BUILD_NUMBER_STRING --flavor production --target lib/main_production.dart
