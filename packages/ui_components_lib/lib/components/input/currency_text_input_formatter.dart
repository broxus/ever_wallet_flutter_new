import 'package:flutter/services.dart';
import 'package:money2/money2.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter(
    this.currency, {
    this.allowNegative = false,
    this.includeTicker = false,
  }) {
    _scale = currency.scale;
    _decimalSeparator = _scale > 0 ? currency.decimalSeparator : '';

    final minusSignExp = allowNegative ? '(?<minus>-?)' : '(?<minus>)';
    const integerExp = '(?<integer>[0-9]+)';
    final separatorExp =
        '(?<separator>$_decimalSeparator)'.replaceAll('.', r'\.');
    final decimalExp = '(?<decimal>[0-9]{0,$_scale})';

    _fullRegExp = RegExp(
      '^$minusSignExp($integerExp($separatorExp$decimalExp)?)?\$',
      caseSensitive: false,
    );
  }

  final Currency currency;
  final bool allowNegative;
  final bool includeTicker;

  late final String _decimalSeparator;
  late final int _scale;
  late final RegExp _fullRegExp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newTrim = newValue.text.trim();

    final match = _fullRegExp.firstMatch(newTrim);

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

    final newSelection = clampSelection(newValue.selection, newText);

    return TextEditingValue(
      text: newText,
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
