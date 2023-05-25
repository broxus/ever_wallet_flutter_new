#!/bin/bash

# Remove build files generated code
find . -type f -name "*_generated.*" -delete
find . -type f -name "*.freezed.dart" -delete
find . -type f -name "*.g.dart" -delete
find . -type f -name "*.reflectable.dart" -delete
find . -type f -name "*.module.dart" -delete

# Remove DI config
rm -rf lib/di/di.config.dart

# Sectets
rm -f android/crystal.keystore
rm -f android/key.properties
rm -f android/fastlane/GooglePlayServiceAccount.json
rm -f ios/fastlane/AuthKey_L4N29B6Z42.p8
rm -f fastlane/FirebaseAPIKey.json
rm -f fastlane/FirebaseADKey.json
rm -f secrets/ios-provisioning-key*

# Remove changelog
rm -rf fastlane/changelog.txt
rm -rf android/fastlane/metadata/android/
