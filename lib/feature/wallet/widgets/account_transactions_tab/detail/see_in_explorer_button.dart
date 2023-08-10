import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Button that allows navigating to browser to view information about
/// transaction.
class SeeInExplorerButton extends StatelessWidget {
  const SeeInExplorerButton({
    required this.transactionHash,
    super.key,
  });

  final String transactionHash;

  @override
  Widget build(BuildContext context) {
    return CommonButton.primary(
      text: LocaleKeys.seeInExplorer.tr(),
      fillWidth: true,
      leading: CommonButtonIconWidget.svg(svg: Assets.images.planetInner.path),
      onPressed: () {
        Navigator.of(context).pop();
        context.goNamed(
          AppRoute.browser.name,
          queryParameters: {
            browserUrlPathParam: inject<NekotonRepository>()
                .currentTransport
                .transactionExplorerLink(transactionHash),
          },
        );
      },
    );
  }
}
