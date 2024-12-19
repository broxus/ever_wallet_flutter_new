import 'package:app/feature/wallet/custodians_settings/custodians_settings_view.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CustodiansSettingsPage extends StatelessWidget {
  const CustodiansSettingsPage({required this.custodians, super.key});

  final List<String> custodians;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.custodiansWord.tr(),
        onClosePressed: (context) {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: CustodiansSettingsView(custodians: custodians),
      ),
    );
  }
}
