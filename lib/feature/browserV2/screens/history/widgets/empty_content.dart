import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent.history({super.key}) : _isSearch = false;

  const EmptyContent.search({super.key}) : _isSearch = true;

  final bool _isSearch;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    // TODO(knightforce): temp realisation, before refactoring.
    return Transform.translate(
      offset: const Offset(0, -DimensSizeV2.d60),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isSearch)
              CommonIconWidget.svg(
                svg: Assets.images.searchEmpty.path,
                width: DimensSize.d56,
                height: DimensSize.d56,
              )
            else
              Icon(
                LucideIcons.clock,
                size: DimensSizeV2.d56,
                color: theme.colors.content3,
              ),
            const SizedBox(height: DimensSizeV2.d21),
            Text(
              _isSearch
                  ? LocaleKeys.browserHistoryEmptySearch.tr()
                  : LocaleKeys.browserHistoryEmpty.tr(),
              style: theme.textStyles.labelMedium.copyWith(
                color: theme.colors.content3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
