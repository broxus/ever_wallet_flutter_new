import 'package:flutter/material.dart';
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
  const CommonDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: _commonDividerSize,
      thickness: _commonDividerSize,
      color: color ?? context.themeStyle.colors.strokeSecondary,
    );
  }
}
