import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_existing_wallet/view/add_existing_wallet_view.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

//screen Add an existing wallet
class AddExistingWalletPage extends StatelessWidget {
  const AddExistingWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: theme.colors.background0,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.blurBackground.path),
                fit: BoxFit.cover,
              ),
            ),
            child: const AddExistingWalletView(),
          ),
        ),
        DefaultAppBar(
          onClosePressed: (context) => context.maybePop(),
        ),
      ],
    );
  }
}
