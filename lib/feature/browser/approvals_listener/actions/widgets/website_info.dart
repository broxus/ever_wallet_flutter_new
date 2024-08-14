import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WebsiteInfo extends StatelessWidget {
  const WebsiteInfo({
    required this.uri,
    this.faviconUrl,
    super.key,
  });

  final Uri uri;
  final String? faviconUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      padding: const EdgeInsets.symmetric(
        vertical: DimensSizeV2.d12,
        horizontal: DimensSizeV2.d16,
      ),
      child: SeparatedRow(
        children: [
          if (faviconUrl == null)
            CommonIconWidget.svg(svg: Assets.images.web.path),
          if (faviconUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(DimensSizeV2.d40 / 2),
              child: CachedNetworkImage(
                height: DimensSizeV2.d40,
                width: DimensSizeV2.d40,
                imageUrl: faviconUrl!,
                placeholder: (_, __) => const CommonCircularProgressIndicator(),
                errorWidget: (_, __, ___) => CommonIconWidget.svg(
                  svg: Assets.images.web.path,
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
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                Text(
                  uri.origin,
                  style: theme.textStyles.labelSmall,
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
}
