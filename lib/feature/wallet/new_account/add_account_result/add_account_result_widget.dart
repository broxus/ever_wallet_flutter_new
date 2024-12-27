import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddAccountResultWidget
    extends ElementaryWidget<AddAccountResultWidgetModel> {
  AddAccountResultWidget({
    required this.address,
    required this.isExternal,
    Key? key,
    WidgetModelFactory<AddAccountResultWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (context) => defaultAddAccountResultWidgetModelFactory(
                    context,
                    isExternal,
                  ),
          key: key,
        );

  final Address address;
  final bool isExternal;

  @override
  Widget build(AddAccountResultWidgetModel wm) {
    final theme = wm.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Image.asset(
          Assets.images.checkCircleFill.checkCircleFill.path,
          height: DimensSizeV2.d56,
          width: DimensSizeV2.d56,
        ),
        const SizedBox(height: DimensSizeV2.d16),
        Text(
          LocaleKeys.accountAddedSheetTitle.tr(),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Text(
          LocaleKeys.accountAddedSheetSubtitle.tr(),
          style: theme.textStyles.paragraphMedium.copyWith(
            color: theme.colors.content1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.accountAddedSheetSwitch.tr(),
          onPressed: wm.onSwitch,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.accountAddedSheetContinue.tr(),
          onPressed: wm.onContinue,
        ),
      ],
    );
  }
}
