import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/widgets/network_icon.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkDropItem extends StatelessWidget {
  const NetworkDropItem({required this.data, super.key});

  final ConnectionData data;

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
        color: const Color(0x10FFFFFF), //move to constants
        borderRadius: BorderRadius.circular(DimensRadiusV2.theBiggest),
      ),
      child: Row(
        children: [
          NetworkIcon(
            group: data.group,
            itemSize: DimensSizeV2.d32,
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
