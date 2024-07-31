import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

class AddSeedEnableBiometryView extends StatelessWidget {
  const AddSeedEnableBiometryView({
    required this.isFace,
    super.key,
  });

  final bool isFace;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSize.d12,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonIconWidget.svg(
                svg: isFace
                    ? Assets.images.faceId.path
                    : Assets.images.finger.path,
                size: DimensSize.d72,
                color: theme.colors.content0,
              ),
              const SizedBox(height: DimensSize.d32),
              Text(
                isFace ? LocaleKeys.faceId.tr() : LocaleKeys.touchId.tr(),
                style: theme.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSize.d8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
                child: Text(
                  isFace
                      ? LocaleKeys.faceIdContent.tr()
                      : LocaleKeys.touchIdContent.tr(),
                  style: theme.textStyles.paragraphMedium
                      .copyWith(color: theme.colors.content1),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        AccentButton(
          title: LocaleKeys.useSomething.tr(
            args: [
              if (isFace) LocaleKeys.faceId.tr() else LocaleKeys.touchId.tr(),
            ],
          ),
          onPressed: () =>
              context.read<AddSeedEnableBiometryCubit>().requestBiometry(),
          buttonShape: ButtonShape.pill,
        ),
        PrimaryButton(
          title: LocaleKeys.noThanks.tr(),
          buttonShape: ButtonShape.pill,
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
