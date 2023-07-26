import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBarInput extends StatefulWidget {
  const BrowserSearchBarInput({
    this.uri,
    this.onSubmitted,
    this.hintText,
    this.searchIcon,
    this.secureIcon,
    this.shareIcon,
    this.cancelText,
    super.key,
  });

  final Uri? uri;
  final ValueChanged<String?>? onSubmitted;
  final String? hintText;
  final Widget? searchIcon;
  final Widget? secureIcon;
  final Widget? shareIcon;
  final String? cancelText;

  @override
  State<BrowserSearchBarInput> createState() => _BrowserSearchBarInputState();
}

class _BrowserSearchBarInputState extends State<BrowserSearchBarInput> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;
  bool _focused = false;

  @override
  void didUpdateWidget(covariant BrowserSearchBarInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uri != widget.uri) {
      _updateTextField();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _textEditingController = TextEditingController(text: _getTextFieldText());
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();

    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final textStyle = StyleRes.primaryRegular.copyWith(
      color: _focused ? colors.textPrimary : colors.textSecondary,
    );

    return Material(
      color: colors.backgroundSecondary,
      child: SizedBox(
        height: DimensSize.d64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Row(
            children: [
              Expanded(
                child: CommonInput(
                  controller: _textEditingController,
                  needClearButton: false,
                  height: DimensSize.d40,
                  autocorrect: false,
                  hintText: widget.hintText,
                  prefixIcon: widget.searchIcon,
                  suffixIcon: widget.shareIcon,
                  onSubmitted: _onSubmitted,
                  focusNode: _focusNode,
                  inactiveBorderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  textStyle: textStyle,
                ),
              ),
              if (_focused)
                CommonButton.ghost(
                  text: widget.cancelText,
                  onPressed: _onCancel,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCancel() {
    _focusNode.unfocus();
  }

  void _handleFocusChange() {
    setState(() {
      _focused = _focusNode.hasFocus;
    });
    _updateTextField();
  }

  void _updateTextField() {
    if (_focused) {
      _textEditingController
        ..text = _getTextFieldText()
        ..selection = const TextSelection(
          baseOffset: 0,
          extentOffset: 0,
        );
    } else {
      _textEditingController.text = _getTextFieldText();
    }
  }

  String _getTextFieldText() {
    if (_focused) {
      return widget.uri?.toString() ?? '';
    } else {
      return widget.uri?.host ?? '';
    }
  }

  void _onSubmitted(String text) {
    widget.onSubmitted?.call(text);
    _focusNode.unfocus();
  }
}
