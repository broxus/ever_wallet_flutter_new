#!/bin/bash
set -e
set -o pipefail

deploy_target="$1"
build_number="$2"

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$deploy_target" == "ios_store" || "$deploy_target" == "android_store" ]]; then
  if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🚫 Error: Deployment to the store is only allowed from the 'main' branch."
    exit 1
  fi
fi

if [ -f ./secrets/sentry-dsn.txt ]; then
    SENTRY_DSN=$(cat ./secrets/sentry-dsn.txt)
    export SENTRY_DSN
    echo "SENTRY_DSN is successfully read"
else
    echo "Error: Sentry DSN file not found"
    exit 1
fi

if [ -z "$SENTRY_DSN" ]; then
  echo "Error: env SENTRY_DSN is empty"
    exit 1
fi

export SENTRY_DSN

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