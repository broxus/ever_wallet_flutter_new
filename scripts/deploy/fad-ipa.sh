#!/bin/bash
set -e
set -o pipefail

echo "🍿🎢🍏 Deploy IPA for FAD"

cd ios
fastlane ios deploy_fad
cd ..
