import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a pure widget that allows user to enter password for any action.
///
/// This widget can be displayed in any sheet.
class EnterPasswordWidget extends StatefulWidget {
  const EnterPasswordWidget({
    required this.onPasswordEntered,
    this.isLoading = false,
    super.key,
  });

  final ValueChanged<String> onPasswordEntered;
  final bool isLoading;

  @override
  State<EnterPasswordWidget> createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d24,
      children: [
        PasswordInput(
          controller: _passwordController,
          submit: () => widget.onPasswordEntered(_passwordController.text),
        ),
        CommonButton.primary(
          fillWidth: true,
          isLoading: widget.isLoading,
          text: LocaleKeys.submitWord.tr(),
          onPressed: () => widget.onPasswordEntered(_passwordController.text),
        ),
      ],
    );
  }
}
