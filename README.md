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

_\*App works on iOS, Android, Web, and Windows._

---

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

---

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
