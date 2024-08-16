import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/ghost_button.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/primary_text_field.dart';

class SecureTextField extends StatefulWidget {
  const SecureTextField({
    super.key,
    this.hintText,
    this.isInitObscure = true,
    this.textEditingController,
    this.textInputAction,
  });

  final String? hintText;
  final bool isInitObscure;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;

  @override
  State<SecureTextField> createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  late bool _isObscure = widget.isInitObscure;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      keyboardType: TextInputType.visiblePassword,
      hintText: widget.hintText,
      suffixes: [
        _IconEyeWidget(
          onPressed: _onPressedIcon,
          isTurnedOn: !_isObscure,
        ),
      ],
      isObscureText: _isObscure,
      textEditingController: widget.textEditingController,
      textInputAction: widget.textInputAction,
    );
  }

  void _onPressedIcon() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }
}

class _IconEyeWidget extends StatelessWidget {
  const _IconEyeWidget({
    required this.onPressed,
    required this.isTurnedOn,
  });

  final VoidCallback onPressed;
  final bool isTurnedOn;

  @override
  Widget build(BuildContext context) {
    return GhostButton(
      buttonShape: ButtonShape.square,
      icon: isTurnedOn ? LucideIcons.eye : LucideIcons.eyeOff,
      onPressed: onPressed,
    );
  }
}
