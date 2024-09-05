import 'package:app/feature/wallet/widgets/select_account/select_account_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<KeyAccount?> showSelectAccountSheet(BuildContext context) {
  return showCommonBottomSheet<KeyAccount>(
    context: context,
    title: LocaleKeys.selectAccount.tr(),
    centerTitle: true,
    expand: true,
    body: (_, scrollController) => SelectAccountWidget(
      scrollController: scrollController,
    ),
  );
}
