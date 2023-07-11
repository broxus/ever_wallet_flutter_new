import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum SelectAddSeedType { create, import }

/// Helper function that shows [SelectAddSeedTypeSheet]
Future<SelectAddSeedType?> showSelectAddSeedTypeSheet(BuildContext context) {
  return showCommonBottomSheet<SelectAddSeedType>(
    context: context,
    title: LocaleKeys.addNewSeedPhrase.tr(),
    useAppBackgroundColor: true,
    body: (_, __) => const SelectAddSeedTypeSheet(),
  );
}

/// Widget that allows select type of seed phrase adding
class SelectAddSeedTypeSheet extends StatelessWidget {
  const SelectAddSeedTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        CommonListTile(
          onPressed: () => Navigator.of(context).pop(SelectAddSeedType.create),
          titleText: LocaleKeys.createNewSeed.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.plus.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          onPressed: () => Navigator.of(context).pop(SelectAddSeedType.import),
          titleText: LocaleKeys.importSeed.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.import.path,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
