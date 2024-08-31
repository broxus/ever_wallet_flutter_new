import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchBarHeaderDelegate({
    required this.controller,
  });

  static const double _height = DimensSizeV2.d90;

  TextEditingController controller;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = context.themeStyleV2.colors;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d16,
          ),
          child: PrimaryTextField(
            hintText: LocaleKeys.browserSearch.tr(),
            suffixes: [
              Padding(
                padding: const EdgeInsets.only(right: DimensSize.d20),
                child: CommonIconWidget.svg(
                  svg: Assets.images.search.path,
                  color: colors.content0,
                  width: DimensSize.d16,
                  height: DimensSize.d16,
                ),
              ),
            ],
          ),
        ),
      ],
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
