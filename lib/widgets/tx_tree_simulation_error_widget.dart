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
import 'package:url_launcher/url_launcher.dart';

final _supportLink = Uri.parse('https://t.me/broxus_chat');

class TxTreeSimulationErrorWidget extends StatelessWidget {
  const TxTreeSimulationErrorWidget({
    required this.txErrors,
    required this.isConfirmed,
    required this.onConfirm,
    this.symbol,
    super.key,
  });

  final List<TxTreeSimulationErrorItem> txErrors;
  final bool isConfirmed;
  final ValueChanged<bool> onConfirm;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final canFixTxError = txErrors.any(
      (item) => item.error.code == -14 || item.error.code == -37,
    );

    return PrimaryCard(
      color: theme.colors.backgroundNegative,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      child: SeparatedColumn(
        separatorSize: DimensSizeV2.d16,
        mainAxisSize: MainAxisSize.min,
        children: [
          SeparatedRow(
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
                    Text(
                      LocaleKeys.txTreeSimulationErrorTitle.tr(),
                      style: theme.textStyles.labelSmall.copyWith(
                        color: theme.colors.contentNegative,
                      ),
                    ),
                    const SizedBox(height: DimensSizeV2.d8),
                    for (final item in txErrors) _ErrorMessage(item: item),
                    const SizedBox(height: DimensSizeV2.d8),
                    RichText(
                      text: TextSpan(
                        style: theme.textStyles.paragraphSmall.copyWith(
                          color: theme.colors.contentNegative,
                        ),
                        children: [
                          if (canFixTxError)
                            TextSpan(
                              text:
                                  LocaleKeys.txTreeSimulationErrorHintCanFix.tr(
                                args: [symbol ?? ''],
                              ),
                            )
                          else
                            TextSpan(
                              text: LocaleKeys.txTreeSimulationErrorHint.tr(),
                            ),
                          TextSpan(
                            text: LocaleKeys.txTreeSimulationErrorSupportLink
                                .tr(),
                            style: theme.textStyles.paragraphSmall.copyWith(
                              color: theme.colors.contentNegative1,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(
                                  _supportLink,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.txTreeSimulationErrorSwitchLabel.tr(),
                  style: theme.textStyles.labelSmall.copyWith(
                    color: theme.colors.contentNegative,
                  ),
                ),
              ),
              Switch(value: isConfirmed, onChanged: onConfirm),
            ],
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
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d4),
            child: Icon(
              LucideIcons.copy,
              size: DimensSizeV2.d16,
              color: theme.colors.contentNegative1,
            ),
          ),
        ),
      ],
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
