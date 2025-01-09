#!/bin/bash
set -e
set -o pipefail

echo "🍿🎢🤖 Deploy APK for FAD with flavor: $FLAVOR"

cd android
fastlane android deploy_fad flavor:$FLAVOR
cd ..
