import 'package:flutter/services.dart';
import 'package:money2/money2.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter(this.currency);

  final Currency currency;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text,
    );
  }
}
