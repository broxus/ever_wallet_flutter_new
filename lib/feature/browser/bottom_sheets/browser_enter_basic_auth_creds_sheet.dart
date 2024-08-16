import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [BrowserEnterBasicAuthCredsSheet].
ModalRoute<BrowserBasicAuthCreds> showBrowserEnterBasicAuthCredsSheet({
  required String host,
}) {
  return commonBottomSheetRoute(
    title: LocaleKeys.browserEnterBasicAuthTitle.tr(),
    centerTitle: true,
    body: (_, controller) => BrowserEnterBasicAuthCredsSheet(
      host: host,
      controller: controller,
    ),
  );
}

class BrowserEnterBasicAuthCredsSheet extends StatefulWidget {
  const BrowserEnterBasicAuthCredsSheet({
    required this.host,
    required this.controller,
    super.key,
  });

  final String host;
  final ScrollController controller;

  @override
  State<BrowserEnterBasicAuthCredsSheet> createState() =>
      _BrowserEnterBasicAuthCredsSheetState();
}

class _BrowserEnterBasicAuthCredsSheetState
    extends State<BrowserEnterBasicAuthCredsSheet> {
  late FocusNode _passwordFocusNode;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SingleChildScrollView(
      controller: widget.controller,
      child: SeparatedColumn(
        separatorSize: DimensSizeV2.d24,
        children: [
          Text(
            LocaleKeys.browserEnterBasicAuthDescription.tr(
              args: [widget.host],
            ),
            style: theme.textStyles.paragraphMedium.copyWith(
              color: theme.colors.content1,
            ),
          ),
          SeparatedColumn(
            children: [
              PrimaryTextField(
                textEditingController: _usernameController,
                hintText: LocaleKeys.browserEnterBasicAuthUsername.tr(),
                onSubmit: (_) => _passwordFocusNode.requestFocus(),
              ),
              PrimaryTextField(
                focusNode: _passwordFocusNode,
                textEditingController: _passwordController,
                hintText: LocaleKeys.browserEnterBasicAuthPassword.tr(),
                isObscureText: true,
                onSubmit: (_) => _onSignIn(),
              ),
            ],
          ),
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.browserEnterBasicSignIn.tr(),
            onPressed: _onSignIn,
          ),
        ],
      ),
    );
  }

  void _onSignIn() {
    Navigator.of(context).pop(
      BrowserBasicAuthCreds(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }
}
