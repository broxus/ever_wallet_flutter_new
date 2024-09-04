#!/bin/bash
set -e
set -o pipefail

export SENTRY_DSN

source scripts/get-build-number.sh
source scripts/get-changelog.sh

case "$1" in
  "fad"|"ios_fad")
    source scripts/build-binary/fad-ipa.sh
    source scripts/deploy/fad-ipa.sh
    ;;
esac

case "$1" in
  "fad"|"android_fad")
    source scripts/build-binary/fad-apk.sh
    source scripts/deploy/fad-apk.sh
    ;;
esac

case "$1" in
  "store"|"ios_store")
    source scripts/build-binary/store-ipa.sh
    source scripts/deploy/store-ipa.sh
    ;;
esac

case "$1" in
  "store"|"android_store")
    source scripts/build-binary/store-aab.sh
    source scripts/deploy/store-aab.sh
    ;;
esac

if [[ "$1" != "fad" && "$1" != "store" && "$1" != "ios_fad" && "$1" != "ios_store" && "$1" != "android_fad" && "$1" != "android_store" ]]; then
    echo "Unknown deploy target: $1"
    exit 1
fi
