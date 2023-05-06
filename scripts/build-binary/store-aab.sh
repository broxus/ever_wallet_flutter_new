#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🤖 Build AAB for STORE"

flutter build appbundle $BUILD_NUMBER_STRING --flavor production --target lib/main_production.dart
