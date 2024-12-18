import 'package:app/widgets/cached_svg.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkVectorIcon extends StatelessWidget {
  const NetworkVectorIcon(
    this.url, {
    super.key,
  });

  final String? url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensSizeV2.d32,
      height: DimensSizeV2.d32,
      child: Center(
        child: url == null
            ? null
            : CachedSvg(
                url!,
                width: DimensSizeV2.d16,
                height: DimensSizeV2.d16,
              ),
      ),
    );
  }
}
