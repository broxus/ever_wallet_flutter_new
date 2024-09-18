import 'package:app/generated/generated.dart';
import 'package:app/widgets/barcode_address.dart';
import 'package:flutter/material.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BarcodeAddress(
          address: address,
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
}
