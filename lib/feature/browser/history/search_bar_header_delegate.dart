import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchBarHeaderDelegate({
    required this.controller,
  });
  static const _height = DimensSize.d56 + DimensSize.d16 + DimensSize.d16;

  TextEditingController controller;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSize.d16,
          vertical: DimensSize.d16,
        ),
        child: CommonInput(
          fillColor: colors.appBackground,
          autocorrect: false,
          hintText: LocaleKeys.browserSearch.tr(),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(DimensSize.d16),
            child: CommonIconWidget.svg(
              svg: Assets.images.search.path,
              color: colors.textSecondary,
              size: DimensSize.d20,
            ),
          ),
          controller: controller,
        ),
        // ),
      ),
    );
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
