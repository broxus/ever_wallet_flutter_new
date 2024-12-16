import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkIcon extends StatelessWidget {
  const NetworkIcon({
    required this.type,
    super.key,
  });

  final String type;

  /// TODO replace
  String get _path {
    switch (type) {
      case 'ever':
        return Assets.images.networkEver.path;
      case 'venom':
        return Assets.images.networkVenom.path;
      case 'tycho':
        return Assets.images.networkTycho.path;
      case 'custom':
        return Assets.images.networkDefault.path;
    }

    return '';
  }

  Color get _bgColor => switch (type) {
        'ever' => ColorsResV2.p60,
        'venom' => const Color(0xFF4C5AF5),
        _ => ColorsResV2.p60,
      };

  EdgeInsetsGeometry? get _iconOffset => switch (type) {
        'ever' => const EdgeInsets.only(
            top: DimensSizeV2.d2,
            right: DimensSizeV2.d2,
          ),
        'venom' => const EdgeInsets.only(left: DimensSizeV2.d1),
        _ => null,
      };

  @override
  Widget build(BuildContext context) => ClipOval(
        child: Container(
          color: _bgColor,
          width: DimensSizeV2.d40,
          height: DimensSizeV2.d40,
          padding: _iconOffset,
          child: switch (type) {
            'tycho' => SvgPicture.asset(_path),
            _ => Center(
                child: SvgPicture.asset(
                  _path,
                  width: DimensSizeV2.d16,
                  height: DimensSizeV2.d16,
                ),
              ),
          },
        ),
      );
}
