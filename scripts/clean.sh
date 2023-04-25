#!/bin/bash

# Remove build files generated code
find . -type f -name "*_generated.*" -delete
find . -type f -name "*.freezed.dart" -delete
find . -type f -name "*.g.dart" -delete
find . -type f -name "*.reflectable.dart" -delete
find . -type f -name "*.module.dart" -delete

# Remove DI config
rm -rf lib/di/di.config.dart
