import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default thickness and height of [CommonDivider]
const _commonDividerSize = 1.0;

/// {@template common_divider}
///
/// Default divider of application, that is used to separate items in any list.
///
/// {@endtemplate}
class CommonDivider extends StatelessWidget {
  /// {@macro common_divider}
  const CommonDivider({
    super.key,
    this.color,
    this.margin = EdgeInsets.zero,
  });

  final Color? color;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Divider(
        height: _commonDividerSize,
        thickness: _commonDividerSize,
        color: color ?? context.themeStyleV2.colors.borderAlpha,
      ),
    );
  }
}

/// Default divider of application, that is used to separate items and header
/// sections in sliver lists.
class CommonSliverDividerHeaderDelegate extends SliverPersistentHeaderDelegate {
  CommonSliverDividerHeaderDelegate({this.color});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return CommonDivider(
      color: color,
    );
  }

  final Color? color;

  @override
  double get maxExtent => _commonDividerSize;

  @override
  double get minExtent => _commonDividerSize;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
