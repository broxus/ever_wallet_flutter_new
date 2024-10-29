import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SeedPhraseItemWidget extends StatelessWidget {
  const SeedPhraseItemWidget({
    required this.name,
    required this.isExpanded,
    super.key,
  });

  final String name;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Row(
      children: [
        const SizedBox(width: DimensSizeV2.d16),
        Icon(
          LucideIcons.lockKeyhole,
          color: theme.colors.content0,
          size: DimensSizeV2.d16,
        ),
        const SizedBox(width: DimensSizeV2.d12),
        Expanded(
          child: Text(
            name,
            style: theme.textStyles.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(
          isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
          color: theme.colors.content0,
          size: DimensSizeV2.d16,
        ),
        const SizedBox(width: DimensSizeV2.d16),
      ],
    );
  }
}
