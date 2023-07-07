import 'package:app/app/service/localization/localization.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        final icon = switch (state.localeCode) {
          SupportedLocaleCodes.en => Assets.images.langIcons.english.path,
          SupportedLocaleCodes.ko => Assets.images.langIcons.korean.path,
        };
        final text = switch (state.localeCode) {
          SupportedLocaleCodes.en => LocaleKeys.langEnglish.tr(),
          SupportedLocaleCodes.ko => LocaleKeys.langKorean.tr(),
        };
        return SmallButton.secondary(
          leading: CommonButtonIconWidget.svg(
            svg: icon,
          ),
          text: text,
          // ignore: no-empty-block
          onPressed: () {},
        );
      },
    );
  }
}
