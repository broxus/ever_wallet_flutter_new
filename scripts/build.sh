#!/bin/bash
set -e
set -o pipefail

deploy_target=""
build_number=""
upload="false"
flavor=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --deploy-target) deploy_target="$2"; shift ;;
        --build-number) build_number="$2"; shift ;;
        --upload) upload="$2"; shift ;;
        --flavor) flavor="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

export FLAVOR="$flavor"

function build() {
  source "scripts/build-binary/$1"
}

function upload() {
  if [[ "$upload" == "true" ]]; then
   source "scripts/deploy/$1"
  fi
}

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$upload" == "true" && "$CURRENT_BRANCH" != "main" && ("$deploy_target" == "ios_store" || "$deploy_target" == "android_store") ]]; then
  echo "🚫 Error: Deployment to the store is only allowed from the 'main' branch."
  exit 1
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

if [[ "$build_number" == "auto" ]]; then
  echo "Build number is 'auto', generating one automatically..."
  build_number=$(bash scripts/get-build-number.sh)
  echo "Generated Build Number: $build_number"
fi

if [[ -z "$build_number" || "$build_number" == "auto" ]]; then
    echo "Error: Build number is not specified."
    exit 1
fi

BUILD_NUMBER_STRING="--build-number=$build_number"
export BUILD_NUMBER_STRING

source scripts/get-changelog.sh

case $FLAVOR in
  development)
    TARGET_FILE="lib/main_development.dart"
    ;;
  staging)
    TARGET_FILE="lib/main_staging.dart"
    ;;
  production)
    TARGET_FILE="lib/main_production.dart"
    ;;
  *)
    echo "❌ Unknown flavor: $FLAVOR"
    exit 1
    ;;
esac

export TARGET_FILE

case "$deploy_target" in
  "ios_fad")
    build "fad-ipa.sh"
    upload "fad-ipa.sh"
    ;;
  "ios_store")
    build "store-ipa.sh"
    upload "store-ipa.sh"
    ;;
  "android_fad")
    build "fad-apk.sh"
    upload "fad-apk.sh"
    ;;
  "android_store")
    build "store-aab.sh"
    upload "store-aab.sh"
    ;;
  *)
    echo "Unknown deploy target: $deploy_target"
    exit 1
    ;;
esac