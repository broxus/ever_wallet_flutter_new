import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [LocalizationSheet].
Future<void> showLocalizationSheet({
  required BuildContext context,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.chooseLanguage.tr(),
    body: (_, __) => BlocProvider(
      create: (context) => LocalizationBloc(inject<LocalizationService>()),
      child: const LocalizationSheet(),
    ),
  );
}

class LocalizationSheet extends StatelessWidget {
  const LocalizationSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    List<CommonListTile> children(SupportedLocaleCodes currentLocale) =>
        SupportedLocaleCodes.values
            .map(
              (code) => CommonListTile(
                onPressed: () {
                  context.read<LocalizationBloc>().add(
                        LocalizationEvent.changeLocaleCode(code: code),
                      );
                  Navigator.of(context).pop();
                },
                leading: CommonBackgroundedIconWidget.svg(
                  svg: code.iconPath,
                  backgroundColor: Colors.transparent,
                  useDefaultColor: false,
                ),
                titleText: code.localizedString.tr(),
                trailing: currentLocale == code
                    ? CommonIconWidget.svg(
                        svg: Assets.images.check.path,
                        color: colors.textPrimary,
                      )
                    : null,
                padding: EdgeInsets.zero,
              ),
            )
            .toList();

    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: children(state.localeCode),
        );
      },
    );
  }
}
