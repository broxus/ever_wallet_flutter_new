import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Helper function that shows [VerifyCancelUnstakingSheet].
/// Returns true if user decided to cancel unstaking.
Future<bool> showVerifyCancelUnstakingSheet({
  required BuildContext context,
  required Currency stakeCurrency,
}) async {
  final res = await showCommonBottomSheet<bool>(
    context: context,
    title: LocaleKeys.cancelUnstakingCheckTitle.tr(),
    centerTitle: true,
    body: (_, __) => VerifyCancelUnstakingSheet(
      stakeCurrency: stakeCurrency,
    ),
  );

  return res ?? false;
}

class VerifyCancelUnstakingSheet extends StatelessWidget {
  const VerifyCancelUnstakingSheet({
    required this.stakeCurrency,
    super.key,
  });

  final Currency stakeCurrency;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d24,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.cancelUnstakingCheckSubtitle.tr(
            args: [stakeCurrency.symbol],
          ),
          style: theme.textStyles.paragraphMedium.copyWith(
            color: theme.colors.content3,
          ),
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.yesImSure.tr(),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
