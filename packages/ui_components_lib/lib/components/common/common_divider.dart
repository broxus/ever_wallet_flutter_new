import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_divider}
///
/// Default divider of application, that is used to separate items in any list.
///
/// {@endtemplate}
class CommonDivider extends StatelessWidget {
  /// {@macro common_divider}
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.themeStyle.colors.strokeSecondary,
    );
  }
}
