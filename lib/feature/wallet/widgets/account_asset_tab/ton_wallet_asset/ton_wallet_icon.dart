import 'package:cached_network_image/cached_network_image.dart';
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
      if (uri.path.endsWith('.svg')) {
        return SvgPicture.network(
          path,
          placeholderBuilder: (_) => CommonLoader(
            width: size,
            height: size,
            borderRadius: DimensRadius.max,
          ),
          width: size,
          height: size,
        );
      } else {
        return CachedNetworkImage(
          height: size,
          width: size,
          imageUrl: path,
          placeholder: (_, __) => CommonLoader(
            width: size,
            height: size,
            borderRadius: DimensRadius.max,
          ),
        );
      }
    }

    return SvgPicture.asset(
      path,
      placeholderBuilder: (_) => CommonLoader(
        width: size,
        height: size,
        borderRadius: DimensRadius.max,
      ),
      width: size,
      height: size,
    );
  }
}
