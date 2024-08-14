import 'package:app/feature/browser/approvals_listener/actions/widgets/website_info/website_info_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WebsiteInfoWidget extends ElementaryWidget<WebsiteInfoWidgetModel> {
  const WebsiteInfoWidget({
    required this.uri,
    Key? key,
    WidgetModelFactory wmFactory = defaultWebsiteInfoWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri uri;

  @override
  Widget build(WebsiteInfoWidgetModel wm) => PrimaryCard(
        color: wm.theme.colors.background2,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: SeparatedRow(
          children: [
            StateNotifierBuilder(
              listenableState: wm.faviconUrl,
              builder: (_, value) => value == null
                  ? CommonIconWidget.svg(svg: Assets.images.web.path)
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DimensRadiusV2.radius20),
                      child: CachedNetworkImage(
                        height: DimensSizeV2.d40,
                        width: DimensSizeV2.d40,
                        imageUrl: value,
                        placeholder: (_, __) =>
                            const CommonCircularProgressIndicator(),
                        errorWidget: (_, __, ___) => CommonIconWidget.svg(
                          svg: Assets.images.web.path,
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: SeparatedColumn(
                separatorSize: DimensSizeV2.d4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.website.tr(),
                    style: wm.theme.textStyles.labelXSmall.copyWith(
                      color: wm.theme.colors.content3,
                    ),
                  ),
                  Text(
                    uri.origin,
                    style: wm.theme.textStyles.labelSmall,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
