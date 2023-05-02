#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

MATCH_GIT_PRIVATE_KEY="../secrets/ios-provisioning-key"

cd ios
fastlane ios match_assure
