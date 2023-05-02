#!/bin/bash
set -e
set -o pipefail

source scripts/get-build-number.sh
source scripts/get-changelog.sh

source scripts/build/store-ipa.sh
source scripts/build/store-aab.sh

source scripts/deploy/store-ipa.sh
source scripts/deploy/store-aab.sh
