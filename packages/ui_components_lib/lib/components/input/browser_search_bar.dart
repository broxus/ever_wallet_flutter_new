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
  late final _focusNode = FocusNode();
  late final _textEditingController = TextEditingController(
    text: _getTextFieldText(),
  );
  bool _focused = false;

  TextAlign get _textAlign {
    if (_isSecure) {
      return TextAlign.start;
    }
    return _focused ? TextAlign.start : TextAlign.center;
  }

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
    _focusNode.addListener(_handleFocusChange);

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
      color: _isSecure ? colors.content3 : colors.content0,
    );

    final hintStyle = themeStyle.textStyles.labelMedium.copyWith(
      color: colors.content3,
    );

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
                  prefixIcon: _getPrefixIcon(),
                  onSubmitted: _onSubmitted,
                  focusNode: _focusNode,
                  inactiveBorderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  textStyle: textStyle,
                  hintStyle: hintStyle,
                  textAlign: _textAlign,
                  prefixIconConstraints: const BoxConstraints(),
                  cursorColor: colors.primaryA,
                  radius: DimensRadius.xMedium,
                ),
                if (!_focused && !_isEmpty)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: _ShareButton(
                      svgUri: widget.shareSvg,
                      onPressed: _isEmpty || widget.onShared == null
                          ? null
                          : () => widget.onShared?.call(widget.uri),
                    ),
                  ),
              ],
            ),
          ),
          if (_focused && widget.cancelText != null)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onCancel,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: DimensSizeV2.d10,
                  bottom: DimensSizeV2.d10,
                  left: DimensSizeV2.d18,
                  right: DimensSizeV2.d6,
                ),
                child: Center(
                  child: Text(
                    widget.cancelText!,
                    style: themeStyle.textStyles.labelMedium,
                  ),
                ),
              ),
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
      return _getIcon(
        widget.searchSvg,
        Icons.search,
        const EdgeInsets.only(
          left: DimensSizeV2.d12,
        ),
      );
    }

    if (_isSecure) {
      return _getIcon(
        widget.secureSvg,
        Icons.lock,
        const EdgeInsets.only(
          left: DimensSizeV2.d12,
          right: DimensSizeV2.d7,
        ),
      );
    }

    return null;
  }

  // TODO(Odrin): we should add all the icons in the ui kit library
  // and get rid of this method
  Widget? _getIcon(
    String? svg,
    IconData iconData,
    EdgeInsets padding,
  ) {
    final colors = context.themeStyleV2.colors;
    return Padding(
      padding: padding,
      child: svg != null
          ? CommonIconWidget.svg(
              svg: svg,
              color: colors.content3,
              width: DimensSize.d14,
              height: DimensSize.d14,
            )
          : CommonIconWidget.icon(
              icon: iconData,
              color: colors.content3,
              width: DimensSize.d14,
              height: DimensSize.d14,
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

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    this.svgUri,
    this.onPressed,
  });

  final String? svgUri;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO(Odrin): we should add all the icons in the ui kit library
    // and get rid of this method

    return CommonIconButton(
      svg: svgUri,
      icon: svgUri == null ? Icons.share : null,
      buttonType: EverButtonType.ghost,
      onPressed: onPressed,
      width: DimensSizeV2.d20,
      height: DimensSizeV2.d20,
      padding: const EdgeInsets.only(
        left: DimensSizeV2.d10,
        right: DimensSizeV2.d22,
      ),
    );
  }
}
