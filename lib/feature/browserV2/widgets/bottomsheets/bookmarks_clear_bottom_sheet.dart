import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<void> showBrowserClearBookmarksSheet({
  required BuildContext context,
  required VoidCallback onClearPressed,
}) {
  final theme = context.themeStyleV2;

  return showCommonBottomSheet(
    title: LocaleKeys.deleteBookmarksQuestion.tr(),
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    subtitle: LocaleKeys.deleteBookmarksDescription.tr(),
    subtitleStyle: theme.textStyles.paragraphMedium.copyWith(
      color: theme.colors.content3,
    ),
    centerTitle: true,
    context: context,
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d32,
      bottom: DimensSizeV2.d16,
      left: DimensSizeV2.d16,
      right: DimensSizeV2.d16,
    ),
    subtitleMargin: const EdgeInsets.only(
      bottom: DimensSizeV2.d16,
    ),
    centerSubtitle: true,
    body: (BuildContext context, __) => PrimaryButton(
      buttonShape: ButtonShape.pill,
      title: LocaleKeys.yesDeleteAll.tr(),
      onPressed: () {
        onClearPressed();
        Navigator.of(context).pop();
      },
    ),
  );
}
