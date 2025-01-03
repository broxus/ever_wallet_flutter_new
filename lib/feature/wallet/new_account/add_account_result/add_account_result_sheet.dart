import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showNewAccountResultSheet({
  required BuildContext context,
  required Address address,
  bool isExternal = false,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => AddAccountResultWidget(
      address: address,
      isExternal: isExternal,
    ),
  );
}
