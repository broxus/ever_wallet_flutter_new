import 'package:app/feature/browserV2/widgets/browser_resource_item/browser_resource_item_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserResourceItem
    extends ElementaryWidget<BrowserResourceItemWidgetModel> {
  const BrowserResourceItem({
    this.title,
    this.faviconUri,
    this.onPressed,
    this.subTitle,
    this.onLongPress,
    this.trailing,
    this.padding,
    super.key,
    WidgetModelFactory<BrowserResourceItemWidgetModel> wmFactory =
        defaultBrowserResourceItemWidgetModelFactory,
  }) : super(wmFactory);

  final String? title;
  final Uri? faviconUri;
  final String? subTitle;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BrowserResourceItemWidgetModel wm) {
    return StateNotifierBuilder<String?>(
      listenableState: wm.faviconUrlState,
      builder: (_, String? url) {
        return PressScaleWidget(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              color: wm.theme.colors.background1,
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
                        imageUrl: url ?? '',
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
                              style: wm.theme.textStyles.labelSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: DimensSizeV2.d2),
                            StateNotifierBuilder<String?>(
                              listenableState: wm.subTitleState,
                              builder: (_, String? subTitle) {
                                return subTitle == null
                                    ? const SizedBox.shrink()
                                    : Text(
                                        subTitle,
                                        style: wm.theme.textStyles.labelXSmall,
                                        overflow: TextOverflow.ellipsis,
                                      );
                              },
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
      },
    );
  }
}
