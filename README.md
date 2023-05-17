# App

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![app](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml/badge.svg)](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml)

EVER Wallet Flutter app

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

Just copy `secrets/.secrets.example` to `secrets/.secrets` and fill it with your secrets.

**Warning: don't commit this file!**

**Warning: FASTLANE_USER and is YOUR OWN credentials, that will be used only to renew iOS certificates and provisioning profiles**

Other secrets you can get from your teammates:

`SECRET_PASSPHRASE`: passphrase the GPG tarball (with secrets)

`MATCH_PASSWORD`: passphrase for iOS provisioning profiles and certificates

### Github Secrets 🔑

`BOT_ACCESS_TOKEN`: Personal access token (PAT) used to fetch the repository. We should use PAT and not default GITHUB_TOKEN because ["When you use the repository's GITHUB_TOKEN to perform tasks, events triggered by the GITHUB_TOKEN, with the exception of workflow_dispatch and repository_dispatch, will not create a new workflow run"](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow). We want to trigger a workflow from the workflow (to run tests), so we need to use PAT. This thing is used in `version` workflow.

`SECRET_PASSPHRASE` and `MATCH_PASSWORD` is the same as in local `.secrets` file.

### File with secrets: secrets/secrets.tar.gpg 🔒📁

This file contains all secrets and is encrypted with GPG. To decrypt it, run the following command:

```sh
$ melos decrypt-secrets
```

To update the file with secrets, create directory structure as mentioned above, cd to it and run the following command:

```sh
$ tar c * > secrets.tar
$ gpg --symmetric --cipher-algo AES256 secrets.tar
```

You will be asked to enter the passphrase. This passphrase **should be** `SECRET_PASSPHRASE` from `.secrets` file.

Resulting secrets.tar.gpg file should be placed in `secrets` directory in the root of the project.

## iOS certificates and provisioning profiles 📜

For iOS we use [match](https://docs.fastlane.tools/actions/match/) to manage certificates and provisioning profiles. It's configured in `ios/fastlane/Matchfile`. To renew certificates and provisioning profiles after adding new devices to the Apple Developer Account, run the following command:

```sh
$ melos build:ios_match_new_devices
```

If you configuring a new machine, you should run the following command to install certificates and provisioning profiles:

```sh
$ melos build:ios_match_assure
```

## Deploy 🚀

We prefer to deploy the app using GitHub Actions, but you can also deploy it from your local machine.

All deployment scripts are gathering changelog from git commits and adding it to the release notes. Note: google play limits the release notes, so don't be surprised that it is simplified and shortened.

### Deploy using GitHub Actions

We already have a workflow for deploying main app to Firebase App Distribution, TestFlight and Google Play closed testing. It's called `app=deploy` and it's triggered by pushing to the main branch or manually from any branch. You can choose the desired deployment when triggering the workflow manually. It will deploy to FAD when its triggered by pushing to the main branch.

We also have a workflow for deploying storybook to GitHub Pages. It's called `storybook-gh-pages-deploy` and it's triggered by pushing to the main branch or manually from any branch.

### Deploy from local machine

```sh
# To deploy to Firebase App Distribution just run the following command:
$ melos build:deploy_fad

# To deploy to TestFlight and Google Play closed testing just run the following command:
$ melos build:deploy_store

# Also you can deploy it to Firebase App Distribution, TestFlight and Google Play closed testing at once:
$ melos build:deploy_fad_store
```

Each of these commands will increment the build number before building the app.

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

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
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

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
