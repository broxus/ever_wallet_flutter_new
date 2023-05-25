#!/bin/bash
set -e
set -o pipefail

CHANGELOG_FILE=fastlane/changelog.txt

echo "🌳 Getting changelog..."
git branch | sed -n '/\* /s///p' > $CHANGELOG_FILE
git log -n 20 --oneline --decorate=no | sed 's/[^a-zA-Z0-9():-\/\.#&_\ ]//g' >> $CHANGELOG_FILE

log=`cat $CHANGELOG_FILE`
export CHANGELOG_STRING=$log

echo "🛒🤖 Creating changelog for GP"
mkdir -p android/fastlane/metadata/android/en-US/changelogs
echo "${CHANGELOG_STRING:0:499}" > android/fastlane/metadata/android/en-US/changelogs/$BUILD_NUMBER.txt

echo "🌳 Changelog gathered"



