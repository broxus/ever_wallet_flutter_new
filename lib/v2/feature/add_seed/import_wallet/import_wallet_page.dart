import 'package:app/v2/feature/add_seed/import_wallet/import_wallet.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

//screen import wallet
class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colors.background0,
      appBar: const DefaultAppBar(),
      body: const ImportWalletView(),
    );
  }
}
