#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

echo "fastlane ios match_assure"
echo $BUNDLER

cd ios
$BUNDLER fastlane ios match_assure
