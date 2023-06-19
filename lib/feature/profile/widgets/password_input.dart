import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Wrapper above [CommonInput] that adds hide/show logic for password.
class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.controller,
    this.submit,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback? submit;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return CommonInput(
      titleText: LocaleKeys.yourPassword.tr(),
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      obscureText: _obscure,
      onSubmitted: (_) => widget.submit?.call(),
      suffixIcon: CommonIconButton.svg(
        color: colors.textSecondary,
        svg: _obscure
            ? Assets.images.openedEye.path
            : Assets.images.closedEye.path,
        buttonType: EverButtonType.ghost,
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
