import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class AccountSettingsInfoCard extends StatelessWidget {
  const AccountSettingsInfoCard({
    required this.account,
    super.key,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(DimensSizeV2.d12),
            child: Center(
              child: BarcodeWidget(
                width: DimensSizeV2.d74,
                height: DimensSizeV2.d74,
                data: account.address.address,
                barcode: Barcode.qrCode(),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Flexible(child: _Detail(account: account)),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.account,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: theme.colors.borderAlpha,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _Item(
              titleText: LocaleKeys.addressWord.tr(),
              descriptionText: account.address.address,
              onPressed: () => _copyText(context, account.address.address),
            ),
          ),
          Divider(
            height: DimensStroke.small,
            thickness: DimensStroke.small,
            color: theme.colors.borderAlpha,
          ),
          Flexible(
            child: _Item(
              titleText: LocaleKeys.publicKey.tr(),
              descriptionText: account.publicKey.publicKey,
              onPressed: () => _copyText(context, account.publicKey.publicKey),
            ),
          ),
        ],
      ),
    );
  }

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(
      ClipboardData(text: text),
    );
    inject<MessengerService>().show(
      Message.successful(
        context: context,
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [text],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.titleText,
    required this.descriptionText,
    required this.onPressed,
  });

  final String titleText;
  final String descriptionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titleText,
              style: theme.textStyles.labelXSmall.copyWith(
                color: theme.colors.content3,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d4),
            RichText(
              text: TextSpan(
                style: theme.textStyles.labelXSmall,
                children: [
                  TextSpan(
                    text: descriptionText,
                  ),
                  const TextSpan(
                    text: ' ',
                  ),
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: Icon(
                      LucideIcons.copy,
                      size: DimensSizeV2.d18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
