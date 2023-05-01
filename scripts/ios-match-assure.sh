#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

cd ios
fastlane ios match_assure
