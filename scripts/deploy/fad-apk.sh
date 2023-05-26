#!/bin/bash
set -e
set -o pipefail

echo "🍿🎢🤖 Deploy APK for FAD"

cd android
fastlane android deploy_fad
cd ..
