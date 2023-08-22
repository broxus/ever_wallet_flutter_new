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
    final colors = context.themeStyle.colors;

    // Can't use CommonCard because it has fixed wigth
    return Material(
      shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
      clipBehavior: Clip.antiAlias,
      color: colors.backgroundSecondary,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSize.d12),
                    child: Text(
                      tab.url.toString(),
                      style:
                          StyleRes.addBold.copyWith(color: colors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
                CommonIconButton.svg(
                  svg: Assets.images.closeAnother.path,
                  buttonType: EverButtonType.ghost,
                  color: colors.textSecondary,
                  onPressed: onClosePressed,
                ),
              ],
            ),
            const CommonDivider(),
            Expanded(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                // ignore: no-magic-number
                maxHeight: 1000,
                child: Image.file(
                  File(tab.imageOrDefaultPath),
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
