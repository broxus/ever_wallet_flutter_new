import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class Toast extends StatelessWidget {
  const Toast({
    required this.type,
    this.icon,
    this.description,
    this.isShowingIcon = true,
    this.heading,
    this.actions,
    this.onTapClosed,
    this.topMargin,
    super.key,
  });

  final ToastType type;
  final IconData? icon;
  final String? description;
  final bool isShowingIcon;
  final String? heading;
  final List<Widget>? actions;
  final VoidCallback? onTapClosed;
  final double? topMargin;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final toastStyle = _getToastStyleByType(themeStyle);
    return Container(
      margin: topMargin != null
          ? EdgeInsets.only(top: topMargin!)
          : EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d12,
      ),
      decoration: BoxDecoration(
        color: toastStyle.backgroundColor,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        border: Border.all(color: toastStyle.borderColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: DimensSize.d20,
                  color: toastStyle.iconColor,
                ),
              const SizedBox(width: DimensSize.d8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (heading != null)
                      Text(
                        heading!,
                        style: themeStyle.textStyles.headingXSmall
                            .copyWith(height: 1.5),
                      ),
                    if (description != null)
                      Text(
                        description!,
                        style: themeStyle.textStyles.paragraphSmall
                            .copyWith(color: themeStyle.colors.content0),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTapClosed,
                child: Icon(
                  LucideIcons.x,
                  size: DimensSize.d20,
                  color: themeStyle.colors.content0,
                ),
              ),
            ],
          ),
          if (actions?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: DimensSizeV2.d16),
              child: Row(
                children: [
                  for (final action in actions!)
                    Expanded(
                      child: action,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  ToastStyle _getToastStyleByType(ThemeStyleV2 theme) {
    switch (type) {
      case ToastType.normal:
        return ToastStyle.normal(theme.colors);
      case ToastType.error:
        return ToastStyle.error(theme.colors);
      case ToastType.warning:
        return ToastStyle.warning(theme.colors);
      case ToastType.success:
        return ToastStyle.success(theme.colors);
    }
  }
}
