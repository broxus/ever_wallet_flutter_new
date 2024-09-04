#!/bin/bash
set -e
set -o pipefail

if [ -z "$SENTRY_DSN" ]; then
    exit 1
fi

export SENTRY_DSN

deploy_target="$1"
build_number="$2"

if [ -z "$build_number" ]; then
    echo "Error: Build number is not specified."
    exit 1
fi

BUILD_NUMBER_STRING="--build-number=$build_number"
export BUILD_NUMBER_STRING

source scripts/get-changelog.sh

case "$deploy_target" in
  "ios_fad")
    source scripts/build-binary/fad-ipa.sh
    source scripts/deploy/fad-ipa.sh
    ;;
  "ios_store")
    source scripts/build-binary/store-ipa.sh
    source scripts/deploy/store-ipa.sh
    ;;
  "android_fad")
    source scripts/build-binary/fad-apk.sh
    source scripts/deploy/fad-apk.sh
    ;;
  "android_store")
    source scripts/build-binary/store-aab.sh
    source scripts/deploy/store-aab.sh
    ;;
  *)
    echo "Unknown deploy target: $deploy_target"
    exit 1
    ;;
esac