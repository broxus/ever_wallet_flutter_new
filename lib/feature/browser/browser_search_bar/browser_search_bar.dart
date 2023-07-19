import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBar extends StatelessWidget {
  const BrowserSearchBar({
    required this.onSubmit,
    super.key,
  });
  final VoidCallback? onSubmit;

  static const height = DimensSize.d64;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSize.d16,
        ),
        child: SizedBox(
          height: height,
          child: Center(
            child: CommonInput(
              height: DimensSize.d40,
              autocorrect: false,
              hintText: LocaleKeys.browserSearchURL.tr(),
              prefixIcon: CommonIconWidget.svg(
                svg: Assets.images.search.path,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
