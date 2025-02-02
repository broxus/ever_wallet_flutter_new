# App

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![app](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml/badge.svg)](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml)

Sparx Wallet Flutter app

---

## Getting Started 🚀

Install melos:

```sh
$ dart pub global activate melos
```

Using [melos](https://melos.invertase.dev/) makes it very easy to work with the project, so enjoy.

Boostrap packages recursively:

```sh
$ melos bs
```

## Codegen 🦾

This thing will run all code generators for all packages:

```
$ melos run codegen
```

## Codegen: localization 🌐

This thing will run localization code generator for all packages:

```
$ melos run codegen:locale
```

## Code format checking and analyser 🦠

```
$ melos run check-format
$ melos run analyze
```

## Clean up 🧹

To clean up all packages just run:

```
$ melos clean
```

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ melos test
```

Also you can run dart, flutter and integration tests separately:

```sh
$ melos test:dart
$ melos test:flutter
$ melos test:integration
```

## Pre-commit preparation 🦠🧪🤏

To run code format check, analyzer and all tests use the following command:

```sh
$ melos check-all
```

## Build storybook 📚

To build storybook:

```sh
$ melos build:storybook
```

## Flavours 👃

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*App works on iOS and Android. It should run on macOS, Linux and Windows, but we have no tests nor UI kit for desktop platforms._

## Versioning the app 🔢

### App version #️⃣

App version is defined in `pubspec.yaml` file. To bump the version use the following command:

```sh
# For development releases:
$ melos version -a --yes --prerelease

# For production releases:
$ melos version -a --yes --graduate
```

You can use version workflow in GitHub actions to bump the version automatically. This workflow will create a new branch and PR (because push to main is prohibited) with the new version. Don't forget to merge the PR to main! Note: you should use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) to make it work.

### App build number #️⃣

App build number is defined in `pubspec.yaml` file. However, there is a `tools/get_build_number.dart` tool that generates the build number by incrementing it transactionally in Firebase Realtime Database. So, you don't need to worry about the build number, it's always unique and increases monotonously. Every time you build the app, the build number will be incremented.

## Secrets 🔒

### Local .secrets file 🔑

Application secret data is located in the project root in the `secrets` folder.

```markdown
├── lib
├── ...
├── secrets/
│   ├── secrets.tar.gpg
│   ├── .secrets.example
│   └── .secrets
```

`secrets.tar.gpg` encrypted archive for secure storage of confidential data

`.secrets.example` example/template for your own .secrets file 

`.secrets` file for your own secrets. Not in the repository, you need to create it yourself. To create just copy `secrets/.secrets.example` to `secrets/.secrets` and fill it with your secrets.

This file contains secret keys used when running commands.

Example contents of a .secrets file:

```markdown
export SECRET_PASSPHRASE="abc"
export MATCH_PASSWORD="qwerty"
export FASTLANE_USER="example@gmail.com"
export FASTLANE_PASSWORD="pass"
```

**Warning: don't commit .secrets file!**

**FASTLANE_USER and FASTLANE_PASSWORD are YOUR OWN credentials, that will be used only to renew iOS certificates and provisioning profiles.**

`FASTLANE_USER` should be set to your Apple Developer login.
`FASTLANE_PASSWORD` should be your Apple Developer password.

Other secrets you can get from your teammates:

`SECRET_PASSPHRASE`: passphrase the GPG tarball (with secrets)
`MATCH_PASSWORD`: passphrase for iOS provisioning profiles and certificates. Used for Fastlane's [match](https://docs.fastlane.tools/actions/match/) command.

### Github Secrets 🔑

`BOT_ACCESS_TOKEN`: Personal access token (PAT) used to fetch the repository. We should use PAT and not default GITHUB_TOKEN because ["When you use the repository's GITHUB_TOKEN to perform tasks, events triggered by the GITHUB_TOKEN, with the exception of workflow_dispatch and repository_dispatch, will not create a new workflow run"](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow). We want to trigger a workflow from the workflow (to run tests), so we need to use PAT. This thing is used in `version` workflow.

`SECRET_PASSPHRASE` and `MATCH_PASSWORD` is the same as in local `.secrets` file.

**Warning: `SECRET_PASSPHRASE` needs to be located in CI/CD (when using Github Actions, located in the Secrets of the repository) to decrypt the gpg file.**

### File with secrets: secrets/secrets.tar.gpg 🔒📁

This file contains all secrets and is encrypted with GPG. To decrypt it, run the following command:

```sh
$ melos decrypt-secrets
```

This command will place the secrets files in the necessary directories: the `/secrets`, `/android` and `/ios` folders.

When performing a build via Github Actions, secrets are temporarily located in the required folders. After building the application, `scripts/clean.sh` is run to remove secrets.

#### Create secrets

To create a gpg file with secrets, create a directory structure somewhere:

```markdown
somefolder/
├── android/
│   ├── your_keystore_name.keystore
│   ├── fastlane/
│   │   ├── GooglePlayServiceAccount.json
│   │   └── key.properties
├── fastlane/
│   ├── FirebaseADKey.json
│   └── FirebaseAPIKey.json
├── ios/
│   ├── fastlane/
│   │   └── YourDeveloperAppleAuthKey.p8
├── secrets/
│   ├── ios-provisioning-key
│   ├── ios-provisioning-key.pub
│   └── sentry-dsn.txt
```

`/android/your_keystore_name.keystore` Keystore file in jks format. Used to sign an APK file

`/android/fastlane/GooglePlayServiceAccount.json` File with Google service account credentials for interacting with the Google API and Google Play Developer API.

`/android/key.properties` File with data for signing APK files.

`/fastlane/FirebaseADKey.json` Needed to interact with the Firebase API. Contains data for scripts to interact with Firebase services.

`/fastlane/FirebaseAPIKey.json` Used to update the build number in Firebase Realtime Database.

`/ios/fastlane/YourDeveloperAppleAuthKey.p8` Required to work with the App Store Connect API.

`/secrets/ios-provisioning-key` Provisioning Profile file

`/secrets/ios-provisioning-key.pub` Apple public key to run match_assure.

`/secrets/sentry-dsn.txt` Text file with dns for working with sentry.

After that, in the directory with the created directories, run the command:

```sh
$ tar -cf secrets.tar *
$ gpg --symmetric --cipher-algo AES256 secrets.tar
```

#### Update secrets

To update secrets, decrypt the gpg file.

You will be asked to enter the passphrase. This passphrase **should be** `SECRET_PASSPHRASE` from `.secrets` file:

```sh
$ gpg --output secrets.tar --decrypt secrets.tar.gpg
```

Unpack the archive:

```sh
tar -xf secrets.tar
```

Update the necessary files and package them again:

```sh
$ tar c * > secrets.tar
$ gpg --symmetric --cipher-algo AES256 secrets.tar
```

Resulting secrets.tar.gpg file should be placed in `secrets` directory in the root of the project.

Make sure that the old gpg file does not end up in the archive.

**Warning: When archiving the contents in secrets folder, do not forget to exclude unnecessary files, such old gpg file and .secrets with your personal data**

## iOS certificates and provisioning profiles 📜

For iOS we use [match](https://docs.fastlane.tools/actions/match/) to manage certificates and provisioning profiles. It's configured in `ios/fastlane/Matchfile`.  
There is no need to manually create certificates and profiles; match will do everything for you and save it. 

To renew certificates and provisioning profiles after adding new devices to the Apple Developer Account, run the following command:

```sh
$ melos build:ios_match_new_devices
```

If you configuring a new machine, you should run the following command to install certificates and provisioning profiles:

```sh
$ melos build:ios_match_assure
```

The password for executing match commands is taken from the .secrets/MATCH_PASSWORD file.

Warning: If there are problems with the certificates or they are out of date, use a set of commands to create new certificates:

```sh
fastlane match nuke development
fastlane match nuke distribution
melos run build:ios_match_assure
```
This will not cause problems even if other application certificates are affected.

#### Possible problems

#### If the 6-digit code is not entered

When running the `melos run build:ios_match_assure` command through the terminal or another fastlane command that requires entering a 6-digit apple verification code, the code may be ignored by the terminal. Instead of entering code, a line break occurs.

To work around this issue, in the project root or another location, create a text file fastlane_session.txt (the name can be anything).

Manually or via command:
```sh
$ touch fastlane_session.txt 
```

Create a token to work with the fastlane session:

```sh
$ fastlane spaceauth -u YOUE_APPLE_ID  
```

Copy the token from the console and paste it into the fastlane_session.txt file.
Remove extra characters such as `\n`

Example contents of the fastlane_session.txt file:

```yaml
---
- !ruby/object:HTTP::Cookie
  name: abcdefg
  value: ABCDEFG111111cf12345a12
  for_domain: true
  path: "/"
  secure: true
  httponly: true
  expires:
  max_age:
  created_at: 2024-06-07 23:51:26.367930000 +07:00
  accessed_at: 2024-06-07 23:51:26.372267000 +07:00
- !ruby/object:HTTP::Cookie
  name: ABCDE
  ...
```

In the terminal, run the command to set the FASTLANE_SESSION environment variable with the value from the fastlane_session.txt file.

```sh
$ export FASTLANE_SESSION=$(cat fastlane_session.txt)
```

After this, fastlane commands will no longer require the 6-digit Apple verification code.

#### It takes a long time to clone the repository when running melos build:ios_match_new_devices

If cloning the repository takes a long time when running the command `melos build:ios_match_new_devices`, then possible reasons:
1) Insufficient rights. Contact the administrator.
2) You need an ssh key.
- To do this, [create a key and add it to github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
- After that, you may need to run the command `cd ~/.ssh/; ssh-add` in the terminal.

## Deploy 🚀

We prefer to deploy the app using GitHub Actions, but you can also deploy it from your local machine.

All deployment scripts are gathering changelog from git commits and adding it to the release notes. Note: google play limits the release notes, so don't be surprised that it is simplified and shortened.

### Deploy using GitHub Actions

We already have a workflow for deploying main app to Firebase App Distribution, TestFlight and Google Play. It's called `Deploy app`.

Deployment to fab is triggered when the `test` branch is updated, or when manually launched from any branch except main.
Deployment to store is triggered when manually launched from the `main` branch.

Deployment to FAD is triggered when the `dev` branch is updated.  

Manually running the deploy `melos run deploy_fad` from any branch **except** `main`.  
Running `melos run deploy_ios` deploys iOS to FAD.   
Running `melos run deploy_android` deploys Android to FAD.

Deployment to store is triggered when manually launched from the `main` branch.

#### Available options for deploying in workflow:

- **ios_fad** - launches iOS deploy to FAD.
- **ios_store** - launches iOS deploy to Test Flight.  
- **android_fad** - launches Android deploy to FAD.  
- **android_store** - launches Android deploy to Google Play.
- **fad** - launches iOS and Android deploy to FAD.  
- **store** - launches iOS and Android deploy to Test Flight and Google Play.  

We also have a workflow for deploying storybook to GitHub Pages. It's called `storybook-gh-pages-deploy` and it's triggered by pushing to the main branch or manually from any branch.

### Deploy from local machine

For deployment from a local machine, melos is used.

- **build_android_store** - build Android `aab` from any branch
- **deploy_fad_ios** - build and send iOS `ipa` from any branch
- **deploy_fad_android** - build and send Android `apk` from any branch
- **deploy_fad** - build and send Android `apk` and iOS `ipa` from any branch
- **deploy_store** - build and send Android `aab` and iOS `ipa` from the main branch

The `melos deploy_store*` commands only work from the `main` branch, so as not to accidentally upload unnecessary code to production.  

The `melos build_*` commands work from any branch - in case of manual build.  
Unlike `deploy_store*` commands, randomly running `build_*` will only build aab and/or ipa locally and will not push anything extra or untested to the store.

```sh
# To deploy to Firebase App Distribution just run the following command:
$ melos build:deploy_fad

# To deploy to TestFlight and Google Play closed testing just run the following command:
$ melos build:deploy_store
```

Each of these commands will increment the build number before building the app.

**Warning: To use Sentry, don't forget to pass the dsn via dart-define.**

Example:
```markdown
melos build:deploy_fad -- --dart-define=SENTRY_DSN="your_dsn"
```

## Coverage 📊

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Logging ( ͡❛ ͜ʖ ͡❛)✌

The app can be built with several flavors. Each of them determines the logging level. The defining map is in `logs/logs.dart`.

We also have logs from nekoton, and level transformation matrix is in `packages/nekoton_repository/lib/src/nekoton_repository.dart`.

Console colors are defined in fancy_logger package.

## Crash analytics

[Sentry](https://sentry.io) is used to intercept global errors and crash analytics.

Sentry does not run in the development build type.

Dsn is passed through dart-define using the SENTRY_DSN environment variable.

Examples:

```markdown
melos build:deploy_fad -- --dart-define=SENTRY_DSN="your_dsn"
```

```markdown
flutter run --dart-define=SENTRY_DSN="your_sentry_dsn_value"
```

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link]. However, we use [easy_localization][easy_localization_link] package to simplify the internationalization process.

### Adding Strings

1. To add a new localizable string, open the `en.json` file at `assets/translations/en.json`.

```json
{
    "confirm": "Confirm"
}
```

2. Then add a new key/value

```json
{
    "confirm": "Confirm",
    "continueWord": "Continue"
}
```

3. Use the new string

```dart
import 'package:app/generated/generated.dart';

@override
Widget build(BuildContext context) {
  return Text(LocaleKeys.continueWord.tr());
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new JSON file in `assets/translations`.

```
├── assets
│   ├── translations
│   │   ├── en.json
│   │   └── es.json
```

2. Add the translated strings to each `.json` file:

`es.json`

```json
{
    "confirm": "Confirmar",
    "continueWord": "Continuar"
}
```

4. Provide flag icon asset

Put new vector icon to `assets/images/lang_icons/spanish.svg`.

5. Add the locale to `SupportedLocaleCodes` enum in `lib/app/service/localization/service/supported_locale_codes.dart` (yes, don't forget the language string).

```dart
    ...
    es(LocaleKeys.langSpanish),
    ...
```

6. Provide flag icon asset and iconPath in `SupportedLocaleCodes` enum

```dart
    ...
    SupportedLocaleCodes.ko => Assets.images.langIcons.spainsh.path,
    ...
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[easy_localization_link]: https://pub.dev/packages/easy_localization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
