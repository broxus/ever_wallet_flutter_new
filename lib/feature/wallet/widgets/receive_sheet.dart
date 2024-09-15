import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [ReceiveFundsSheet].
void showReceiveFundsSheet(
  BuildContext context,
  Address address,
) {
  showCommonBottomSheet<void>(
    context: context,
    title: LocaleKeys.addressToReceiveFunds.tr(),
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (_, __) => ReceiveFundsSheet(address: address),
  );
}

/// Sheet that allows user to receive funds to wallet with [address].
/// For TonWallet address must be [TonWallet.address], for TokenWallet
/// [TokenWallet.tokenAddress].
class ReceiveFundsSheet extends StatelessWidget {
  const ReceiveFundsSheet({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = theme.colors;
    final textStyles = theme.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShapedContainerColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          separatorSize: 0,
          margin: EdgeInsets.zero,
          color: colors.background2,
          children: [
            BarcodeWidget(
              margin: const EdgeInsets.symmetric(
                vertical: DimensSizeV2.d32,
              ),
              width: DimensSize.d148,
              height: DimensSize.d148,
              data: address.address,
              barcode: Barcode.qrCode(),
              color: colors.primaryA,
            ),
            Text(
              LocaleKeys.addressWord.tr(),
              style: textStyles.labelXSmall.copyWith(
                color: colors.content3,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d4),
            Text(
              address.address,
              style: textStyles.labelXSmall.copyWith(
                color: colors.content0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DimensSize.d12),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              onPressed: () => _copyAddress(context),
              title: LocaleKeys.copyWord.tr(),
              postfixIcon: LucideIcons.copy,
              isFullWidth: false,
              padding: const EdgeInsets.symmetric(
                vertical: DimensSizeV2.d12,
                horizontal: DimensSizeV2.d24,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d32),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d16),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          icon: LucideIcons.share2,
          title: LocaleKeys.shareWord.tr(),
          onPressed: () => Share.share(address.address),
        ),
      ],
    );
  }

  void _copyAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: address.address));
    inject<MessengerService>().show(
      Message.successful(
        context: context,
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [address.toEllipseString()],
        ),
      ),
    );
  }
}
