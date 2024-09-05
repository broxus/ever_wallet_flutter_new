import 'package:app/data/models/models.dart';
import 'package:app/feature/network/network.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
                color: color ?? theme.colors.background2,
                width: DimensSizeV2.d40,
                height: DimensSizeV2.d40,
                child: Center(
                  child: NetworkIcon(type: data.networkType),
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
}
