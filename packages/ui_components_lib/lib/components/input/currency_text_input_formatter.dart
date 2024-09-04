import 'package:flutter/services.dart';
import 'package:money2/money2.dart';

import 'package:ui_components_lib/components/input/input.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  /// [currency] is the [Currency] to be used for validation.
  /// [allowNegative] determines whether negative values are allowed.
  /// [includeTicker] determines whether the currency ticker is included in the
  /// validation.
  /// [decimalSeparators] allows to pass a list of valid decimal separators
  CurrencyTextInputFormatter(
    this.currency, {
    this.allowNegative = false,
    this.includeTicker = false,
    this.decimalSeparators,
  }) {
    _tickerString = includeTicker ? ' ${currency.isoCode}' : '';
    _fullRegExp = createRegExp(
      currency: currency,
      allowNegative: allowNegative,
      includeTicker: includeTicker,
      decimalSeparators: decimalSeparators,
    );
  }

  /// Create a [CurrencyTextInputFormatter] from a [CurrencyTextInputValidator].
  factory CurrencyTextInputFormatter.fromValidator(
    CurrencyTextInputValidator validator,
  ) {
    return CurrencyTextInputFormatter(
      validator.currency,
      allowNegative: validator.allowNegative,
      includeTicker: validator.includeTicker,
      decimalSeparators: validator.decimalSeparators,
    );
  }

  final Currency currency;
  final bool allowNegative;
  final bool includeTicker;
  final List<String>? decimalSeparators;

  late final String _tickerString;
  late final RegExp _fullRegExp;

  static RegExp createRegExp({
    required Currency currency,
    required bool allowNegative,
    required bool includeTicker,
    List<String>? decimalSeparators,
  }) {
    final scale = currency.decimalDigits;
    final decimalSeparator = scale > 0
        ? (decimalSeparators ?? [currency.decimalSeparator]).join('|')
        : '';
    final tickerString = includeTicker ? ' ${currency.isoCode}' : '';

    final minusSignExp = allowNegative ? '(?<minus>-?)' : '(?<minus>)';
    const integerExp = '(?<integer>[0-9]*)';
    final separatorExp =
        '(?<separator>$decimalSeparator)'.replaceAll('.', r'\.');
    final decimalExp = '(?<decimal>[0-9]{0,$scale})';
    final tickerExp =
        includeTicker ? '(?<ticker>($tickerString)?)' : '(?<ticker>)';

    return RegExp(
      '^$minusSignExp($integerExp($separatorExp$decimalExp)?)?$tickerExp\$',
    );
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final match = _fullRegExp.firstMatch(newValue.text);

    if (match == null) {
      return oldValue;
    }

    final minus = match.namedGroup('minus') ?? '';
    final integer = match.namedGroup('integer') ?? '';
    final separator = match.namedGroup('separator') ?? '';
    final decimal = match.namedGroup('decimal') ?? '';

    final formattedInteger =
        integer.isNotEmpty ? BigInt.parse(integer).toString() : '';

    if (formattedInteger != integer) {
      return oldValue;
    }

    final newText = '$minus$integer$separator$decimal';
    final newTextWithTicker =
        newText.isNotEmpty ? '$newText$_tickerString' : '';

    final newSelection = clampSelection(newValue.selection, newText);

    return TextEditingValue(
      text: newTextWithTicker,
      selection: newSelection,
    );
  }

  TextSelection clampSelection(TextSelection textSelection, String text) {
    final length = text.length;

    return textSelection.copyWith(
      baseOffset: textSelection.baseOffset.clamp(0, length),
      extentOffset: textSelection.extentOffset.clamp(0, length),
    );
  }
}
