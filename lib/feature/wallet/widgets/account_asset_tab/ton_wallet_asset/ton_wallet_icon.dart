import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that is able to display icon for TonWallet
class TonWalletIconWidget extends StatelessWidget {
  const TonWalletIconWidget({
    required this.path,
    super.key,
  });

  /// Can be asset path or network url
  final String path;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(path);

    if (uri.hasScheme) {
      return SvgPicture.network(
        path,
        width: DimensSize.d40,
        height: DimensSize.d40,
      );
    }

    return SvgPicture.asset(
      path,
      width: DimensSize.d40,
      height: DimensSize.d40,
    );
  }
}
