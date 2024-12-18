import 'package:app/app/service/connection/presets_connection_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/cached_svg.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkIcon extends StatefulWidget {
  const NetworkIcon({
    required this.type,
    super.key,
  });

  final String type;

  @override
  State<NetworkIcon> createState() => _NetworkIconState();
}

class _NetworkIconState extends State<NetworkIcon> {
  final _presetsConnectionService = inject<PresetsConnectionService>();

  String get _type => widget.type;

  String? get _path {
    return _presetsConnectionService.getTransportIconsByNetwork(_type).network;
  }

  Color get _bgColor => switch (_type) {
        'venom' => const Color(0xFF4C5AF5),
        _ => Colors.transparent,
      };

  EdgeInsetsGeometry? get _iconOffset => switch (_type) {
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
          child: _path == null
              ? Assets.images.networkDefault.svg()
              : CachedSvg(
                  _path!,
                  width: DimensSizeV2.d16,
                  height: DimensSizeV2.d16,
                ),
        ),
      );
}
