import 'package:app/data/models/models.dart';
import 'package:app/feature/network/network.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkItem extends StatelessWidget {
  const NetworkItem({
    required this.data,
    this.padding = const EdgeInsets.symmetric(
      vertical: DimensSizeV2.d12,
    ),
    this.trailing,
    this.color,
    this.onTap,
    super.key,
  });

  final ConnectionData data;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: padding,
        child: SeparatedRow(
          children: [
            ClipOval(
              child: Container(
                color: color ?? _getBgColor(),
                width: DimensSizeV2.d40,
                height: DimensSizeV2.d40,
                padding: _getIconOffset(),
                child: Center(
                  child: NetworkIcon(
                    type: data.networkType,
                    size: DimensSizeV2.d22,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                data.name,
                style: theme.textStyles.labelMedium.copyWith(
                  color: theme.colors.content0,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  Color _getBgColor() => switch (data.networkType) {
        NetworkType.ever => ColorsResV2.p60,
        NetworkType.venom => const Color(0xFF4C5AF5),
        _ => ColorsResV2.p60,
      };

  EdgeInsetsGeometry? _getIconOffset() => switch (data.networkType) {
        NetworkType.ever => const EdgeInsets.only(
            top: DimensSizeV2.d2,
            right: DimensSizeV2.d2,
          ),
        NetworkType.venom => const EdgeInsets.only(left: DimensSizeV2.d1),
        _ => null,
      };
}
