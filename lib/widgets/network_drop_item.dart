import 'package:app/data/models/network_type.dart';
import 'package:app/feature/network/view/network_icon.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkDropItem extends StatelessWidget {
  const NetworkDropItem({required this.networkType, super.key});

  final NetworkType networkType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: DimensSizeV2.d4,
        top: DimensSizeV2.d4,
        bottom: DimensSizeV2.d4,
        right: DimensSizeV2.d8,
      ),
      decoration: BoxDecoration(
        color: Color(0x10FFFFFF),//TODO(new style material)
        borderRadius: BorderRadius.circular(DimensRadiusV2.theBiggest),
      ),
      child: Row(
        children: [
          NetworkIcon(
            type: networkType,
            itemSize: 32,
            iconSize: DimensSizeV2.d14,
          ),
          const SizedBox(width: DimensSizeV2.d4),
          const Icon(
            LucideIcons.chevronDown,
            size: DimensSizeV2.d20,
          ),
        ],
      ),
    );
  }
}
