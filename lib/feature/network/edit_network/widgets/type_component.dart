import 'package:app/feature/network/network.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TypeComponent extends StatelessWidget {
  const TypeComponent({
    required this.title,
    required this.currentConnectionType,
    required this.type,
    required this.onChanged,
    required this.editable,
    super.key,
  });

  final String title;
  final ConnectionType currentConnectionType;
  final ConnectionType type;
  final ValueChanged<ConnectionType> onChanged;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final onPressed = editable
        ? () {
            onChanged(type);
          }
        : null;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: DimensSizeV2.d56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: SeparatedRow(
            children: [
              Expanded(
                child: Text(title, style: theme.textStyles.labelSmall),
              ),
              if (currentConnectionType == type)
                const Icon(LucideIcons.check, size: DimensSizeV2.d20),
            ],
          ),
        ),
      ),
    );
  }
}
