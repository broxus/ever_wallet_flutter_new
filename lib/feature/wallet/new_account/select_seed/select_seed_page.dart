import 'package:app/feature/wallet/new_account/select_seed/select_seed_view.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SelectSeedPage extends StatelessWidget {
  const SelectSeedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.selectSeed.tr(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: SelectSeedWidget(),
      ),
    );
  }
}
