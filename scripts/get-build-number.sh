#!/bin/bash
set -e
set -o pipefail

echo "#️⃣ Getting next build number..."
BUILD_NUMBER=$(dart tools/get_build_number.dart fastlane/FirebaseAPIKey.json)
echo $BUILD_NUMBER

