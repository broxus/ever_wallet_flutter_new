import 'package:money2/money2.dart';

import 'package:ui_components_lib/components/input/input.dart';

class CurrencyTextInputValidator {
  /// [currency] is the [Currency] to be used for validation.
  /// [error] is the error message to be used when the input is invalid.
  /// [allowNegative] determines whether negative values are allowed.
  /// [includeTicker] determines whether the currency ticker is included in the
  /// validation.
  /// [emptyError], if provided, will be used as the error message when the
  /// input is empty. Else, the field can be empty.
  CurrencyTextInputValidator(
    this.currency, {
    required this.error,
    this.allowNegative = false,
    this.includeTicker = false,
    this.emptyError,
  }) {
    _fullRegExp = CurrencyTextInputFormatter.createRegExp(
      currency: currency,
      allowNegative: allowNegative,
      includeTicker: includeTicker,
    );
  }

  /// Create a [CurrencyTextInputValidator] from a [CurrencyTextInputFormatter].
  /// [error] is the error message to be used when the input is invalid.
  /// [emptyError], if provided, will be used as the error message when the
  /// input is empty. Else, the field can be empty.
  factory CurrencyTextInputValidator.fromFormatter(
    CurrencyTextInputFormatter formatter, {
    required String error,
    String? emptyError,
  }) {
    return CurrencyTextInputValidator(
      formatter.currency,
      error: error,
      allowNegative: formatter.allowNegative,
      includeTicker: formatter.includeTicker,
      emptyError: emptyError,
    );
  }

  final Currency currency;
  final bool allowNegative;
  final bool includeTicker;
  final String? emptyError;
  final String error;

  late final RegExp _fullRegExp;

  String? validate(String? value) {
    if (value?.isEmpty ?? true) {
      return emptyError;
    }

    final match = _fullRegExp.firstMatch(value!);
    if (match == null) {
      return error;
    }

    final minus = match.namedGroup('minus') ?? '';
    final integer = match.namedGroup('integer') ?? '';
    if (minus.isNotEmpty && integer.isEmpty) {
      return error;
    }

    return null;
  }
}

/// Create a [CurrencyTextInputFormatter] and a [CurrencyTextInputValidator]
/// from a [Currency].
/// [currency] is the [Currency] to be used for validation.
/// [error] is the error message to be used when the input is invalid.
/// [allowNegative] determines whether negative values are allowed.
/// [includeTicker] determines whether the currency ticker is included in the
/// validation.
/// [emptyError], if provided, will be used as the error message when the
/// input is empty. Else, the field can be empty.
(CurrencyTextInputFormatter, CurrencyTextInputValidator)
    createCurrencyTextInputFormatterValidator(
  Currency currency, {
  required String error,
  bool allowNegative = false,
  bool includeTicker = false,
  String? emptyError,
}) {
  final validator = CurrencyTextInputValidator(
    currency,
    error: error,
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
