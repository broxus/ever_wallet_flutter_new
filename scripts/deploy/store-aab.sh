#!/bin/bash
set -e
set -o pipefail

echo "🛒🎢🤖 Deploy AAB for STORE with flavor: $FLAVOR"

cd android
fastlane android deploy_google_play_internal flavor: $FLAVOR
cd ..
