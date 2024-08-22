import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBarInput extends StatefulWidget {
  const BrowserSearchBarInput({
    this.uri,
    this.onSubmitted,
    this.onChanged,
    this.onShared,
    this.hintText,
    this.searchSvg,
    this.secureSvg,
    this.shareSvg,
    this.cancelText,
    super.key,
  });

  final Uri? uri;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final ValueSetter<Uri?>? onShared;
  final String? hintText;
  final String? searchSvg;
  final String? secureSvg;
  final String? shareSvg;
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
    _textEditingController.addListener(
      () {
        widget.onChanged?.call(_textEditingController.text);
      },
    );
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
    final themeStyle = context.themeStyleV2;
    final colors = themeStyle.colors;

    final textStyle = themeStyle.textStyles.labelMedium.copyWith(
      color: colors.content3,
    );

    final prefixIcon = _getPrefixIcon();
    final prefixIconDecoration = prefixIcon != null
        ? BoxConstraints.tight(const Size.square(DimensSize.d32))
        : null;

    final shareButton = _getShareButton();

    return _Container(
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CommonInput(
                  fillColor: colors.background1,
                  controller: _textEditingController,
                  needClearButton: false,
                  height: DimensSize.d40,
                  autocorrect: false,
                  hintText: _focused ? null : widget.hintText,
                  prefixIcon: prefixIcon,
                  onSubmitted: _onSubmitted,
                  focusNode: _focusNode,
                  inactiveBorderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  textStyle: textStyle,
                  textAlign: _focused ? TextAlign.start : TextAlign.center,
                  prefixIconConstraints: prefixIconDecoration,
                  cursorColor: colors.primaryA,
                ),
                if (shareButton != null)
                  Positioned(
                    right: 0,
                    child: shareButton,
                  ),
              ],
            ),
          ),
          if (_focused)
            CommonButton.ghost(
              text: widget.cancelText,
              onPressed: _onCancel,
            ),
        ],
      ),
    );
  }

  void _onCancel() {
    _focusNode.unfocus();
  }

  void _handleFocusChange() {
    setState(() {
      _focused = _focusNode.hasFocus;
      _updateTextField();
    });
  }

  void _updateTextField() {
    if (_focused) {
      _textEditingController
        ..text = _getTextFieldText()
        ..selection = TextSelection(
          baseOffset: 0,
          extentOffset: _textEditingController.text.length,
        );
    } else {
      _textEditingController.text = _getTextFieldText();
    }
  }

  String _getTextFieldText() {
    return _focused ? widget.uri?.toString() ?? '' : widget.uri?.host ?? '';
  }

  void _onSubmitted(String text) {
    widget.onSubmitted?.call(text);
    _focusNode.unfocus();
  }

  bool get _isSecure => widget.uri?.isScheme('https') ?? false;

  bool get _isEmpty => _textEditingController.text.isEmpty;

  Widget? _getPrefixIcon() {
    if (_focused) {
      return null;
    }

    if (_isEmpty) {
      return _getIcon(widget.searchSvg, Icons.search);
    }

    if (_isSecure) {
      return _getIcon(widget.secureSvg, Icons.lock);
    }

    return null;
  }

  Widget? _getShareButton() {
    if (_focused || _isEmpty) {
      return null;
    }

    final onShared = _isEmpty || widget.onShared == null
        ? null
        : () => widget.onShared?.call(widget.uri);

    return _getButton(widget.shareSvg, Icons.share, onShared);
  }

  Widget? _getButton(
    String? svg,
    IconData icondata,
    VoidCallback? onPressed,
  ) {
    return svg != null
        ? CommonIconButton.svg(
            svg: svg,
            buttonType: EverButtonType.ghost,
            onPressed: onPressed,
          )
        : CommonIconButton.icon(
            icon: icondata,
            buttonType: EverButtonType.ghost,
            onPressed: onPressed,
          );
  }

  // TODO(Odrin): we should add all the icons in the ui kit library
  // and get rid of this method
  Widget? _getIcon(String? svg, IconData icondata) {
    final colors = context.themeStyle.colors;

    return Padding(
      padding: const EdgeInsets.all(DimensSize.d8),
      child: svg != null
          ? CommonIconWidget.svg(
              svg: svg,
              color: colors.textSecondary,
              size: DimensSize.d20,
            )
          : CommonIconWidget.icon(
              icon: icondata,
              color: colors.textSecondary,
            ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: DimensSize.d64,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.themeStyleV2.colors.borderAlpha,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
            child: child,
          ),
        ),
      ),
    );
  }
}
