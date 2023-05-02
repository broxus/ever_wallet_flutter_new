#!/bin/bash
set -e
set -o pipefail

echo "#️⃣ Getting next build number..."
export BUILD_NUMBER=`dart tools/get_build_number.dart fastlane/FirebaseAPIKey.json`
export BUILD_NUMBER_STRING="--build-number=$BUILD_NUMBER"
echo "#️⃣ New build number: $BUILD_NUMBER"

