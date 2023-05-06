#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

export MATCH_GIT_PRIVATE_KEY="../secrets/ios-provisioning-key"

cd ios
fastlane ios match_assure
