import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserEnterBasicAuthCredsSheet].
ModalRoute<BrowserBasicAuthCreds> showBrowserEnterBasicAuthCredsSheet({
  required String host,
}) {
  return commonBottomSheetRoute(
    title: LocaleKeys.browserEnterBasicAuthTitle.tr(),
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
    return SingleChildScrollView(
      controller: widget.controller,
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separatorSize: DimensSize.d24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.browserEnterBasicAuthDescription.tr(
              args: [widget.host],
            ),
            style: StyleRes.primaryRegular,
          ),
          CommonInput(
            controller: _usernameController,
            titleText: LocaleKeys.browserEnterBasicAuthUsername.tr(),
            onSubmitted: (_) => _passwordFocusNode.requestFocus(),
          ),
          CommonInput(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            titleText: LocaleKeys.browserEnterBasicAuthPassword.tr(),
            onSubmitted: (_) => _onSignIn(),
            obscureText: true,
          ),
          CommonButton.primary(
            fillWidth: true,
            onPressed: _onSignIn,
            text: LocaleKeys.browserEnterBasicSignIn.tr(),
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
