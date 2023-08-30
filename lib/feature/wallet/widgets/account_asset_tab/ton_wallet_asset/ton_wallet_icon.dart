import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that is able to display icon for TonWallet
class TonWalletIconWidget extends StatelessWidget {
  const TonWalletIconWidget({
    required this.path,
    this.size = DimensSize.d40,
    super.key,
  });

  /// Can be asset path or network url
  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(path);

    if (uri.hasScheme) {
      return SvgPicture.network(
        path,
        placeholderBuilder: (_) => const CommonCircularProgressIndicator(),
        width: size,
        height: size,
      );
    }

    return SvgPicture.asset(
      path,
      placeholderBuilder: (_) => const CommonCircularProgressIndicator(),
      width: size,
      height: size,
    );
  }
}
