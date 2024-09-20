import 'package:app/generated/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserResourceItem extends StatelessWidget {
  const BrowserResourceItem({
    this.title,
    this.faviconUrl,
    this.onPressed,
    this.subTitle,
    this.onLongPress,
    this.trailing,
    this.padding,
    super.key,
  });

  final String? title;
  final String? faviconUrl;
  final String? subTitle;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final themeStyleV2 = context.themeStyleV2;

    return PressScaleWidget(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: themeStyleV2.colors.background1,
          borderRadius: BorderRadius.circular(DimensSizeV2.d12),
        ),
        padding: padding ?? const EdgeInsets.all(DimensSizeV2.d8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    height: DimensSize.d40,
                    width: DimensSize.d40,
                    imageUrl: faviconUrl ?? '',
                    placeholder: (_, __) =>
                        const CommonCircularProgressIndicator(),
                    errorWidget: (_, __, ___) => CommonIconWidget.svg(
                      svg: Assets.images.web.path,
                    ),
                  ),
                  const SizedBox(width: DimensSizeV2.d8),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: themeStyleV2.textStyles.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: DimensSizeV2.d2),
                        if (subTitle != null)
                          Text(
                            subTitle!,
                            style: themeStyleV2.textStyles.labelXSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
