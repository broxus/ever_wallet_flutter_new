import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkIcon extends StatelessWidget {
  const NetworkIcon({
    required this.type,
    this.size = DimensSizeV2.d16,
    this.color,
    super.key,
  });

  final NetworkType type;
  final double size;
  final Color? color;

  String get path => switch (type) {
        NetworkType.ever => Assets.images.networkEver.path,
        NetworkType.venom => Assets.images.networkVenom.path,
        NetworkType.custom => Assets.images.networkDefault.path,
      };

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(
          color ?? context.themeStyleV2.colors.content0,
          BlendMode.srcIn,
        ),
        width: size,
        height: size,
      );
}
