import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [ReceiveFundsSheet].
void showReceiveFundsSheet(
  BuildContext context,
  Address address,
) {
  showCommonBottomSheet<void>(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.addressToReceiveFunds.tr(),
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
    final colors = context.themeStyle.colors;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d24,
      children: [
        ShapedContainerColumn(
          margin: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          separatorSize: 0,
          children: [
            BarcodeWidget(
              margin: const EdgeInsets.all(DimensSize.d32),
              width: DimensSize.d148,
              height: DimensSize.d148,
              data: address.address,
              barcode: Barcode.qrCode(),
              color: colors.textPrimary,
            ),
            SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              separatorSize: DimensSize.d4,
              children: [
                Text(
                  LocaleKeys.addressWord.tr(),
                  style: StyleRes.addRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  address.address,
                  style: StyleRes.addRegular.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: DimensSize.d8),
                SmallButton.ghost(
                  onPressed: _copyAddress,
                  text: LocaleKeys.copyWord.tr(),
                  leading: CommonButtonIconWidget.svg(
                    svg: Assets.images.copy.path,
                  ),
                ),
              ],
            ),
          ],
        ),
        CommonButton.primary(
          fillWidth: true,
          leading: CommonButtonIconWidget.svg(
            svg: Assets.images.share.path,
          ),
          text: LocaleKeys.shareWord.tr(),
          onPressed: () => Share.share(address.address),
        ),
      ],
    );
  }

  void _copyAddress() {
    Clipboard.setData(ClipboardData(text: address.address));
    inject<MessengerService>().show(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [address.toEllipseString()],
        ),
      ),
    );
  }
}
