#!/bin/bash
set -e
set -o pipefail

echo "🛒🎢🍏 Deploy IPA for STORE with flavor: $FLAVOR"

cd ios
fastlane ios deploy_testflight changelog_string:"$CHANGELOG_STRING" flavor:$FLAVOR
cd ..
