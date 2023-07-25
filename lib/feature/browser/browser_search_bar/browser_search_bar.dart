import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBar extends StatelessWidget {
  const BrowserSearchBar({
    this.uri,
    this.onSubmitted,
    super.key,
  });
  final Uri? uri;
  final ValueChanged<String?>? onSubmitted;

  static const height = DimensSize.d64;

  @override
  Widget build(BuildContext context) {
    // final colors = context.themeStyle.colors;
    return BrowserSearchBarInput(
      uri: uri,
      hintText: LocaleKeys.browserSearchURL.tr(),
      cancelText: LocaleKeys.browserSearchURLCancel.tr(),
      onSubmitted: onSubmitted,
    );
  }
}
