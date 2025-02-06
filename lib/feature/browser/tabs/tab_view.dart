import 'dart:io';

import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TabView extends StatelessWidget {
  const TabView({
    required this.tab,
    super.key,
    this.onPressed,
    this.onClosePressed,
  });

  final BrowserTab tab;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    // Can't use CommonCard because it has fixed wigth
    return Material(
      shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
      clipBehavior: Clip.antiAlias,
      color: colors.background1,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            _Header(
              urlPath: tab.url.toString(),
              onPressedClose: onClosePressed,
            ),
            if (tab.imageOrDefaultPath != null)
              Expanded(
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  // ignore: no-magic-number
                  maxHeight: 1000,
                  child: Image.file(
                    File(tab.imageOrDefaultPath!),
                    fit: BoxFit.scaleDown,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.urlPath,
    this.onPressedClose,
  });

  final String urlPath;
  final VoidCallback? onPressedClose;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final textStyles = themeStyle.textStyles;
    final colors = context.themeStyleV2.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.borderAlpha),
          left: BorderSide(color: colors.borderAlpha),
          right: BorderSide(color: colors.borderAlpha),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DimensRadiusV2.radius16),
          topRight: Radius.circular(DimensRadiusV2.radius16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: DimensSizeV2.d12),
              child: Text(
                urlPath,
                style: textStyles.labelXSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressedClose,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DimensSizeV2.d11,
                horizontal: DimensSizeV2.d15,
              ),
              child: CommonIconWidget.svg(
                svg: Assets.images.closeAnother.path,
                size: DimensSizeV2.d20,
                color: colors.content3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
