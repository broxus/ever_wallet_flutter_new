import 'package:app/di/di.dart';
import 'package:app/feature/browser/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletTransactionDetailsBodyWithExplorerButton extends StatelessWidget {
  const WalletTransactionDetailsBodyWithExplorerButton({
    required this.body,
    required this.transactionHash,
    this.action,
    super.key,
  });

  /// Content of transaction
  final Widget body;

  /// Hash of transaction that is used to open explorer in browser
  final String transactionHash;

  /// Action that can add behavior for transaction
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: DimensSize.d16 +
                    commonButtonHeight +
                    DimensSize.d8 +
                    (action == null ? 0 : commonButtonHeight + DimensSize.d8),
              ),
              child: body,
            ),
          ),
        ),
        Positioned(
          bottom: DimensSize.d32,
          left: DimensSize.d16,
          right: DimensSize.d16,
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action != null) action!,
              PrimaryButton(
                title: LocaleKeys.seeInExplorer.tr(),
                icon: LucideIcons.globe,
                onPressed: () {
                  Navigator.of(context).pop();
                  browserNewTab(
                    context,
                    inject<NekotonRepository>()
                        .currentTransport
                        .transactionExplorerLink(transactionHash),
                  );
                },
                buttonShape: ButtonShape.pill,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
