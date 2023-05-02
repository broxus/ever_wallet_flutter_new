#!/bin/bash
set -e
set -o pipefail

source scripts/get-build-number.sh
source scripts/get-changelog.sh

source scripts/build/fad-ipa.sh
source scripts/build/fad-apk.sh

source scripts/deploy/fad-ipa.sh
source scripts/deploy/fad-apk.sh


