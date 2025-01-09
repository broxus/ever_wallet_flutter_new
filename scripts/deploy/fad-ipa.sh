#!/bin/bash
set -e
set -o pipefail

echo "🍿🎢🍏 Deploy IPA for FAD with flavor: $FLAVOR"

cd ios
fastlane ios deploy_fad flavor:$FLAVOR
cd ..