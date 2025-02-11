import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/adaptive_footer_single_child_scroll_view.dart';

/// View that allows confirm confirming transaction transaction by entering
/// password
class TonWalletConfirmTransactionConfirmView extends StatelessWidget {
  const TonWalletConfirmTransactionConfirmView({
    required this.recipient,
    required this.amount,
    required this.comment,
    required this.publicKey,
    required this.onPasswordEntered,
    this.transactionIdHash,
    this.account,
    this.money,
    this.fee,
    this.feeError,
    super.key,
  });

  final KeyAccount? account;
  final Money? money;
  final Address recipient;
  final BigInt amount;
  final BigInt? fee;
  final String? comment;

  final String? transactionIdHash;
  final String? feeError;

  final PublicKey publicKey;

  final ValueChanged<String> onPasswordEntered;

  @override
  Widget build(BuildContext context) {
    final isLoading = fee == null && feeError == null;

    return AdaptiveFooterSingleChildScrollView(
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d8,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
            ),
            child: EnterPasswordWidgetV2(
              publicKey: publicKey,
              title: LocaleKeys.confirm.tr(),
              isLoading: isLoading,
              isDisabled: feeError != null || fee == null,
              onPasswordEntered: onPasswordEntered,
            ),
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: DimensSizeV2.d12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (account != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                  bottom: DimensSizeV2.d16,
                ),
                child: AccountInfo(account: account!),
              ),
            TokenTransferInfoWidget(
              margin: const EdgeInsets.only(
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
              ),
              amount: money,
              recipient: recipient,
              fee: fee,
              feeError: feeError,
              comment: comment,
              transactionIdHash: transactionIdHash,
            ),
          ],
        ),
      ),
    );
  }
}
