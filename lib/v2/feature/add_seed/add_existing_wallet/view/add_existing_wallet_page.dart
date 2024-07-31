import 'package:app/v2/feature/add_seed/add_existing_wallet/view/view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

//screen Add an existing wallet
class AddExistingWalletPage extends StatelessWidget {
  const AddExistingWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colors.background0,
      appBar: const DefaultAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/blur_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const AddExistingWalletView(),
      ),
    );
  }
}
