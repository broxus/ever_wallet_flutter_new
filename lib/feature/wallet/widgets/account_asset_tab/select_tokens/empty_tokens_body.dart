import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EmptyTokensWidget extends StatelessWidget {
  const EmptyTokensWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d20),
        SvgPicture.asset(
          Assets.images.searchX.path,
          width: DimensSizeV2.d56,
        ),
        const SizedBox(height: DimensSizeV2.d12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: Text(
            LocaleKeys.emptyTokensDescriptionModal.tr(),
            style: theme.textStyles.paragraphSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d24),
      ],
    );
  }
}
