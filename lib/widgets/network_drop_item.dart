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
    final theme = context.themeStyleV2;
    return Container(
      padding: const EdgeInsets.all(DimensSizeV2.d4),
      decoration: BoxDecoration(
        color: theme.colors.background1,
        borderRadius: BorderRadius.circular(DimensRadiusV2.theBiggest),
      ),
      child: Row(
        children: [
          NetworkIcon(
            type: networkType,
            itemSize: DimensSizeV2.d24,
            iconSize: DimensSizeV2.d12,
          ),
          const SizedBox(width: DimensSizeV2.d4),
          const Icon(
            LucideIcons.chevronDown,
            size: DimensSizeV2.d16,
          ),
        ],
      ),
    );
  }
}
