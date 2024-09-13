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
  /// [min] is the minimum value allowed.
  /// [minError] is the error message to be used when the input is less than
  /// [min].
  /// [max] is the maximum value allowed.
  /// [maxError] is the error message to be used when the input is greater than
  /// [max].
  CurrencyTextInputValidator(
    this.currency, {
    required this.error,
    this.allowNegative = false,
    this.includeTicker = false,
    this.emptyError,
    this.min,
    this.minError,
    this.max,
    this.maxError,
    this.decimalSeparators,
  })  : assert(
          min != null && minError != null || min == null && minError == null,
          'minError must be provided when min is provided',
        ),
        assert(
          max != null && maxError != null || max == null && maxError == null,
          'maxError must be provided when max is provided',
        ) {
    _scale = currency.decimalDigits;

    _fullRegExp = CurrencyTextInputFormatter.createRegExp(
      currency: currency,
      allowNegative: allowNegative,
      includeTicker: includeTicker,
      decimalSeparators: decimalSeparators,
    );
  }

  /// Create a [CurrencyTextInputValidator] from a [CurrencyTextInputFormatter].
  /// [error] is the error message to be used when the input is invalid.
  /// [emptyError], if provided, will be used as the error message when the
  /// input is empty. Else, the field can be empty.
  /// [min] is the minimum value allowed.
  /// [minError] is the error message to be used when the input is less than
  /// [min].
  /// [max] is the maximum value allowed.
  /// [maxError] is the error message to be used when the input is greater than
  /// [max].
  factory CurrencyTextInputValidator.fromFormatter(
    CurrencyTextInputFormatter formatter, {
    required String error,
    String? emptyError,
    Fixed? min,
    String? minError,
    Fixed? max,
    String? maxError,
  }) {
    return CurrencyTextInputValidator(
      formatter.currency,
      error: error,
      allowNegative: formatter.allowNegative,
      includeTicker: formatter.includeTicker,
      emptyError: emptyError,
      min: min,
      minError: minError,
      max: max,
      maxError: maxError,
      decimalSeparators: formatter.decimalSeparators,
    );
  }

  final Currency currency;
  final bool allowNegative;
  final bool includeTicker;
  final String? emptyError;
  final String error;
  final Fixed? min;
  final String? minError;
  final Fixed? max;
  final String? maxError;
  final List<String>? decimalSeparators;

  late final RegExp _fullRegExp;
  late int _scale;

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
    final separator = match.namedGroup('separator') ?? '';
    final decimal = match.namedGroup('decimal') ?? '';
    if ((minus.isNotEmpty && integer.isEmpty) ||
        (separator.isNotEmpty && decimal.isEmpty)) {
      return error;
    }

    if (separator.isNotEmpty && integer.isEmpty) {
      return error;
    }

    if (min != null && Fixed.parse(value, scale: _scale) < min!) {
      return minError;
    }

    if (max != null && Fixed.parse(value, scale: _scale) > max!) {
      return maxError;
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
/// [min] is the minimum value allowed.
/// [minError] is the error message to be used when the input is less than
/// [min].
/// [max] is the maximum value allowed.
/// [maxError] is the error message to be used when the input is greater than
/// [max].
(CurrencyTextInputFormatter, CurrencyTextInputValidator)
    createCurrencyTextInputFormatterValidator(
  Currency currency, {
  required String error,
  bool allowNegative = false,
  bool includeTicker = false,
  String? emptyError,
  Fixed? min,
  String? minError,
  Fixed? max,
  String? maxError,
  List<String>? decimalSeparators,
}) {
  final validator = CurrencyTextInputValidator(
    currency,
    error: error,
    allowNegative: allowNegative,
    includeTicker: includeTicker,
    emptyError: emptyError,
    min: min,
    minError: minError,
    max: max,
    maxError: maxError,
    decimalSeparators: decimalSeparators,
  );
  final formatter = CurrencyTextInputFormatter.fromValidator(validator);

  return (
    formatter,
    validator,
  );
}
