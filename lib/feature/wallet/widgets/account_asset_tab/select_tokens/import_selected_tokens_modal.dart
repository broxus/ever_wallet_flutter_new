import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

Future<void> showImportSelectedTokensModal(
  BuildContext context,
  VoidCallback onClickConfirm,
) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.importSelectedTokensLabel.tr(),
    centerTitle: true,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (_, scrollController) => _ImportSelectedTokensWidget(
      onClickConfirm: onClickConfirm,
    ),
  );
}

class _ImportSelectedTokensWidget extends StatelessWidget {
  const _ImportSelectedTokensWidget({required this.onClickConfirm});

  final VoidCallback onClickConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.selectedTokensBeImportedInfo.tr(),
          style: theme.textStyles.paragraphSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.confirm.tr(),
          onPressed: () {
            onClickConfirm();
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(height: DimensSizeV2.d12),
      ],
    );
  }
}
