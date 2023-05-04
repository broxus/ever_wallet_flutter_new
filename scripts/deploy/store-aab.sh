#!/bin/bash
set -e
set -o pipefail

echo "🛒🎢🤖 Deploy AAB for STORE"

cd android
fastlane android deploy_google_play_internal
cd ..
