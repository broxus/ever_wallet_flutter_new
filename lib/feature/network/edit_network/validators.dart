import 'package:app/generated/generated.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class Validators {
  final _maxNetworkNameLength = 32;
  final _maxCurrencySymbolLength = 16;

  late final nameValidator = CommonTextValidator(
    minLength: 1,
    maxLength: _maxNetworkNameLength,
    emptyError: LocaleKeys.textFieldShouldNotBeEmpty.tr(),
    maxLengthError: LocaleKeys.textFieldTooLong.tr(
      args: [
        _maxNetworkNameLength.toString(),
      ],
    ),
  );

  late final currencySymbolValidator = CommonTextValidator(
    maxLength: _maxCurrencySymbolLength,
    maxLengthError: LocaleKeys.textFieldTooLong.tr(
      args: [
        _maxCurrencySymbolLength.toString(),
      ],
    ),
  );

  final nonOptionalUrlValidator = UrlTextValidator(
    emptyError: LocaleKeys.urlFieldShouldNotBeEmpty.tr(),
    schemeError: LocaleKeys.urlFieldShouldHasScheme.tr(),
    hostError: LocaleKeys.urlFieldShouldHasHost.tr(),
  );

  final optionalUrlValidator = UrlTextValidator(
    schemeError: LocaleKeys.urlFieldShouldHasScheme.tr(),
    hostError: LocaleKeys.urlFieldShouldHasHost.tr(),
  );
}
