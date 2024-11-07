import 'package:app/feature/wallet/new_account/add_account/add_account_view.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.newAccount.tr(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: AddAccountView(),
      ),
    );
  }
}
