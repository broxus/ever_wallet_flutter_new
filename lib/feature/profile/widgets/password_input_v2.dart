import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Wrapper above [CommonInput] that adds hide/show logic for password.
class PasswordInputV2 extends StatefulWidget {
  const PasswordInputV2({
    required this.controller,
    this.submit,
    this.focus,
    this.validator,
    this.title,
    this.subtitle,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode? focus;
  final VoidCallback? submit;
  final FormFieldValidator<String?>? validator;
  final String? title;
  final String? subtitle;

  @override
  State<PasswordInputV2> createState() => _PasswordInputV2State();
}

class _PasswordInputV2State extends State<PasswordInputV2> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      hintText: LocaleKeys.password.tr(),
      textEditingController: widget.controller,
      focusNode: widget.focus,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      isObscureText: _obscure,
      suffixes: [
        Padding(
          padding: const EdgeInsets.only(right: DimensSize.d8),
          child: PrimaryButton(
            buttonShape: ButtonShape.square,
            icon: _obscure ? LucideIcons.eye : LucideIcons.eyeOff,
            onPressed: () => setState(() => _obscure = !_obscure),
            buttonSize: ButtonSize.small,
          ),
        ),
      ],
      onSubmit: (_) => widget.submit?.call(),
    );
  }
}
