import 'package:flutter/widgets.dart';

class EnterSeedPhraseInputData {
  EnterSeedPhraseInputData({
    required this.index,
    required this.controller,
    required this.focusNode,
    bool? isError,
  }) : _isError = isError ?? false;

  EnterSeedPhraseInputData.init(int index)
      : this(
          index: index,
          controller: TextEditingController(),
          focusNode: FocusNode(),
        );

  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  bool _isError;

  set isError(bool? value) {
    _isError = value ?? _isError;
  }

  bool get isError => _isError;

  String get text => controller.text;

  bool get isFocused => focusNode.hasFocus;

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }

  void clear() {
    controller
      ..text = ''
      ..selection = const TextSelection.collapsed(offset: 0);
  }
}
