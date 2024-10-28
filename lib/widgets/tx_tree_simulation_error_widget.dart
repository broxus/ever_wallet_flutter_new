import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TxTreeSimulationErrorWidget extends StatelessWidget {
  const TxTreeSimulationErrorWidget({
    required this.txErrors,
    super.key,
  });

  final List<TxTreeSimulationErrorItem> txErrors;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.backgroundNegative,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      child: SeparatedRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.triangleAlert,
            size: DimensSizeV2.d20,
            color: theme.colors.contentNegative,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in txErrors) _ErrorMessage(item: item),
                Text(
                  LocaleKeys.txTreeSimulationErrorHint.tr(),
                  style: theme.textStyles.paragraphSmall.copyWith(
                    color: theme.colors.contentNegative,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorMessage extends StatefulWidget {
  const _ErrorMessage({
    required this.item,
  });

  final TxTreeSimulationErrorItem item;

  @override
  State<_ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<_ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final address = TextSpan(
      text: widget.item.address.toEllipseString(),
      style: theme.textStyles.paragraphSmall.copyWith(
        color: theme.colors.contentNegative1,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTap,
    );

    return RichText(
      text: TextSpan(
        style: theme.textStyles.paragraphSmall.copyWith(
          color: theme.colors.contentNegative,
        ),
        children: switch (widget.item.error.type) {
          TxTreeSimulationErrorType.computePhase => [
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorComputePhase_0.tr(),
              ),
              address,
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorComputePhase_1.tr(
                  args: [widget.item.error.code?.toString() ?? ''],
                ),
              ),
            ],
          TxTreeSimulationErrorType.actionPhase => [
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorActionPhase_0.tr(),
              ),
              address,
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorActionPhase_1.tr(
                  args: [widget.item.error.code?.toString() ?? ''],
                ),
              ),
            ],
          TxTreeSimulationErrorType.frozen => [
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorFrozen_0.tr(),
              ),
              address,
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorFrozen_1.tr(
                  args: [widget.item.error.code?.toString() ?? ''],
                ),
              ),
            ],
          TxTreeSimulationErrorType.deleted => [
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorDeleted_0.tr(),
              ),
              address,
              TextSpan(
                text: LocaleKeys.txTreeSimulationErrorDeleted_1.tr(
                  args: [widget.item.error.code?.toString() ?? ''],
                ),
              ),
            ],
        },
      ),
    );
  }

  void _onTap() {
    Clipboard.setData(ClipboardData(text: widget.item.address.address));
    inject<MessengerService>().show(
      Message.successful(
        context: context,
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [widget.item.address.toEllipseString()],
        ),
      ),
    );
  }
}
