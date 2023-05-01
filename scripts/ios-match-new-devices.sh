#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

cd ios
$BUNDLER fastlane ios match_new_devices
