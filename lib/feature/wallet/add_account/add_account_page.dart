import 'package:app/feature/wallet/add_account/add_account.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({
    required this.publicKey,
    required this.password,
    super.key,
  });

  final String publicKey;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.newAccount.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: AddAccountTypeWidget(
          publicKey: PublicKey(publicKey: publicKey),
          password: password,
        ),
      ),
    );
  }
}
