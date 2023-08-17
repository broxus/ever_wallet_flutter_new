import 'package:money2/money2.dart';

import 'package:ui_components_lib/components/input/input.dart';

(CurrencyTextInputFormatter, CurrencyTextInputValidator)
    createCurrencyTextInputFormatterValidator(
  Currency currency, {
  bool allowNegative = false,
  bool includeTicker = false,
  String? emptyError,
}) {
  final validator = CurrencyTextInputValidator(
    currency,
    allowNegative: allowNegative,
    includeTicker: includeTicker,
    emptyError: emptyError,
  );
  final formatter = CurrencyTextInputFormatter.fromValidator(validator);
  return (
    formatter,
    validator,
  );
}

class CurrencyTextInputValidator {
  /// [currency] is the [Currency] to be used for validation.
  /// [allowNegative] determines whether negative values are allowed.
  /// [includeTicker] determines whether the currency ticker is included in the
  /// validation.
  /// [emptyError], if provided, will be used as the error message when the
  /// input is empty. Else, the field can be empty.
  CurrencyTextInputValidator(
    this.currency, {
    this.allowNegative = false,
    this.includeTicker = false,
    this.emptyError,
  });

  /// Create a [CurrencyTextInputValidator] from a [CurrencyTextInputFormatter].
  /// [emptyError], if provided, will be used as the error message when the
  /// input is empty. Else, the field can be empty.
  factory CurrencyTextInputValidator.fromFormatter(
    CurrencyTextInputFormatter formatter,
    String? emptyError,
  ) {
    return CurrencyTextInputValidator(
      formatter.currency,
      allowNegative: formatter.allowNegative,
      includeTicker: formatter.includeTicker,
      emptyError: emptyError,
    );
  }

  final Currency currency;
  final bool allowNegative;
  final bool includeTicker;
  final String? emptyError;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some';
    }
    return null;
  }
}
