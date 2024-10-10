import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/displayable/bottom_sheet/bottom_sheet.dart';

Future<void> showSwitchToSeedSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => SwitchToSeedWidget(
      publicKey: publicKey,
    ),
  );
}
