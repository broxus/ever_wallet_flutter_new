#!/bin/bash
set -e
set -o pipefail

export SENTRY_DSN

source scripts/get-build-number.sh
source scripts/get-changelog.sh

source scripts/build-binary/store-ipa.sh

source scripts/deploy/store-ipa.sh