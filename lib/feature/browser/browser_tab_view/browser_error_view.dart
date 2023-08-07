import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserErrorView extends StatelessWidget {
  const BrowserErrorView({
    required this.tab,
    required this.tabState,
    super.key,
  });
  final BrowserTab tab;
  final BrowserTabState tabState;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.browserErrorTitle.tr(),
                style: StyleRes.h2.copyWith(
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                tabState.errorMessage ?? LocaleKeys.browserErrorDefault.tr(),
                style: StyleRes.primaryBold.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
