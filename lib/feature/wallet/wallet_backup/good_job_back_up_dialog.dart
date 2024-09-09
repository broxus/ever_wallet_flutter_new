import 'package:app/app/router/app_route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showGoodJobDialog(BuildContext context) {
  showPrimaryBottomSheet(
    context: context,
    title: LocaleKeys.goodJobTitleModal.tr(),
    subtitle: LocaleKeys.goodJobSubtitleModal.tr(),
    assetsPath: Assets.images.circleCheck.path,
    firstButton: LayoutBuilder(
      builder: (context, constraints) {
        return AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.gotItButton.tr(),
          postfixIcon: LucideIcons.check,
          onPressed: context.maybePop,
        );
      },
    ),
  );
}
