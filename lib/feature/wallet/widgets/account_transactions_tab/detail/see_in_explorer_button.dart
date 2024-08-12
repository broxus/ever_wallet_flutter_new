import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Button that allows navigating to browser to view information about
/// transaction.
class SeeInExplorerButton extends StatelessWidget {
  const SeeInExplorerButton({
    required this.transactionHash,
    this.isSecondary = false,
    super.key,
  });

  final String transactionHash;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      buttonType:
          isSecondary ? EverButtonType.secondary : EverButtonType.primary,
      text: LocaleKeys.seeInExplorer.tr(),
      leading: CommonButtonIconWidget.svg(svg: Assets.images.planetInner.path),
      onPressed: () {
        Navigator.of(context).pop();
        browserNewTab(
          context,
          inject<NekotonRepository>()
              .currentTransport
              .transactionExplorerLink(transactionHash),
        );
      },
    );
  }
}
