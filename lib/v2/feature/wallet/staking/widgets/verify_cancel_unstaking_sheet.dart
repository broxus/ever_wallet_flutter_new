import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [VerifyCancelUnstakingSheet].
/// Returns true if user decided to cancel unstaking.
Future<bool> showVerifyCancelUnstakingSheet(BuildContext context) async {
  final res = await showCommonBottomSheet<bool>(
    context: context,
    title: LocaleKeys.cancelUnstakingCheckTitle.tr(),
    body: (_, __) => const VerifyCancelUnstakingSheet(),
  );

  return res ?? false;
}

class VerifyCancelUnstakingSheet extends StatelessWidget {
  const VerifyCancelUnstakingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorSize: DimensSize.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.cancelUnstakingCheckSubtitle.tr(),
          style: StyleRes.primaryRegular.copyWith(
            color: context.themeStyle.colors.textPrimary,
          ),
        ),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.yesImSure.tr(),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
