import 'package:app/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AddSeedEnableBiometryView extends StatelessWidget {
  const AddSeedEnableBiometryView({
    required this.isFace,
    super.key,
  });

  final bool isFace;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

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
                color: colors.textPrimary,
              ),
              const SizedBox(height: DimensSize.d32),
              Text(
                isFace ? LocaleKeys.faceId.tr() : LocaleKeys.touchId.tr(),
                style: StyleRes.h1.copyWith(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSize.d12),
              Text(
                isFace
                    ? LocaleKeys.faceIdDescription.tr()
                    : LocaleKeys.touchIdDescription.tr(),
                style: StyleRes.primaryRegular.copyWith(
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.useSomething.tr(
            args: [
              if (isFace) LocaleKeys.faceId.tr() else LocaleKeys.touchId.tr()
            ],
          ),
          onPressed: () =>
              context.read<AddSeedEnableBiometryCubit>().requestBiometry(),
        ),
        CommonButton.secondary(
          text: LocaleKeys.noThanks.tr(),
          fillWidth: true,
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
