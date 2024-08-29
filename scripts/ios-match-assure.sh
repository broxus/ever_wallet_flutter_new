#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

export MATCH_GIT_PRIVATE_KEY="../secrets/ios-provisioning-key"

DEPLOY_TARGET=$1
export DEPLOY_TARGET

echo "DEPLOY_TARGET is set to: $DEPLOY_TARGET"

cd ios
fastlane ios match_assure
