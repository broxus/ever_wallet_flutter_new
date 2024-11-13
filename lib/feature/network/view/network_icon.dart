import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkIcon extends StatelessWidget {
  const NetworkIcon({
    required this.type,
    super.key,
  });

  final NetworkType type;

  String get _path => switch (type) {
        NetworkType.ever => Assets.images.networkEver.path,
        NetworkType.venom => Assets.images.networkVenom.path,
        NetworkType.tycho => Assets.images.networkTycho.path,
        NetworkType.custom => Assets.images.networkDefault.path,
      };

  Color get _bgColor => switch (type) {
        NetworkType.ever => ColorsResV2.p60,
        NetworkType.venom => const Color(0xFF4C5AF5),
        _ => ColorsResV2.p60,
      };

  EdgeInsetsGeometry? get _iconOffset => switch (type) {
        NetworkType.ever => const EdgeInsets.only(
            top: DimensSizeV2.d2,
            right: DimensSizeV2.d2,
          ),
        NetworkType.venom => const EdgeInsets.only(left: DimensSizeV2.d1),
        _ => null,
      };

  @override
  Widget build(BuildContext context) => ClipOval(
        child: Container(
          color: _bgColor,
          width: DimensSizeV2.d40,
          height: DimensSizeV2.d40,
          padding: _iconOffset,
          child: Center(
            child: SvgPicture.asset(
              _path,
              width: DimensSizeV2.d16,
              height: DimensSizeV2.d16,
            ),
          ),
        ),
      );
}
