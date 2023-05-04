#!/bin/bash
set -e
set -o pipefail

source scripts/get-build-number.sh
source scripts/get-changelog.sh

source scripts/build-binary/fad-ipa.sh
source scripts/build-binary/fad-apk.sh

source scripts/deploy/fad-ipa.sh
source scripts/deploy/fad-apk.sh


source scripts/build-binary/store-ipa.sh
source scripts/build-binary/store-aab.sh

source scripts/deploy/store-ipa.sh
source scripts/deploy/store-aab.sh
