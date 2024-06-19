# 2023-03-21 -- v9.0.0
- Raised the minimum supported version of Xcode to 14.2.0.
- Removed support for bitcode.
- Raised the minimum supported version of iOS from 10.0 to 11.0.
- Upgraded the version range of GTMSessionFetcher/Core dependency in
  MLKitCommon from "~> 1.1" to ">= 1.1, < 3.0" to support Firebase 10.
- Fixed compatibility with Firebase.
# 2022-08-09 -- v8.0.0
- Bug fixes.
# 2022-06-28 -- v7.0.0
- Bug fixes.
# 2022-04-26 -- v6.0.0
- Raised the minimum supported version of Xcode to 13.2.1.
# 2021-12-14 -- v5.0.0
- Bug fixes.
# 2021-09-28 -- v4.0.0
- Fixed a bitcode recompilation issue during ipa generation.
- Raised the minimum supported version of Xcode to 12.5.1.
# 2021-08-11 -- v3.1.0
- Bug fixes.
# 2021-06-29 -- v3.0.0
- Raised the minimum supported version of Xcode to 12.4.
- Upgraded the version range of GoogleDataTransport dependency in MLKitCommon
  from 8.x to 9.x.
# 2021-03-02 -- v2.1.0
- Raised the minimum supported version of Xcode to 12.2.
# 2021-01-26 -- v2.0.0
- Bug fixes.
# 2020-12-08 -- v1.0.0
- First release graduated out of Beta.
- Added `RemoteModelSource` and `CustomRemoteModel` classes to support remote
  custom models.
- Added `manifestPath` property and `init(manifestPath:)` method to the
  `LocalModel` class to support initializing a local custom model trained by
  AutoML Vision Edge.
# 2020-10-29 -- v0.64.2
- Upgraded the version range of GoogleUtilities dependency in MLKitCommon from
  6.x to 7.x.
# 2020-10-26 -- v0.64.1
- Upgraded the version range of GoogleDataTransport dependency in MLKitCommon
  from 7.x to 8.x.
# 2020-09-29 -- v0.64.0
- Bug fixes.
# 2020-08-25 -- v0.63.0
- Bug fixes.
# 2020-07-28 -- v0.62.0
- Bug fixes.
# 2020-07-15 -- v0.61.1
- Upgraded the version range of GoogleDataTransport dependency in MLKitCommon
  from 3.2 or higher to 7.x.
- Removed the GoogleDataTransportCCTSupport dependency from MLKitCommon.
# 2020-06-30 -- v0.61.0
- Bug fixes.
# 2020-06 -- v0.60.0
- Initial release of the standalone ML Kit.
