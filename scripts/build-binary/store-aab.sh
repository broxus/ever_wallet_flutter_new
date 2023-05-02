#!/bin/bash
set -e
set -o pipefail

echo "🛒🏗️🤖 Build AAB for STORE"

flutter build appbundle $build_number_string --flavor production --target lib/main_production.dart
