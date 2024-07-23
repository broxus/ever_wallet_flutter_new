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
        return SmallButton.secondary(
          leading: CommonButtonIconWidget.svg(
            svg: state.localeCode.iconPath,
            useDefaultColor: false,
          ),
          text: state.localeCode.localizedString.tr(),
          // ignore: no-empty-block
          onPressed: () => showLocalizationSheet(
            context: context,
          ),
        );
      },
    );
  }
}
