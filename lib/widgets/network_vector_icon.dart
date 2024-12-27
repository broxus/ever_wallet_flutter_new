import 'package:app/generated/generated.dart';
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
    return url == null
        ? Assets.images.networkVectorDefault.svg(
            width: DimensSizeV2.d40,
            height: DimensSizeV2.d40,
          )
        : CachedSvg(
            url!,
            width: DimensSizeV2.d40,
            height: DimensSizeV2.d40,
          );
  }
}
