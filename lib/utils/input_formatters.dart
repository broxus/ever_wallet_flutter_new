import 'package:flutter/services.dart';

class InputFormatters {
  static FilteringTextInputFormatter noSpacesFormatter =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));
  static FilteringTextInputFormatter onlyDigitsFormatter =
      FilteringTextInputFormatter.allow(
    RegExp('[0-9]'),
  );

  static FilteringTextInputFormatter publicKeyInputFormatter =
      FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9]'));
}
