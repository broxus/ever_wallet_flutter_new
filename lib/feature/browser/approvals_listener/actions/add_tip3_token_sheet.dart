import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_tip3_token/add_tip3_token.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to add some token with [details] to
/// [account].
/// Returns true, if user agreed and false otherwise.
Future<bool> showAddTip3TokenSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required TokenContractAsset details,
}) async {
  final res = await showCommonBottomSheet<bool>(
    context: context,
    title: LocaleKeys.addAssetTitle.tr(),
    centerTitle: true,
    body: (context, scroll) => AddTip3TokenWidget(
      account: account,
      origin: origin,
      details: details,
      scrollController: scroll,
    ),
  );

  return res ?? false;
}
