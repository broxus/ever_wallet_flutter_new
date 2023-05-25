#!/bin/bash
set -e
set -o pipefail

echo "🌳 Getting changelog..."
export BRANCH=`git branch | sed -n '/\* /s///p'`
log=`git log -n 20 --oneline --decorate=no | sed 's/[^a-zA-Z0-9():-\/\.#&_\ ]//g'`
export CHANGELOG_STRING="Branch: $BRANCH "$'\n\n'"$log"
export CHANGELOG_STRING_SHORT=$log

echo "🛒🤖 Creating changelog for GP"
mkdir -p android/fastlane/metadata/android/en-US/changelogs
echo "${CHANGELOG_STRING_SHORT:0:499}" > android/fastlane/metadata/android/en-US/changelogs/$BUILD_NUMBER.txt

echo "🌳 Changelog gathered for branch: $BRANCH"



