import 'package:app/app/service/connection/presets_connection_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/cached_svg.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NetworkIcon extends StatefulWidget {
  const NetworkIcon({
    required this.type,
    this.itemSize,
    super.key,
  });

  final String type;
  final double? itemSize;

  @override
  State<NetworkIcon> createState() => _NetworkIconState();
}

class _NetworkIconState extends State<NetworkIcon> {
  final _presetsConnectionService = inject<PresetsConnectionService>();

  String get _type => widget.type;

  String? get _path {
    return _presetsConnectionService.getTransportIconsByNetwork(_type).network;
  }

  @override
  Widget build(BuildContext context) => ClipOval(
        child: _path == null
            ? Assets.images.networkDefault.svg(
                width: widget.itemSize ?? DimensSizeV2.d40,
                height: widget.itemSize ?? DimensSizeV2.d40,
              )
            : CachedSvg(
                _path!,
                width: widget.itemSize ?? DimensSizeV2.d40,
                height: widget.itemSize ?? DimensSizeV2.d40,
                errorWidget: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4C5AF5),
                  ),
                  width: widget.itemSize ?? DimensSizeV2.d40,
                  height: widget.itemSize ?? DimensSizeV2.d40,
                ),
              ),
      );
}
