#!/bin/bash
set -e
set -o pipefail

echo "🛒🎢🍏 Deploy IPA for STORE"

cd ios
fastlane ios deploy_testflight changelog_string:"$CHANGELOG_STRING"
cd ..
